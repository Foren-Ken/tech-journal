param (
  [string]$netprefix,
  [string]$DNS
)

foreach ($ending in 1..254) {
  $result = (Resolve-DnsName -DnsOnly $netprefix"."$ending -Server 192.168.4.4 -ErrorAction Ignore).NameHost
  if ($result) {
    Write-Output "$netprefix. $ending $result"
  }
}
