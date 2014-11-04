From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] Thermal/int3403: Fix thermal hysteresis unit conversion
Date: Tue, 4 Nov 2014 19:31:01 -0400
Message-ID: <20141104233059.GA5243@developer>
References: <1415008381-11584-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1415065834.22344.1.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:51018 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaKDXaf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 18:30:35 -0500
Received: by mail-qc0-f170.google.com with SMTP id l6so11951700qcy.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2014 15:30:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1415065834.22344.1.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: tianyu.lan@intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rui,

On Tue, Nov 04, 2014 at 09:50:34AM +0800, Zhang Rui wrote:
> On =E4=B8=80, 2014-11-03 at 01:53 -0800, Srinivas Pandruvada wrote:
> > From: "lan,Tianyu" <tianyu.lan@intel.com>
> >=20
> > Thermal hysteresis represents a temperature difference.
> > But the original code treats it as a temperature value,
> > Convert it from tenths of degree Kelvin to Milli-Celsius
> > by deducing 273200. This is not right.
> >=20
> > Kelvin and Celsius have same degree size. From temperature
> > difference view, the conversion between tenths of degree
> > Kelvin unit and Milli-Celsius unit is just to multiply 100.
> >=20
> > Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> Hi, Eduardo,
>=20
> can you please queue this patch for 3.18-rc5?
>=20

Pulled into my -fixes queue. Thanks.

> thanks,
> rui
> > ---
> >  drivers/thermal/int340x_thermal/int3403_thermal.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/driver=
s/thermal/int340x_thermal/int3403_thermal.c
> > index d20dba9..6e9fb62 100644
> > --- a/drivers/thermal/int340x_thermal/int3403_thermal.c
> > +++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
> > @@ -92,7 +92,13 @@ static int sys_get_trip_hyst(struct thermal_zone_dev=
ice *tzone,
> >  	if (ACPI_FAILURE(status))
> >  		return -EIO;
> > =20
> > -	*temp =3D DECI_KELVIN_TO_MILLI_CELSIUS(hyst, KELVIN_OFFSET);
> > +	/*
> > +	 * Thermal hysteresis represents a temperature difference.
> > +	 * Kelvin and Celsius have same degree size. So the
> > +	 * conversion here between tenths of degree Kelvin unit
> > +	 * and Milli-Celsius unit is just to multiply 100.
> > +	 */
> > +	*temp =3D hyst * 100;
> > =20
> >  	return 0;
> >  }
>=20
>=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWWGnAAoJEMLUO4d9pOJWwFMH+wd+2m0ObjPWQ+DE40v/25qe
KjB1yEYqXfBIkZPo8NI8gYJCyHbW+n40xzzhEUd9yr9/qT+VTKHYxnYfPVKUyUV1
lqXLSjVuFx4Q8AkuyhJhclH9M1IHDgPwzLzl526Ihg3Zj5v+JRzOcQ6wIytcCipm
LwbRQwktK5RlOFnDOW9buMLXYhyFTuHpInD4Jv00Mu1SQ5WF0FXOdk5MLElCgO1H
2Qq87HBasN2UBYCyDcYHaLRp1BH7Fw4t5YhnSHh7TBnCjvBRSQip+ke4552Ps+CV
u6mJymBRGF8i16n8EcKMezoNeh4rKTdqXWR/eVBzz0s6J4C0vIgiWhTe4R2loiY=
=Wjma
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
