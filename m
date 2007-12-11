From: Johannes Berg <johannes@sipsolutions.net>
Subject: cpu frequency governor regression (?)
Date: Tue, 11 Dec 2007 19:52:45 +0100
Message-ID: <1197399165.2214.15.camel__24124.8549697504$1197479701$gmane$org@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0094240883749155931=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: davej <davej@codemonkey.org.uk>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.linux-foundation.org>, cpufreq <cpufreq@lists.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============0094240883749155931==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BCd81Bk+7cjcOhQgKH//"


--=-BCd81Bk+7cjcOhQgKH//
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

No idea who to bother with this and maybe it's just a
misconfiguration... Apologies if my guesses are totally wrong.

I'm currently on 2.6.24-rc3 (+wireless-2.6#everything) but couldn't find
any patches between that and 2.6.24-rc5 that seemed relevant.

On my quad powermac, I'm seeing the cpufreq governor changed by a
hibernation cycle. My default governor is "userspace", which is driven
by powernowd (because the latency is too high "ondemand" doesn't like my
machine) but after a hibernation cycle I'm having the governor set to
"performance".

I have no idea what code is resetting this and why this would happen,
maybe the fact that the CPUs are taken offline/online again is
responsible? It's well possible that there's a bug in our cpufreq driver
though I thought I fixed the multi-cpu issues it had. Any help would be
appreciated.

johannes

--=-BCd81Bk+7cjcOhQgKH//
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR17ce6Vg1VMiehFYAQJfNBAAj8s1WeArBwqznWdIxjo8G76JSbppxtD0
e1X/l+Vo40DHIraQoLXY1KE65ppmbwl6KxTB6gYPPdDDD20SK5aCNpE1iOEnEpgH
gW5YZ3XJih7kwE9iFDkwzLRk1m/nhbULxRQF+eMBZQ+mS8yb+zcuhz/t0jkSPYge
LjvyI9Dx92f2waEdS+KXxTCMkNgNYGP1xHCA4k4hrh3dGZRtnRs4m7Mndf4SGHzi
CTFMRa5VLoW+vtEdV+mDSWmnZHUeYdhMMPaTN/C2tCrqs0NfpmtiOLAhixLowKMi
ngjawVrL97XPIPNs+j3N4tQU5pXSvCtaFUsmB1HMA4VsNl2Q/8NDqYPCOSIH1/gU
PkVEQYswNPVmigQiqlJrE9L17ISHnBLPI3OTOhhtXHBMX1a2k5rxfZgEIfVcbLlX
AaFuhAwTMXy52kej4cVqcoogN1+JVcMzN+ChnuH04PrHU5EO3aIuQ5P46HZWQRda
8APV6Pnvwnk0DCIwBJqj6dD49EdnP9ekPAqEIWqfgYEtMdvcrb5dpxrQ0tXGLFiw
gRihKrcfl0iStEF+hE607Kr9XZoDB3vf0A17zIqCmF5IvNO67Jss6gRbbwoKlgW7
7wljYO0OoK1vuuMwdkKA8KG1O7p/z7XPJSmRSUAIq0tc4oov0H6wVVwUIbbUGGnS
fdmFv0FD6wU=
=kK0t
-----END PGP SIGNATURE-----

--=-BCd81Bk+7cjcOhQgKH//--


--===============0094240883749155931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0094240883749155931==--
