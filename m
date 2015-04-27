From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.1-rc1
Date: Mon, 27 Apr 2015 16:58:02 -0700
Message-ID: <20150427235801.GA4658@localhost.localdomain>
References: <20150415054819.GA16396@localhost.localdomain>
 <20150427083536.GB3066@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150427083536.GB3066@e104805>
Sender: linux-acpi-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Javi,

On Mon, Apr 27, 2015 at 09:35:36AM +0100, Javi Merino wrote:
> On Wed, Apr 15, 2015 at 06:48:20AM +0100, Eduardo Valentin wrote:
> > Hello Rui,
> >=20
> > Please pull from
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-ther=
mal linus
> >=20
> > to receive Thermal-SoC Management updates for v4.1-rc1 with top-most
> >=20
> > 55920e072776533fd314fb3d9b69c866ed90b3df:
> >=20
> >   thermal: exynos: Add the support for Exynos5433 TMU (2015-04-14 22:31=
:17 -0700)
> >=20
> > on top of commit f8b3d8a5af7559a58613384cd23fc03a3c787acf:
> >=20
> >   Merge tag 'usb-4.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/=
git/gregkh/usb (2015-04-04 12:26:28 -0700)
> >=20
> > Specifics:
> > - Exynos thermal driver learns how to handle Exynos5433 TMU. Thanks to =
Chanwoo C.;
> > - Thermal Framework now supports QPNP PMIC temperature alarm as a new t=
hermal
> >   driver. Thanks to Ivan T. I.;
> > - TI thermal driver now has a better implementation for EOCZ bit. Thank=
s to Pavel M.;
> > - Thermal Framework now has learned several new capabilities:
> >   . use power estimates
> >   . compute weights with relative integers instead of percentages
> >   . allow governors to have private data in thermal zones
> >   . export thermal zone parameters through sysfs
> >   Thanks to the ARM thermal team (Javi M., Punit A., and KP).
> > - Thermal Framework earns a new thermal governor: power allocator. Firs=
t in kernel
> >   closed loop PI(D) controller for thermal control. Thanks to ARM therm=
al team.
> > - OF thermal now allows thermal zones to have sustainable power HW spec=
ification.
> >   Thanks to Punit.
>=20
> 4.1-rc1 is out and it looks like this fell through the cracks.  If
> there isn't any objection, can any of you send the pull request to
> Linus?
>=20

It has been sent already:
http://marc.info/?l=3Dlinux-pm&m=3D143013593125080&w=3D2

> Thanks,
> Javi
>=20

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVPsz/AAoJEMLUO4d9pOJWh84IAIIchKU3yGIje17otUjD/UP4
n1bK9TemeDhuVvOtTWwf0jaob99mfWrOsM6keugMq/ndEPs4E81vRG+SdSFxjB0t
UY2Xl4yv/c1kPCst6HnATK+aI9aC7DfoZl/8mFhfrHbZT8RzkJJMcTTqnkjco4oS
Byo7mkZL6sgp79j/9g8e1/pEdlbCxk43rfEyeDYfMmzL/mKJrO7vfIx0WPu1mdrC
x7qILvWFINhjstm1lcvIc69NCBAKvVXAPnNz39z+9ncGRMMEqzTttC6jJDAY8+67
++wsbew2ouN0t6+jkOwYsiAzuV8SKxxnM1qSRnRgpkrrcrHTstJQnK4Y2+0enaw=
=lMSU
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
