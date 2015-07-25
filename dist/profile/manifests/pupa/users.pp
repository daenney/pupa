# This can deal with users that look like:
#
#  daenney:
#    ensure: present
#    expiry: absent
#    gid: daenney
#    home: '/home/daenney'
#    managehome: true
#    uid: 1000
#    password: '$6$salt$string hashed password'
#    ssh_authorized_keys: 'string'
#
# ssh_authorized_keys can be:
# * A single value (we assume an RSA key)
# * A hash with at least the key attribute and any other valid attribute
# * An array of (or combination of):
#   * Single value string
#   * Hash with at least the key attribute and any other valid attribute
#
class profile::pupa::users (
  $humans      = hiera_hash('humans', {}),
  $terminators = hiera_hash('terminators', {}),
) {

  $accounts       = merge($humans, $terminators)
  $non_user_attrs = ['ssh_authorized_keys']

  $accounts.each | String $username, Hash $attrs | {
    if $attrs['gid'] { # lint:ignore:variable_scope
      group { $username:
        gid    => $attrs['uid'], # lint:ignore:variable_scope
        system => $attrs['system'], #lint:ignore:variable_scope
      }
    }

    user { $username:
      purge_ssh_keys => true,
      *              => $attrs.filter | $key, $value | { # lint:ignore:variable_scope
        !($key in $non_user_attrs) # lint:ignore:variable_scope
      }
    }

    $ssh_auth_keys = $attrs['ssh_authorized_keys'] # lint:ignore:variable_scope
    case $ssh_auth_keys {
      Undef: { $_ssh_auth_keys = [] } # lint:ignore:unquoted_string_in_case
      Array: { $_ssh_auth_keys = $ssh_auth_keys } # lint:ignore:unquoted_string_in_case
      Hash: { $_ssh_auth_keys = [$ssh_auth_keys] } # lint:ignore:unquoted_string_in_case
      String: { $_ssh_auth_keys = [$ssh_auth_keys] } # lint:ignore:unquoted_string_in_case
      default: { fail('ssh_authorized_keys can only be: String, Array, Hash or unset') }
    }

    $_ssh_auth_keys.each | Integer $index, Variant[String, Hash] $value | {
      case $value { # lint:ignore:case_without_default
        String: { # lint:ignore:unquoted_string_in_case
          ssh_authorized_key { "${username}_${index}": # lint:ignore:variable_scope
            user => $username, # lint:ignore:variable_scope
            type => 'ssh-rsa',
            key  => $value,
          }
        }
        Hash: { # lint:ignore:unquoted_string_in_case
          ssh_authorized_key { "${username}_${index}": # lint:ignore:variable_scope
            user => $username, # lint:ignore:variable_scope
            *    => $value
          }
        }
      }
    }
  }
}
