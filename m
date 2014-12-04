From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] MFD / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Thu, 4 Dec 2014 08:37:30 +0000
Message-ID: <20141204083730.GG327@x1>
References: <2857906.7ft1XTNUKe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55730 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbaLDIhf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 03:37:35 -0500
Received: by mail-qa0-f49.google.com with SMTP id s7so11304284qap.8
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 00:37:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2857906.7ft1XTNUKe@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, 04 Dec 2014, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
>=20
> Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
> drivers/mfd/.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIM=
E if
> PM_SLEEP is selected) which is only in linux-next at the moment (via =
the
> linux-pm tree).
>=20
> Please let me know if it is OK to take this one into linux-pm.

It's okay to take the patch.

Acked-by: Lee Jones <lee.jones@linaro.org>

> ---
>  drivers/mfd/ab8500-gpadc.c |    2 +-
>  drivers/mfd/arizona-core.c |    4 ++--
>  drivers/mfd/wm8994-core.c  |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> Index: linux-pm/drivers/mfd/ab8500-gpadc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/mfd/ab8500-gpadc.c
> +++ linux-pm/drivers/mfd/ab8500-gpadc.c
> @@ -867,7 +867,7 @@ static void ab8500_gpadc_read_calibratio
>  		gpadc->cal_data[ADC_INPUT_VBAT].offset);
>  }
> =20
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  static int ab8500_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct ab8500_gpadc *gpadc =3D dev_get_drvdata(dev);
> Index: linux-pm/drivers/mfd/wm8994-core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/mfd/wm8994-core.c
> +++ linux-pm/drivers/mfd/wm8994-core.c
> @@ -116,7 +116,7 @@ static const char *wm8958_main_supplies[
>  	"SPKVDD2",
>  };
> =20
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  static int wm8994_suspend(struct device *dev)
>  {
>  	struct wm8994 *wm8994 =3D dev_get_drvdata(dev);
> Index: linux-pm/drivers/mfd/arizona-core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/mfd/arizona-core.c
> +++ linux-pm/drivers/mfd/arizona-core.c
> @@ -330,7 +330,7 @@ err_fll:
>  		return err;
>  }
> =20
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  static int arizona_runtime_resume(struct device *dev)
>  {
>  	struct arizona *arizona =3D dev_get_drvdata(dev);
> @@ -1024,7 +1024,7 @@ int arizona_dev_init(struct arizona *ari
>  		goto err_irq;
>  	}
> =20
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  	regulator_disable(arizona->dcvdd);
>  #endif
> =20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
