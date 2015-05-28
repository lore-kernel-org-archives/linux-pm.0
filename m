From: Sebastian Reichel <sre@kernel.org>
Subject: Re: randconfig build error with next-20150528, in
 drivers/power/twl4030_charger.c
Date: Thu, 28 May 2015 22:33:14 +0200
Message-ID: <20150528203313.GA10469@earth>
References: <CA+r1ZhjGZqh0ZOdkne3Pf1Ht2Vyf3+HzFPzrqVPDMRfiT6prxA@mail.gmail.com>
 <20150528175700.GB31619@earth>
 <20150528184642.GB25787@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754AbbE1Udk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 16:33:40 -0400
Content-Disposition: inline
In-Reply-To: <20150528184642.GB25787@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jim Davis <jim.epost@gmail.com>, NeilBrown <neilb@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 28, 2015 at 01:46:42PM -0500, Felipe Balbi wrote:
> On Thu, May 28, 2015 at 07:57:00PM +0200, Sebastian Reichel wrote:
> > On Thu, May 28, 2015 at 10:05:55AM -0700, Jim Davis wrote:
> > > drivers/power/twl4030_charger.c: In function =E2=80=98twl4030_bci_pro=
be=E2=80=99:
> > > drivers/power/twl4030_charger.c:648:23: error: implicit declaration o=
f function
> > > =E2=80=98devm_usb_get_phy_by_node=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
> > >     bci->transceiver =3D devm_usb_get_phy_by_node(
> > >                        ^
> > > drivers/power/twl4030_charger.c:648:21: warning: assignment makes poi=
nter from i
> > > nteger without a cast [-Wint-conversion]
> > >     bci->transceiver =3D devm_usb_get_phy_by_node(
> > >                      ^
> >=20
> > This has been introduced by the following commit from Neil Brown:
> >=20
> > power: twl4030_charger: find associated phy by more reliable means.
>=20
> no, this was introduced by the commit which introduced
> devm_usb_get_phy_by_node() (also by Neil) and has already been
> fixed by Arnd.

well without the second patch there would be no devm_usb_get_phy_by_node()
call in twl4030_charger, but no need to go into nitpicking mode :)

> I have the patch in my 'next' branch and it should show up on
> tomorrow's linux-next.

OK, thanks for taking care of this.

-- Sebastian

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ3uDAAoJENju1/PIO/qaZNgP/2caDa+rreXDItg2ez+hNMmi
7xjjFSZk6mb8I3PpKe7GvSilZiGmGtfw/dxVPpbCPl3QYoC+uZn7IP22e8WbWrFZ
WT27NS2UYBmS6L6K4ckjEAwvpqoOPyDkTpxilRM+j/I29ll4072eAQmosIswbadF
3xbftIbUB9yY8NIIO6Pdc0xXIXEUsyEZw5NEmnVqXlAx9t7QL7aS8UaB1jgXo9pN
YX/7j2lv5QJ1k6vvdnsMTSQMxIjc4+AOIrjsXpAqCx86gXhv3QfyT5CayQy6ALKZ
Xf9qQtEsiNdY/GIEsM7RbVkgSv4M7jdCSIIUO1h1o/hKTpi7fjYyBgb2X87mUx7f
YB3y1IudN0UNU7kMFeMy3N5mf1qVVcNNZrVssUFQTQMn1xNZlz1VN8V+oB/Y5v40
Gyv+6b2aQeSi8elSCHuAxZqPvw/9CEaYAX+iWak/FZS9baj/s13QgWnTwpxfo7dL
nFPDYQkZe74xa/Tcnhic4WnVMpOtLTdDpZkHrcdEJKjtpQsx3O7ANN0oU6YzGm2g
44Qq3rIxMeYIytKVytj1++SByi/BtAESHj4UWFiz495sxfKZwYEsUcfJG1tpW465
yHrJyqTbi2vRu+C4tp5VUi0FX4pE4PePj8ogavZpYATyauvDpPMrzl1m7R5+5R7d
+cuSxYow/ZnybVZI0zE+
=eyvq
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
