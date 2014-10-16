From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
Date: Thu, 16 Oct 2014 14:29:01 +0200
Message-ID: <20141016122901.GA22725@lee--X1>
References: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
 <1413445327-24862-8-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:42092 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaJPM3H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 08:29:07 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so4571746wiv.12
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2014 05:29:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413445327-24862-8-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, 16 Oct 2014, Krzysztof Kozlowski wrote:

> Use power_supply_put() to decrement the power supply's device referen=
ce
> counter.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

I already Acked this.

> ---
>  drivers/mfd/ab8500-sysctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctr=
l.c
> index 93b2d2c32ca3..d05a5719cfc4 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
> =20
>  		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
>  				&val);
> +		power_supply_put(psy);
> =20
>  		if (!ret && val.intval) {
>  			charger_present =3D true;
> @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
>  			       pss[i]);
>  			machine_restart("charging");
>  		}
> +		power_supply_put(psy);
>  	}
> =20
>  shutdown:

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
