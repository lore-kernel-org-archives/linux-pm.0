From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI thermal: do not always return THERMAL_TREND_RAISING for active trip points
Date: Fri, 26 Apr 2013 14:07:45 +0200
Message-ID: <2045208.arlEGZ66vS@vostro.rjw.lan>
References: <1366967993-3812-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44979 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab3DZL7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2013 07:59:37 -0400
In-Reply-To: <1366967993-3812-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, eduardo.valentin@ti.com

On Friday, April 26, 2013 05:19:53 PM Zhang Rui wrote:
> Commit 4ae46befb49d4173122e0afa995c4e93d01948a2
> introduces a regression that the fan is always on
> even if the system is in idle state.
>=20
> My original idea in that commit is that:
> when the current temperature is above the trip point,
> keep the fan on, even if the temperature is dropping.
> when the current temperature is below the trip point,
> turn on the fan when the temperature is raising,
> turn off the fan when the temperature is dropping.
>=20
> But this is what the code actually does:
> when the current temperature is above the trip point,
> the fan keeps on.
> when the current temperature is below the trip point,
> the fan is always on because thermal_get_trend()
> in driver/acpi/thermal.c returns THERMAL_TREND_RAISING.
> Thus the fan keeps running even if the system is idle.
>=20
> Fix this in drivers/acpi/thermal.c.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D56591
> https://bugzilla.kernel.org/show_bug.cgi?id=3D56601
> https://bugzilla.kernel.org/show_bug.cgi?id=3D50041#c45
>=20
> Patch should be applied to 3.7 stable kernel and later.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Tested-by: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
> Cc: <stable@vger.kernel.org> # v3.7+

Applied.

Thanks,
Rafael


> ---
>  drivers/acpi/thermal.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 8470771..a33821c 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -723,9 +723,19 @@ static int thermal_get_trend(struct thermal_zone=
_device *thermal,
>  		return -EINVAL;
> =20
>  	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> -		/* aggressive active cooling */
> -		*trend =3D THERMAL_TREND_RAISING;
> -		return 0;
> +		unsigned long trip_temp;
> +		unsigned long temp =3D KELVIN_TO_MILLICELSIUS(tz->temperature,
> +							tz->kelvin_offset);
> +		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
> +			return -EINVAL;
> +
> +		if (temp > trip_temp) {
> +			*trend =3D THERMAL_TREND_RAISING;
> +			return 0;
> +		} else {
> +			/* Fall back on default trend */
> +			return -EINVAL;
> +		}
>  	}
> =20
>  	/*
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
