From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Fix cdev registration with THERMAL_NO_LIMIT on
 64bit
Date: Wed, 10 Dec 2014 10:42:44 -0400
Message-ID: <20141210144242.GB3232@developer>
References: <1418127721-1182-1-git-send-email-punit.agrawal@arm.com>
 <1418176657.12435.40.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:37521 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341AbaLJOmw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 09:42:52 -0500
Content-Disposition: inline
In-Reply-To: <1418176657.12435.40.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 09:57:37AM +0800, Zhang Rui wrote:
> On Tue, 2014-12-09 at 12:22 +0000, Punit Agrawal wrote:
> > The size of unsigned long varies between 32 and 64 bit systems while
> > the size of phandle arguments is always 32 bits per parameter.
> >=20
> > On 64-bit systems, cooling devices registered via of-thermal apis fail
> > to bind when the min/max cooling state is specified as
> > THERMAL_NO_LIMIT (-1UL) as there is a mis-match between the value read
> > from the device tree (32bit) and the pre-processor define (64bit).
> >=20
> > As we're unlikely to need cooling states larger than 32 bits, and for
> > consistency with the size of phandle arguments, explicitly limit
> > THERMAL_NO_LIMIT to 32 bits.
> >=20
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > ---
> >  include/dt-bindings/thermal/thermal.h | 2 +-
> >  include/linux/thermal.h               | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/dt-bindings/thermal/thermal.h b/include/dt-binding=
s/thermal/thermal.h
> > index 59822a9..b5e6b00 100644
> > --- a/include/dt-bindings/thermal/thermal.h
> > +++ b/include/dt-bindings/thermal/thermal.h
> > @@ -11,7 +11,7 @@
> >  #define _DT_BINDINGS_THERMAL_THERMAL_H
> > =20
> >  /* On cooling devices upper and lower limits */
> > -#define THERMAL_NO_LIMIT		(-1UL)
> > +#define THERMAL_NO_LIMIT		(~0)
> > =20
> I'm okay with the other change, so Eduardo, what do you think of this?

Adding to my fixes branch.


Prunit, thanks for spotting and fixing this issue.

>=20
> thanks,
> rui
> >  #endif
> > =20
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index ef90838..005586f 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -38,7 +38,7 @@
> >  #define THERMAL_CSTATE_INVALID -1UL
> > =20
> >  /* No upper/lower limit requirement */
> > -#define THERMAL_NO_LIMIT	THERMAL_CSTATE_INVALID
> > +#define THERMAL_NO_LIMIT	((u32)~0)
> > =20
> >  /* Unit conversion macros */
> >  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >=3D 0) ?	\
>=20
>=20

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiFvbAAoJEMLUO4d9pOJWghoH/Rgcf9dQtqBNMU6E8tYBG0Ar
G1fDzp3zKTCJAT5BKmziermLifCgD1JybWZ5S9VVPTGB88+B2fis/ZBjGfw2l+Ya
Owk9uhPHgF5qvX3jqeEb/JdwhC785AREk2+qdR8QRUc7eM1EROEtxoSRsB+sxRjs
ZluAdmgRDVCojLcH4g40kcROkuwQAjSZRffahmgBTBIlA6YaHj3VxBvtYjCWB5yb
8HhTMWdjBCd9R3bTzgcoGcPDQZKt1IiwpA+t05lJaV/pi/tBD4D3+XX3Kr/osipm
1xiHBxIC/TGYrxa0K36+n8r3vL1eeAw6CwOGP1W0BjL7yZCmiL8oUicXbh1GnXc=
=Vhxu
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
