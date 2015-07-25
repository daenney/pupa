#!/usr/bin/env rspec
require 'spec_helper'

describe 'profile::pupa::users' do
  describe 'user with single ssh key of type' do
      context 'string' do
        let(:params) {{
          :humans => {
              'daenney' => {
                'ssh_authorized_keys' => 'nom nom key'
              }
          }
        }}
        it { is_expected.to contain_user('daenney') }
        it { is_expected.to contain_ssh_authorized_key('daenney_0').with({
          :user => 'daenney',
          :type => 'ssh-rsa',
          :key  => 'nom nom key',
        })}
      end

      context 'hash' do
        let(:params) {{
          :humans => {
              'daenney' => {
                'ssh_authorized_keys' => {
                  'type' => 'ssh-rsa',
                  'key'  => 'nom nom key',
                }
              }
            }
        }}
        it { is_expected.to contain_user('daenney') }
        it { is_expected.to contain_ssh_authorized_key('daenney_0').with({
          :user => 'daenney',
          :type => 'ssh-rsa',
          :key  => 'nom nom key',
        })}
      end

      context 'hash with undesired key type' do
        let(:params) {{
          :humans => {
              'daenney' => {
                'ssh_authorized_keys' => {
                  'type' => 'ssh-dss',
                  'key'  => 'nom nom key',
                }
              }
            }
        }}
        it do
          expect {
            subject.call
          }.to raise_error(Puppet::Error, /SSH \(EC\)DSA/)
        end
      end
  end

  describe 'user with array of keys of type' do
    context 'string' do
      let(:params) {{
        :humans => {
            'daenney' => {
              'ssh_authorized_keys' => ['nom nom key', 'nom nom second key']
            }
        }
      }}
      it { is_expected.to contain_user('daenney') }
      it { is_expected.to contain_ssh_authorized_key('daenney_0').with({
        :user => 'daenney',
        :type => 'ssh-rsa',
        :key  => 'nom nom key',
      })}
      it { is_expected.to contain_ssh_authorized_key('daenney_1').with({
        :user => 'daenney',
        :type => 'ssh-rsa',
        :key  => 'nom nom second key',
      })}
    end

    context 'hash' do
      let(:params) {{
        :humans => {
            'daenney' => {
              'ssh_authorized_keys' => [
                {
                  'type' => 'ssh-rsa',
                  'key'  => 'nom nom key',
                },
                {
                  'type' => 'ed25519',
                  'key'  => 'nom nom second key',
                },
              ]
            }
          }
      }}
      it { is_expected.to contain_user('daenney') }
      it { is_expected.to contain_ssh_authorized_key('daenney_0').with({
        :user => 'daenney',
        :type => 'ssh-rsa',
        :key  => 'nom nom key',
      })}
      it { is_expected.to contain_ssh_authorized_key('daenney_1').with({
        :user => 'daenney',
        :type => 'ed25519',
        :key  => 'nom nom second key',
      })}
    end

    context 'string and hash' do
      let(:params) {{
        :humans => {
            'daenney' => {
              'ssh_authorized_keys' => [{
                'type' => 'ed25519',
                'key'  => 'nom nom key',
                },
                'nom nom second key',
              ]
            }
          }
      }}
      it { is_expected.to contain_user('daenney') }
      it { is_expected.to contain_ssh_authorized_key('daenney_0').with({
        :user => 'daenney',
        :type => 'ed25519',
        :key  => 'nom nom key',
      })}
      it { is_expected.to contain_ssh_authorized_key('daenney_1').with({
        :user => 'daenney',
        :type => 'ssh-rsa',
        :key  => 'nom nom second key',
      })}
    end

    context 'string and hash with undesired key type' do
      let(:params) {{
        :humans => {
            'daenney' => {
              'ssh_authorized_keys' => [{
                'type' => 'dsa',
                'key'  => 'nom nom key',
                },
                'nom nom second key',
              ]
            }
          }
      }}
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /SSH \(EC\)DSA/)
      end
    end
  end
end
