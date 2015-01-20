From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd/axp20x: change battery cell name to fuel gauge
Date: Tue, 20 Jan 2015 11:47:25 +0000
Message-ID: <20150120114725.GI13701@x1>
References: <20150107212450.GB3440@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55745 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbbATLrc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 06:47:32 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so6364030ieb.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 03:47:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150107212450.GB3440@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, david.woodhouse@intel.com, todd.e.brandt@intel.com

On Wed, 07 Jan 2015, Todd E Brandt wrote:

> mfd/axp20x: change battery cell name to fuel gauge
>=20
> Name changes to the battery cell structure to a
> more generic cell type: fuel gauge.
>=20
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> ----
>  drivers/mfd/axp20x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index b1b580a..e75717e 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -87,7 +87,7 @@ static struct resource axp20x_pek_resources[] =3D {
>  	},
>  };
> =20
> -static struct resource axp288_battery_resources[] =3D {
> +static struct resource axp288_fuel_gauge_resources[] =3D {
>  	{
>  		.start =3D AXP288_IRQ_QWBTU,
>  		.end   =3D AXP288_IRQ_QWBTU,
> @@ -236,7 +236,7 @@ static const struct i2c_device_id axp20x_i2c_id[]=
 =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> =20
> -static const struct acpi_device_id axp20x_acpi_match[] =3D {
> +static struct acpi_device_id axp20x_acpi_match[] =3D {

Why have you dropped the cost qualifier here?

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
