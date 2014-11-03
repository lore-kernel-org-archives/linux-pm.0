From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 12/47] mfd: ab8500-sysctrl: Register with kernel
 power-off handler
Date: Mon, 3 Nov 2014 17:55:46 +0000
Message-ID: <20141103175546.GP12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-13-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:37540 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbaKCRzw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 12:55:52 -0500
Received: by mail-qa0-f54.google.com with SMTP id u7so8803216qaz.27
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2014 09:55:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1414425354-10359-13-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org

On Mon, 27 Oct 2014, Guenter Roeck wrote:

> Register with kernel power-off handler instead of setting pm_power_of=
f
> directly. Register with low priority to reflect that the original cod=
e
> only sets pm_power_off if it was not already set.
>=20
> sysctrl_dev is set prior to power-off handler registration, and the
> power-off handler is unregistered prior to clearing sysrctrl_dev.
> It is therefore not necessary to check if sysctrl_dev is NULL in the
> power-off handler, and the check was removed. Setting sysctrl_dev to =
NULL
> in the remove function was also removed as unnecessary. With those ch=
anges,
> devm_register_power_off_handler can be used to register the poeroff h=
andler.
> The now empty remove function was retained since the ab8500_restart f=
unction,
> which is currently unused, would likely need some cleanup if it was e=
ver used.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Replace poweroff in all newly introduced variables and in text
>   with power_off or power-off as appropriate
> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
> v2:
> - Use define to specify poweroff handler priority
> - Use devm_register_power_off_handler
> - Use dev_warn instead of dev_err
> - Since we use devm_register_power_off_handler,
>   we need to check if sysctrl_dev in the poweroff handler to avoid
>   a race condition on unload, so this check is no longer removed
>=20
>  drivers/mfd/ab8500-sysctrl.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctr=
l.c
> index 8e0dae5..c49ecaf 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
> @@ -23,7 +24,8 @@
> =20
>  static struct device *sysctrl_dev;
> =20
> -static void ab8500_power_off(void)
> +static int ab8500_power_off(struct notifier_block *this, unsigned lo=
ng unused1,
> +			    void *unused2)
>  {
>  	sigset_t old;
>  	sigset_t all;
> @@ -36,7 +38,7 @@ static void ab8500_power_off(void)
> =20
>  	if (sysctrl_dev =3D=3D NULL) {
>  		pr_err("%s: sysctrl not initialized\n", __func__);
> -		return;
> +		return NOTIFY_DONE;
>  	}
> =20
>  	/*
> @@ -83,8 +85,15 @@ shutdown:
>  					 AB8500_STW4500CTRL1_SWRESET4500N);
>  		(void)sigprocmask(SIG_SETMASK, &old, NULL);
>  	}
> +
> +	return NOTIFY_DONE;
>  }
> =20
> +static struct notifier_block ab8500_power_off_nb =3D {
> +	.notifier_call =3D ab8500_power_off,
> +	.priority =3D POWER_OFF_PRIORITY_LOW,
> +};
> +
>  /*
>   * Use the AB WD to reset the platform. It will perform a hard
>   * reset instead of a soft reset. Write the reset reason to
> @@ -185,6 +194,7 @@ static int ab8500_sysctrl_probe(struct platform_d=
evice *pdev)
>  	struct ab8500 *ab8500 =3D dev_get_drvdata(pdev->dev.parent);
>  	struct ab8500_platform_data *plat;
>  	struct ab8500_sysctrl_platform_data *pdata;
> +	int err;
> =20
>  	plat =3D dev_get_platdata(pdev->dev.parent);
> =20
> @@ -193,8 +203,10 @@ static int ab8500_sysctrl_probe(struct platform_=
device *pdev)
> =20
>  	sysctrl_dev =3D &pdev->dev;
> =20
> -	if (!pm_power_off)
> -		pm_power_off =3D ab8500_power_off;
> +	err =3D devm_register_power_off_handler(sysctrl_dev,
> +					      &ab8500_power_off_nb);
> +	if (err)
> +		dev_warn(&pdev->dev, "Failed to register power-off handler\n");
> =20
>  	pdata =3D plat->sysctrl;
>  	if (pdata) {
> @@ -228,9 +240,6 @@ static int ab8500_sysctrl_remove(struct platform_=
device *pdev)
>  {
>  	sysctrl_dev =3D NULL;
> =20
> -	if (pm_power_off =3D=3D ab8500_power_off)
> -		pm_power_off =3D NULL;
> -
>  	return 0;
>  }
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
