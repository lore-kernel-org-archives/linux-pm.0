From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal/int3403: Fix thermal hysteresis unit conversion
Date: Tue, 04 Nov 2014 09:50:34 +0800
Message-ID: <1415065834.22344.1.camel@rzhang1-toshiba>
References: <1415008381-11584-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9026 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaKDBxE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Nov 2014 20:53:04 -0500
In-Reply-To: <1415008381-11584-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: tianyu.lan@intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On =E4=B8=80, 2014-11-03 at 01:53 -0800, Srinivas Pandruvada wrote:
> From: "lan,Tianyu" <tianyu.lan@intel.com>
>=20
> Thermal hysteresis represents a temperature difference.
> But the original code treats it as a temperature value,
> Convert it from tenths of degree Kelvin to Milli-Celsius
> by deducing 273200. This is not right.
>=20
> Kelvin and Celsius have same degree size. From temperature
> difference view, the conversion between tenths of degree
> Kelvin unit and Milli-Celsius unit is just to multiply 100.
>=20
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Hi, Eduardo,

can you please queue this patch for 3.18-rc5?

thanks,
rui
> ---
>  drivers/thermal/int340x_thermal/int3403_thermal.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/driv=
ers/thermal/int340x_thermal/int3403_thermal.c
> index d20dba9..6e9fb62 100644
> --- a/drivers/thermal/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
> @@ -92,7 +92,13 @@ static int sys_get_trip_hyst(struct thermal_zone_d=
evice *tzone,
>  	if (ACPI_FAILURE(status))
>  		return -EIO;
> =20
> -	*temp =3D DECI_KELVIN_TO_MILLI_CELSIUS(hyst, KELVIN_OFFSET);
> +	/*
> +	 * Thermal hysteresis represents a temperature difference.
> +	 * Kelvin and Celsius have same degree size. So the
> +	 * conversion here between tenths of degree Kelvin unit
> +	 * and Milli-Celsius unit is just to multiply 100.
> +	 */
> +	*temp =3D hyst * 100;
> =20
>  	return 0;
>  }


