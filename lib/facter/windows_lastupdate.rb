Facter.add( :last_update ) do
  confine :kernel => "windows"
  setcode do
    output = Facter::Util::Resolution.exec(
      'reg query \'HKLM\SOFTWARE\Microsoft\Windows' +
      '\CurrentVersion\WindowsUpdate\Auto Update\Results\Install\'' +
      ' /v LastSuccessTime'
    ).strip
    date, time = output.split(/\s+/)[2,3]
    year, month, day = date.split('-')
    hour, minute, second = time.split(':')
    local = Time.local(year, month, day, hour, minute, second)

    return local.utc.to_s
  end
end
