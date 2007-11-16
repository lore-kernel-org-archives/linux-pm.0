From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PM: make freezer optional for suspend
Date: Fri, 16 Nov 2007 16:58:32 +0100
Message-ID: <1195228712.8147.151.camel@johannes.berg>
References: <1194980670.6695.1.camel@johannes.berg>
	<200711142230.14662.rjw@sisk.pl>
	<1195145246.13846.68.camel@johannes.berg>
	<200711152124.25136.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484778863018811742=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711152124.25136.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============0484778863018811742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lC1fgYmncSVnNtI8eO9k"


--=-lC1fgYmncSVnNtI8eO9k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > > It's a bit confusing for someone who doesn't know what ADB_PMU is.
> > >=20
> > > Perhaps it might depend on something like ARCH_CAN_DO_WITHOUT_FREEZER=
 instead?
> >=20
> > It can't really. Things break. Ben and Paul just don't want to hear
> > about it. I made it depend on BROKEN so people can take it out and see
> > what breaks (to possibly fix it), and depend on ADB_PMU so they can hav=
e
> > their favourite setting without enabling BROKEN.
>=20
> I understand that, but it's a bit confusing to put ADB_PMU, which is spec=
ific
> to powerpc, into the generic configuration file.

Alright, I'll give it some thought and repost later. Maybe
ARCH_DOESNT_WANT_FREEZER ;)

johannes

--=-lC1fgYmncSVnNtI8eO9k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARz2+J6Vg1VMiehFYAQLJTw/9FxRgzb0b+2xGdYCKJOnOLBAoZIrNZ2xH
a/1C5MnG49snkdKoyrDRocZbXiAMN/d6eB1bF0awUDvXCfJW6DImxAeCkmB3Xl4Z
sUfmEy1b1067b8g1y54Hb+OiR1sAXbyBG+4Y4/V1FsoDPcJXOhE5qaq/mT8QWx+K
bLReptbLsjhx9f214ZpYtDZu2vqzOcG/6LinjVZLVZJ9MZfAZs54BYNVGg4vtdF+
jbGc7hpo9KjU4Rv5PB6gA4yd1k3zrm7lZqV2dY8B3yiUEZ2Y4T0J4N9N5fcPXuKv
l/+xoOA5jl7HcgjlRUAZeOLzXoDqd5ZXz81h/5ExwotQVyOA8OUkxRcCALqOmQgS
KoWltUHNSmL12j/n5dhi4GoICEp/B4/CUN59FpT/j+rTA3GVRLDPNprz+9OahBd6
VdWNr24Up3UxMpVmCVlFl7nN0KfEazkgtz9Bvu0s8abBK+Rc81SdgKJ1fyT/XOFD
EdFJdVpuUW+jZ4Znmv+8pROk5h/x3qUktlRjJI8vUtEMZLOqfSVaTtcAjnxhtDVy
I4+A0501yRxME9l8o5pf8bj5ud017L7O/Di9oX12vaNpkSxFbzy1HySFtVP3ZKhP
Ze1ORDPEIJLvw6mKFpqXoAj3lBOzzlslQISv95pmzMGkBURW1+5+h+Xri7bxCtaT
vUprw+kXuQ4=
=cUhb
-----END PGP SIGNATURE-----

--=-lC1fgYmncSVnNtI8eO9k--


--===============0484778863018811742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0484778863018811742==--
