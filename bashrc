alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias nsflush="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias assh="ssh -A ec2-user@54.200.15.29"
function issh() { ssh AIS_SERVICES\\phohberg@$1; }
function dssh() { ssh ITSDEV\\phohberg@$1; }
function lookup() {
               nslookup $1 164.67.132.150
               nslookup $1 164.67.132.42
               nslookup $1 164.67.132.101
               nslookup $1 164.67.134.3
}
function crtreq() { openssl req -config ~/Certs/openssl.conf -nodes -newkey rsa:2048 -sha256 -keyout $1.key -days 1095 -out $1.csr; }
function csrchk() { openssl req -text -noout -verify -in $1; }
function keychk() { openssl rsa -in $1 -check; }
function crtchk() { openssl x509 -in $1 -text -noout; }
function sslchk() { openssl s_client -servername $1 -connect $1:$2 -showcerts </dev/null 2>/dev/null | openssl x509 -text -in /dev/stdin; }
function chnchk() { openssl s_client -servername $1 -connect $1:$2 -showcerts </dev/null 2>/dev/null; }
complete -C '~/Library/Python/3.6/bin/aws_completer' aws
