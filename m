From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] PM / watchdog: iTCO: stop watchdog during system suspend
Date: Wed, 01 Apr 2015 18:11:24 -0700
Message-ID: <551C973C.3080902@roeck-us.net>
References: <2017660.nPaHVT8bW3@vostro.rjw.lan> <48A8D21F3057FE4DB59C829EB7A1638A10EA3254@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33496 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbDBBLe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 21:11:34 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YdTfQ-000WUN-KW
	for linux-pm@vger.kernel.org; Thu, 02 Apr 2015 01:11:33 +0000
In-Reply-To: <48A8D21F3057FE4DB59C829EB7A1638A10EA3254@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Fu, Borun" <borun.fu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "Li, Aubrey" <aubrey.li@intel.com>, "Wang, Frank" <frank.wang@intel.com>

On 04/01/2015 05:52 PM, Fu, Borun wrote:
> Hi Rafael,
> watchdog_active() function is not implemented in your patch. Pls. add=
 it.
>

Please explain why using the standard watchdog_active() would not work =
here.

Guenter

> static int watchdog_active(struct device *dev)
> {
>         unsigned int val;
>
>         spin_lock(&iTCO_wdt_private.io_lock);
>         val =3D inw(TCO1_CNT);
>         spin_unlock(&iTCO_wdt_private.io_lock);
>
>         /* Bit 11: TCO Timer Halt */
>         if (val & 0x0800)
>                 return 0;
>         else
>                 return 1;
> }
>
> Regards,
> Borun
> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Thursday, April 02, 2015 8:31
> To: linux-watchdog@vger.kernel.org
> Cc: Linux Kernel Mailing List; Linux PM list; Wim Van Sebroeck; Li, A=
ubrey; Fu, Borun
> Subject: [PATCH] PM / watchdog: iTCO: stop watchdog during system sus=
pend
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the target sleep state of the system is not an ACPI sleep state (S=
1, S2 or S3), the TCO watchdog needs to be stopped during system suspen=
d, because it may not be possible to ping it any more after timekeeping=
 has been suspended (suspend-to-idle does that for one example).
>
> For this reason, provide ->suspend_noirq and ->resume_noirq callbacks=
 for the iTCO watchdog driver and use them to stop and restart the watc=
hdog during system suspend and resume, respectively, if the system is n=
ot going to enter an ACPI sleep state (in which case the watchdog will =
be stopped by the platform firmware before the state is entered).
>
> Reported-by: Borun Fu <borun.fu@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/watchdog/iTCO_wdt.c |   51 ++++++++++++++++++++++++++++++++=
++++++++++++
>   1 file changed, 51 insertions(+)
>
> Index: linux-pm/drivers/watchdog/iTCO_wdt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/watchdog/iTCO_wdt.c
> +++ linux-pm/drivers/watchdog/iTCO_wdt.c
> @@ -51,6 +51,7 @@
>   #define DRV_VERSION	"1.11"
>
>   /* Includes */
> +#include <linux/acpi.h>			/* For ACPI support */
>   #include <linux/module.h>		/* For module specific items */
>   #include <linux/moduleparam.h>		/* For new moduleparam's */
>   #include <linux/types.h>		/* For standard types (like size_t) */
> @@ -103,6 +104,8 @@ static struct {		/* this is private data
>   	struct platform_device *dev;
>   	/* the PCI-device */
>   	struct pci_dev *pdev;
> +	/* whether or not the watchdog has been suspended */
> +	bool suspended;
>   } iTCO_wdt_private;
>
>   /* module parameters */
> @@ -571,12 +574,60 @@ static void iTCO_wdt_shutdown(struct pla
>   	iTCO_wdt_stop(NULL);
>   }
>
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * Suspend-to-idle requires this, because it stops the ticks and
> +timekeeping, so
> + * the watchdog cannot be pinged while in that state.  In ACPI sleep
> +states the
> + * watchdog is stopped by the platform firmware.
> + */
> +
> +#ifdef CONFIG_ACPI
> +static inline bool need_suspend(void)
> +{
> +	return acpi_target_system_state() =3D=3D ACPI_STATE_S0; } #else sta=
tic
> +inline bool need_suspend(void) { return true; } #endif
> +
> +static int iTCO_wdt_suspend_noirq(struct device *dev) {
> +	int ret =3D 0;
> +
> +	iTCO_wdt_private.suspended =3D false;
> +	if (watchdog_active(&iTCO_wdt_watchdog_dev) && need_suspend()) {
> +		ret =3D iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
> +		if (!ret)
> +			iTCO_wdt_private.suspended =3D true;
> +	}
> +	return ret;
> +}
> +
> +static int iTCO_wdt_resume_noirq(struct device *dev) {
> +	if (iTCO_wdt_private.suspended)
> +		iTCO_wdt_start(&iTCO_wdt_watchdog_dev);
> +
> +	return 0;
> +}
> +
> +struct dev_pm_ops iTCO_wdt_pm =3D {
> +	.suspend_noirq =3D iTCO_wdt_suspend_noirq,
> +	.resume_noirq =3D iTCO_wdt_resume_noirq, };
> +
> +#define ITCO_WDT_PM_OPS	&iTCO_wdt_pm
> +#else
> +#define ITCO_WDT_PM_OPS	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
>   static struct platform_driver iTCO_wdt_driver =3D {
>   	.probe          =3D iTCO_wdt_probe,
>   	.remove         =3D iTCO_wdt_remove,
>   	.shutdown       =3D iTCO_wdt_shutdown,
>   	.driver         =3D {
>   		.name   =3D DRV_NAME,
> +		.pm     =3D ITCO_WDT_PM_OPS,
>   	},
>   };
>
>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BD=EF=BF=BD\=EF=BF=BD=EF=BF=BD =EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=
=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=
=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=
=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=
=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!tml=3D
>

