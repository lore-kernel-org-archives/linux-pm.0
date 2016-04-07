From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: usb-gpio: switch to use pm wakeirq apis
Date: Fri, 08 Apr 2016 08:04:37 +0900
Message-ID: <5706E785.9020308@samsung.com>
References: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60418 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcDGXEl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 19:04:41 -0400
In-reply-to: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: nsekhar@ti.com, nm@ti.com, rogerq@ti.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com

On 2016=EB=85=84 04=EC=9B=94 07=EC=9D=BC 02:32, Grygorii Strashko wrote=
:
> Switch to use PM wakeirq APIs which automates wakeup IRQs
> enabling/disabling and so allows to make code simpler.
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied it.

Thanks,
Chanwoo Choi

> ---
> Unfortunately this simple patch depends on:
> "[RFC PATCH] PM / wakeirq: fix wakeirq setting after wakup re-configu=
ration from sysfs"
> https://lkml.org/lkml/2016/4/6/296
>=20
>  drivers/extcon/extcon-usb-gpio.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon=
-usb-gpio.c
> index 2b2fecf..bc61d11 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> =20
> @@ -141,7 +142,8 @@ static int usb_extcon_probe(struct platform_devic=
e *pdev)
>  	}
> =20
>  	platform_set_drvdata(pdev, info);
> -	device_init_wakeup(dev, 1);
> +	device_init_wakeup(dev, true);
> +	dev_pm_set_wake_irq(dev, info->id_irq);
> =20
>  	/* Perform initial detection */
>  	usb_extcon_detect_cable(&info->wq_detcable.work);
> @@ -155,6 +157,9 @@ static int usb_extcon_remove(struct platform_devi=
ce *pdev)
> =20
>  	cancel_delayed_work_sync(&info->wq_detcable);
> =20
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +
>  	return 0;
>  }
> =20
> @@ -164,12 +169,6 @@ static int usb_extcon_suspend(struct device *dev=
)
>  	struct usb_extcon_info *info =3D dev_get_drvdata(dev);
>  	int ret =3D 0;
> =20
> -	if (device_may_wakeup(dev)) {
> -		ret =3D enable_irq_wake(info->id_irq);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/*
>  	 * We don't want to process any IRQs after this point
>  	 * as GPIOs used behind I2C subsystem might not be
> @@ -185,12 +184,6 @@ static int usb_extcon_resume(struct device *dev)
>  	struct usb_extcon_info *info =3D dev_get_drvdata(dev);
>  	int ret =3D 0;
> =20
> -	if (device_may_wakeup(dev)) {
> -		ret =3D disable_irq_wake(info->id_irq);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	enable_irq(info->id_irq);
> =20
>  	return ret;
>=20

