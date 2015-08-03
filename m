From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86
 thermal
Date: Sun, 2 Aug 2015 20:10:37 -0700
Message-ID: <20150803031033.GA25688@localhost.localdomain>
References: <1438494401-3984-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36464 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbbHCDKl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 23:10:41 -0400
Received: by pdco4 with SMTP id o4so2331300pdc.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Aug 2015 20:10:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438494401-3984-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas,

On Sat, Aug 01, 2015 at 10:46:41PM -0700, Srinivas Pandruvada wrote:
> After the commit "thermal: core: Add Kconfig option to enable writable tr=
ips",
> user space tools like thermal daemon and Chrome OS DPTF thermal controller
> can no longer receive async events for thermal thresholds. Since we need =
to
> enable the new config introduced by above commit to allow writable trips.
> Selecting CONFIG_THERMAL_WRITABLE_TRIPS for x86 thermal drivers.

I am fine with enabling the config on x86 drivers. However the
description is somewhat confusing. Are you sure you are not receiving
async events or you are not able to write on trip point files?

Because that's all this option does (quoting thermal_core.c):
                if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
                    mask & (1 << indx)) {
                        tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWU=
SR;
                        tz->trip_temp_attrs[indx].attr.store =3D
                                                        trip_point_temp_sto=
re;
                }


I am not really sure if this change is going to give your events back.


can you please confirm what you are trying to achieve here?

>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 118938e..0e3b576 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -275,6 +275,7 @@ config X86_PKG_TEMP_THERMAL
>  	tristate "X86 package temperature thermal driver"
>  	depends on X86_THERMAL_VECTOR
>  	select THERMAL_GOV_USER_SPACE
> +	select THERMAL_WRITABLE_TRIPS
>  	default m
>  	help
>  	  Enable this to register CPU digital sensor for package temperature as
> @@ -296,6 +297,7 @@ config INTEL_SOC_DTS_THERMAL
>  	tristate "Intel SoCs DTS thermal driver"
>  	depends on X86
>  	select INTEL_SOC_DTS_IOSF_CORE
> +	select THERMAL_WRITABLE_TRIPS
>  	help
>  	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
>  	  temperature sensor (DTS). These SoCs have two additional DTSs in
> @@ -322,6 +324,7 @@ config INT340X_THERMAL
>  	select ACPI_THERMAL_REL
>  	select ACPI_FAN
>  	select INTEL_SOC_DTS_IOSF_CORE
> +	select THERMAL_WRITABLE_TRIPS
>  	help
>  	  Newer laptops and tablets that use ACPI may have thermal sensors and
>  	  other devices with thermal control capabilities outside the core
> --=20
> 2.4.3
>=20

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVvtujAAoJEMLUO4d9pOJWLPcIAJ0GgKMVGMLnUEMTl5ce28jJ
R0bdmSu4pZHsIIqvfS8NPv9dtid2+xhWeIDaHDq/Is1SOpc3qfyee9XoL7lx5m/8
TU5aJNlTX4LpDMIcCdX7SZlExak2S+Shw93zwzsBbMHh8BKJQ4ozQ7UKqPrAmV1n
WWga76D2QdqpxUkZVvsQY7DdsEyvK2k+jlgqyPyBTlZyvhB+aKEZrWM2+yp20hk2
Mb8/hTQaryzK6G2xnL6TDYFFsY+kWoZw83IJbbJ8vxZvL/7hEf5FjN6iAywB0LxM
yHPOvhPXayjmAFwE8ig5fE/ZZx6rBmbRdA/0OzANgMT+TjUBQJy8PEdxEAGCywA=
=PgOW
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
