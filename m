From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] PM: make freezer optional for suspend
Date: Sat, 08 Dec 2007 01:12:34 +0100
Message-ID: <1197072754.4171.39.camel@johannes.berg>
References: <1196776933.6060.62.camel@johannes.berg>
	<200712080127.59128.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1070910789141291150=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712080127.59128.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============1070910789141291150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-siRpzFmY2GFlY2w92P7V"


--=-siRpzFmY2GFlY2w92P7V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Sat, 2007-12-08 at 01:27 +0100, Rafael J. Wysocki wrote:
> On Tuesday, 4 of December 2007, Johannes Berg wrote:
> > This patch makes the freezer optional for suspend to allow the
> > system to work (or not work) like the original PMU suspend.
>=20
> Generally looks good to me, but I'd probably define suspend_freeze_proces=
ses()
> and suspend_thaw_processes() to be identical to freeze_processes() and
> thaw_processes(), respectively, if CONFIG_SUSPEND_FREEZER is set, or to b=
e no
> ops otherwise (power.h seems to be the right place).

Didn't think it was worth it, but I can do that. Will repost when I get
around to it.

> The other two patches are fine, I'll push them to Len in a while.

Thanks!

johannes

--=-siRpzFmY2GFlY2w92P7V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR1nhcaVg1VMiehFYAQKcFg/8CKBnjTki1bUUTcqR0IELIfu2DPVB/7Sa
Gps4tv1+pneZZXPoZOE+jLmL7qZ//RuOOcqLadhkTerpRWvLTnzvc+Z67kYxFBls
/YwlNfafCTHR5BFOCtrnhRCVYqTWA4DQrnpHzuzfgfRcIywkbZ18bLcuawppH2gj
TTQtnJhfkI7EQV8dII9SokDVDzULN1rJcxU1mAPI3Xvah20W8Dm7F7T/q0LGuyew
rJ4KG9HIr03EYNIiZevVeIs/nqFn4Ev7PTdx8VQIEiPon1K3KW4qBDGZGSFmSR/s
TpuNuHpo5d2W+yxahkr/HT7clc3vf0sjvdAf5gNfc0pSuLjg2CV88qjQcZbdSJhI
iygaH4Kn8xyOolNJzpvMZIHvTSY6G/QNNKrtXN6+hSTLsffo2c4nuUj375WlSfRk
fkkVQWiAvPfGDUSiH47eb8smpSfUShYlYeFD994sTvZWOVEqpeBWuQxUdqjpzvSS
m2U5PrDn/YWfyjoHBYW4JkP/0hWYBmJlz6BsgdFsNS213NdlJQYEVK95JxDAKf0X
yae9nrtQ8E1h9inQUwqBCTIFMDHc3VafoFMg9b2CdLkuobr0QtkijbCC16cAp/0u
Vh3eRLI2hzdK1BouIi+OIj6yFq1eR3+6wjVE8kMNquJFnM9UDVmtPAy4FmMUl9fP
mmgagxvKoxs=
=sola
-----END PGP SIGNATURE-----

--=-siRpzFmY2GFlY2w92P7V--


--===============1070910789141291150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1070910789141291150==--
