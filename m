From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/8] mfd: ab8500: Use power_supply_*() API for accessing
 function attrs
Date: Wed, 15 Oct 2014 11:07:12 +0200
Message-ID: <20141015090712.GB9900@lee--X1>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
 <1413289246-31650-6-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:61300 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaJOJHQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Oct 2014 05:07:16 -0400
Received: by mail-wi0-f169.google.com with SMTP id h11so8131730wiw.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2014 02:07:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413289246-31650-6-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, 14 Oct 2014, Krzysztof Kozlowski wrote:

> Replace direct calls to power supply function attributes with wrapper=
s.
> Wrappers provide safe access access in case of unregistering the powe=
r
> supply (.e.g by removing the driver). Replace:
>  - get_property -> power_supply_get_property
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctr=
l.c
> index 8e0dae59844d..93b2d2c32ca3 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -49,7 +49,8 @@ static void ab8500_power_off(void)
>  		if (!psy)
>  			continue;
> =20
> -		ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
> +		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> +				&val);
> =20
>  		if (!ret && val.intval) {
>  			charger_present =3D true;
> @@ -63,8 +64,8 @@ static void ab8500_power_off(void)
>  	/* Check if battery is known */
>  	psy =3D power_supply_get_by_name("ab8500_btemp");
>  	if (psy) {
> -		ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_TECHNOLOGY,
> -					&val);
> +		ret =3D power_supply_get_property(psy,
> +				POWER_SUPPLY_PROP_TECHNOLOGY, &val);
>  		if (!ret && val.intval !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
>  			printk(KERN_INFO
>  			       "Charger \"%s\" is connected with known battery."

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
