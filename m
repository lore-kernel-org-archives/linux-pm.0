From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCHv2 07/19] mfd: ab8500: Use power_supply_*() API for
 accessing function attrs
Date: Tue, 20 Jan 2015 13:36:17 +0000
Message-ID: <20150120133617.GG13701@x1>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
 <1420472882-10463-8-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45204 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbATNgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 08:36:24 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so6729295ieb.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 05:36:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420472882-10463-8-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> Replace direct calls to power supply function attributes with wrapper=
s.
> Wrappers provide safe access in case of unregistering the power
> supply (e.g. by removing the driver). Replace:
>  - get_property -> power_supply_get_property
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Lee Jones <lee.jones@linaro.org>

You've sent this to me already Acked.  I don't see 00/00, so I have no
idea what's going on.  Do you want me to take this patch?  Can it be
taking on its own?

> ---
>  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctr=
l.c
> index cfff0b643f1b..d4a4b24be7c6 100644
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
