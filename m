From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Wed, 25 Feb 2015 14:47:47 -0400
Message-ID: <20150225184742.GE2306@developer.amazonguestwifi.org>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
 <20150216151432.GB8648@developer.hsd1.ca.comcast.net>
 <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
 <20150224195201.GB353@developer.amazonguestwifi.org>
 <9hhbnki6uvp.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46571 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbBYSrw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 13:47:52 -0500
Received: by pdjy10 with SMTP id y10so6722171pdj.13
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 10:47:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9hhbnki6uvp.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Punit,

On Wed, Feb 25, 2015 at 12:25:14PM +0000, Punit Agrawal wrote:
> Eduardo Valentin <edubezval@gmail.com> writes:
>=20

<cut>

> > What is your optionion?
>=20
> Although I understand your motivation for suggesting (1), I am not sure
> this will work in practice. As soon as one platform enables the option
> in the defconfig (arm64) or multi_v7_defconfig (arm), all platforms will
> have it enabled.

Well, just because it is enabled by default, it does not mean that
everybody has to follow what is in defconfig. In practice, when building
production kernels, defconfigs are changed.

My concern now is more about allowing people to have the possibility to
change the expected behavior. Only with the original patch, it will
always be writable.

>=20
> But if you think it's worth merging, something like below should do it.
>=20
> >
> > I am copying Srinivas here too. Srinivas, do you think that option (1)
> > above will break things in userspace on your side?
> >
> >>=20
> >> Cheers,
> >> Punit
> >>=20
> >> >
> >> >
> >> > BR,
> >> >
> >> > Eduardo Valentin
> >> >
> >> >>=20
> >> >> Comments welcome.
> >> >>=20
> >> >> Cheers,
> >> >> Punit
> >> >>=20
>=20
> -- >8 --
>=20
> Subject: [PATCH] thermal: core: Add Kconfig option to enable writable tri=
ps
>=20
> Add a Kconfig option to allow system integrators to control whether
> userspace tools can change trip temperatures. This option overrides
> the thermal zone setup in the driver code and must be enabled for
> platform specified writable trips to come into effect.
>=20
> The original behaviour of requiring root privileges to change trip
> temperatures remains unchanged.
>=20
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Yes, something like this is what I was suggesting.


Thanks.

> ---
>  drivers/thermal/Kconfig        | 11 +++++++++++
>  drivers/thermal/thermal_core.c |  3 ++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index af40db0..5d2d39b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -42,6 +42,17 @@ config THERMAL_OF
>  	  Say 'Y' here if you need to build thermal infrastructure
>  	  based on device tree.
> =20
> +config THERMAL_WRITABLE_TRIPS
> +	bool "Enable writable trip points"
> +	help
> +	  This option allows the system integrator to choose whether
> +	  trip temperatures can be changed from userspace. The
> +	  writable trips need to be specified when setting up the
> +	  thermal zone but the choice here takes precedence.
> +
> +	  Say 'Y' here if you would like to allow userspace tools to
> +	  change trip temperatures.
> +
>  choice
>  	prompt "Default Thermal governor"
>  	default THERMAL_DEFAULT_GOV_STEP_WISE
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 48491d1..15111c1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1378,7 +1378,8 @@ static int create_trip_attrs(struct thermal_zone_de=
vice *tz, int mask)
>  						tz->trip_temp_attrs[indx].name;
>  		tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
>  		tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_show;
> -		if (mask & (1 << indx)) {
> +		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
> +		    mask & (1 << indx)) {
>  			tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWUSR;
>  			tz->trip_temp_attrs[indx].attr.store =3D
>  							trip_point_temp_store;
> --=20
> 2.1.4

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hjEAAoJEMLUO4d9pOJWaSUIAKAuRgaZWYzqWyyVsysRLPTm
NLykSJnneStcBpumG6EkXsxTcPjNPuhNCwlPPGYYHKMz7iblJ9jy/DqvBrG0hv4v
CiG7pTTdJh+BxhhdFBz8rZVKVdyUtum2wW499BtlDLn2JLoLzPLAATvxS5NGvyVR
hf5dyKgrgScnVmPvVQKnofIaijQNZEMQgnAHia+zMSbhtc//GtbgpLOKu879wsPM
ULidmYbw7eZdocUB+gLoc7qO4zDYDA/bdGLNgDnK9K2zXmldSTOzPhvc2RSzhJ2D
aqrO8GanSEGrUDkNy1PqwuuOoSXi321mVpAwE5HNXqNwtpHUQccv9EE0AwcaddQ=
=3U0z
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
