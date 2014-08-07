From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH] power: reset: add PowerPath poweroff support
Date: Thu, 7 Aug 2014 16:58:14 +0300
Message-ID: <53E385F6.2020903@nvidia.com>
References: <8B68774BB69A844693005BA12A50F1146D4AE3@XSMBXSVR01.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6722 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbaHGN6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Aug 2014 09:58:17 -0400
In-Reply-To: <8B68774BB69A844693005BA12A50F1146D4AE3@XSMBXSVR01.xsens-tech.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Moll?= <Rene.Moll@xsens.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <Frans.Klaver@xsens.com>

Not my subsystem, but some general points..

On 07/08/14 15:44, Ren=E9 Moll wrote:
>
> Signed-off-by: Ren=E9 Moll <rene.moll@xsens.com>

Please add a commit message. You should describe the hardware, it's=20
capabilities and what features this driver implements.

>
> ---
>   drivers/power/reset/Kconfig              |   9 +
>   drivers/power/reset/Makefile             |   1 +
>   drivers/power/reset/powerpath-poweroff.c | 418 ++++++++++++++++++++=
+++++++++++
>   3 files changed, 428 insertions(+)
>   create mode 100644 drivers/power/reset/powerpath-poweroff.c
>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfi=
g
> index 6d452a7..83ce507 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -26,6 +26,15 @@ config POWER_RESET_MSM
>          help
>            Power off and restart support for Qualcomm boards.
>
> +config POWER_RESET_POWERPATH
> +       tristate "PowerPath power-off driver"
> +       depends on OF_GPIO && POWER_RESET
> +       help
> +         Supports powerdown with an external PowerPath IC.
> +
>   config POWER_RESET_QNAP
>          bool "QNAP power-off driver"
>          depends on OF_GPIO && POWER_RESET && PLAT_ORION
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makef=
ile
> index a5b4a77..54a1f53 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -1,6 +1,7 @@
>   obj-$(CONFIG_POWER_RESET_AS3722) +=3D as3722-poweroff.o
>   obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>   obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_POWERPATH) +=3D powerpath-poweroff.o
>   obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
>   obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
>   obj-$(CONFIG_POWER_RESET_VEXPRESS) +=3D vexpress-poweroff.o
> diff --git a/drivers/power/reset/powerpath-poweroff.c b/drivers/power=
/reset/powerpath-poweroff.c
> new file mode 100644
> index 0000000..c902827
> --- /dev/null
> +++ b/drivers/power/reset/powerpath-poweroff.c
> @@ -0,0 +1,418 @@
> +/*
> + * PowerPath driver
> + *
> + * Copyright (C) 2014, Xsens Technologies BV <info@xsens.com>
> + * Maintainer: Ren=E9 Moll <linux@r-moll.nl>
> + *
> + * This program is free software: you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation, either version 3 of the License, or
> + * (at your option) any later version.

The kernel is GPL v2.

> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/license=
s/>.
> + *
> + * ----------------------------------------
> + * - Description
> + * ----------------------------------------
> + *
> + * This driver is to be used with an external PowerPath Controller.
> + * Its function is to determine when a external shut down is trigger=
ed
> + * and react by properly shutting down the system.
> + *
> + * This driver expects a device tree with a powerpath entry for pin =
mapping.
> + *
> + * Example:
> + *
> + * powerpath {
> + *     compatible =3D "powerpath,ltc2952";

Looks like this chip is made by Linear Technology, for which the vendor=
=20
prefix is "lltc". So the compatibility string should be "lltc,ltc2952".

> + *
> + *     trigger-gpios =3D <&gpio0 16 GPIO_ACTIVE_LOW>;
> + *     watchdog-gpios =3D <&gpio3 4 GPIO_ACTIVE_HIGH>;
> + *     kill-gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
> + * };
> + *
> + * ----------------------------------------
> + * - GPIO
> + * ----------------------------------------
> + *
> + * The following GPIOs are used:
> + * - trigger (input)
> + *     A level change indicates the shut-down trigger. If it's state=
 reverts
> + *     within the time-out defined by trigger_delay, the shut down i=
s not
> + *     executed.
> + *
> + * - watchdog (output)
> + *     Once a shut down is triggered, the driver will toggle this si=
gnal,
> + *     with an internal (wde_interval) to stall the hardware shut do=
wn.
> + *
> + * - kill (output)
> + *     The last action during shut down is triggering this signallin=
g, such
> + *     that the PowerPath Control will power down the hardware.
> + *
> + * ----------------------------------------
> + * - Interrupts
> + * ----------------------------------------
> + *
> + * The driver requires a non-shared, edge-triggered interrupt on the=
 trigger
> + * GPIO.

You should add a description of the hardware and device tree node along=
=20
with properties (like this one!) under Documentation/devicetree/binding=
s/...
Don't refer to Linux-specific driver implementation details, though.

> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/ktime.h>
> +#include <linux/slab.h>
> +#include <linux/kmod.h>
> +#include <linux/module.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/reboot.h>
> +
> +static int powerpath_poweroff_panic;
> +
> +struct powerpath_poweroff_data {
> +       struct hrtimer timer_trigger;
> +       struct hrtimer timer_wde;
> +
> +       ktime_t trigger_delay;
> +       ktime_t wde_interval;
> +
> +       struct device *dev;
> +
> +       unsigned int virq;
> +
> +       /**
> +        * 0: trigger
> +        * 1: watchdog
> +        * 2: kill
> +        */
> +       struct gpio_desc *gpio[3];
> +};
> +
> +#define POWERPATH_IO_TRIGGER   0
> +#define POWERPATH_IO_WATCHDOG  1
> +#define POWERPATH_IO_KILL      2
> +
> +/**
> + * powerpath_poweroff_timer_wde - Timer callback
> + * Toggles the watchdog reset signal each wde_interval
> + *
> + * @timer: corresponding timer
> + *
> + * Returns HRTIMER_RESTART for an infinite loop which will only stop=
 when the
> + * machine actually shuts down
> + */
> +static enum hrtimer_restart powerpath_poweroff_timer_wde(struct hrti=
mer *timer)
> +{
> +       ktime_t now;
> +       int state;
> +       unsigned long overruns;
> +       struct powerpath_poweroff_data *data =3D container_of(timer,
> +               struct powerpath_poweroff_data, timer_wde);
> +
> +       if (powerpath_poweroff_panic)
> +               return HRTIMER_NORESTART;
> +
> +       state =3D gpiod_get_value(data->gpio[POWERPATH_IO_WATCHDOG]);
> +       gpiod_set_value(data->gpio[POWERPATH_IO_WATCHDOG], !state);
> +
> +       now =3D hrtimer_cb_get_time(timer);
> +       overruns =3D hrtimer_forward(timer, now, data->wde_interval);
> +
> +       return HRTIMER_RESTART;
> +}
> +
> +static enum hrtimer_restart powerpath_poweroff_timer_trigger(
> +       struct hrtimer *timer)
> +{
> +       int ret;
> +       struct powerpath_poweroff_data *data =3D container_of(timer,
> +               struct powerpath_poweroff_data, timer_trigger);
> +
> +       /* Using halt here as shutdown does not work properly under B=
usyBox */
> +       static char *shutdown_argv[] =3D { "/sbin/halt", NULL };
> +       static char *shutdown_envp[] =3D {
> +               "HOME=3D/",
> +               "TERM=3Dlinux",
> +               "PATH=3D/sbin:/bin:/usr/sbin:/usr/bin", NULL
> +       };
> +
> +       ret =3D hrtimer_start(&data->timer_wde, data->wde_interval,
> +               HRTIMER_MODE_REL);
> +
> +       if (ret) {
> +               dev_err(data->dev, "unable to start the timer\n");
> +               /*
> +                * The device will not toggle the watchdog reset,
> +                * thus shut down is only safe if the PowerPath contr=
oller
> +                * has a long enough time-off before triggering a har=
dware
> +                * power-off.
> +                *
> +                * Only sending a warning as the system will power-of=
f anyway
> +                */
> +       }
> +
> +       dev_info(data->dev, "executing shutdown\n");
> +
> +       call_usermodehelper(shutdown_argv[0], shutdown_argv,
> +               shutdown_envp, UMH_NO_WAIT);

Any reason not to use orderly_poweroff()?

> +
> +       return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * powerpath_poweroff_handler - Interrupt handler
> + * Triggered each time the trigger signal changes state and (de)acti=
vates a
> + * time-out (timer_trigger). Once the time-out is actually reached t=
he shut
> + * down is executed.
> + *
> + * @irq: IRQ number
> + * @dev_id: pointer to the main data structure
> + */
> +static irqreturn_t powerpath_poweroff_handler(int irq, void *dev_id)
> +{
> +       int ret;
> +       struct powerpath_poweroff_data *data =3D dev_id;
> +
> +       if (powerpath_poweroff_panic)
> +               return IRQ_HANDLED;
> +
> +       if (hrtimer_active(&data->timer_wde)) {
> +               /* shutdown is already triggered, nothing to do any m=
ore */
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (!hrtimer_active(&data->timer_trigger)) {
> +               ret =3D hrtimer_start(&data->timer_trigger, data->tri=
gger_delay,
> +                       HRTIMER_MODE_REL);
> +
> +               if (ret)
> +                       dev_err(data->dev, "unable to start the wait =
timer\n");
> +
> +               return IRQ_HANDLED;
> +       } else {
> +               ret =3D hrtimer_cancel(&data->timer_trigger);
> +               /* omitting return value check, timer should have bee=
n valid */
> +
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}

Looks like this function always returns IRQ_HANDLED, so you could=20
restructure it a bit.

> +
> +static void powerpath_poweroff_kill(struct platform_device *pdev)
> +{
> +       struct powerpath_poweroff_data *data =3D platform_get_drvdata=
(pdev);
> +
> +       gpiod_set_value(data->gpio[POWERPATH_IO_KILL], 1);
> +}
> +
> +static void powerpath_poweroff_shutdown(struct platform_device *pdev=
)
> +{
> +       if (system_state =3D=3D SYSTEM_RESTART || system_state =3D=3D=
 SYSTEM_BOOTING)
> +               return;
> +
> +       powerpath_poweroff_kill(pdev);
> +}
> +
> +static int powerpath_poweroff_suspend(struct platform_device *pdev,
> +       pm_message_t state)
> +{
> +       return -ENOSYS;
> +}
> +
> +static int powerpath_poweroff_resume(struct platform_device *pdev)
> +{
> +       return -ENOSYS;
> +}
> +
> +static void powerpath_poweroff_default(struct powerpath_poweroff_dat=
a *data)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(data->gpio); i++)
> +               data->gpio[i] =3D NULL;
> +
> +       data->wde_interval =3D ktime_set(0, 300L*1E6L);
> +       data->trigger_delay =3D ktime_set(2, 500L*1E6L);
> +
> +       hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
> +       data->timer_trigger.function =3D &powerpath_poweroff_timer_tr=
igger;
> +
> +       hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_=
REL);
> +       data->timer_wde.function =3D &powerpath_poweroff_timer_wde;
> +}
> +
> +static int powerpath_poweroff_init(struct platform_device *pdev,
> +       struct powerpath_poweroff_data *data)
> +{
> +       int ret, virq;
> +       unsigned int i;
> +
> +       static char *name[] =3D {
> +               "trigger",
> +               "watchdog",
> +               "kill",
> +               NULL
> +       };
> +
> +       powerpath_poweroff_default(data);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(data->gpio); i++) {
> +               data->gpio[i] =3D gpiod_get(&pdev->dev, name[i]);
> +
> +               if (IS_ERR(data->gpio[i])) {
> +                       ret =3D PTR_ERR(data->gpio[i]);
> +                       dev_err(&pdev->dev,
> +                               "unable to claim the following gpio: =
%s\n",
> +                               name[i]);
> +                       goto err;
> +               }
> +       }

If an error occurs mid-loop, this can leave some gpios get'ted. I=20
recommend switching to devm_gpiod_get.

> +
> +       ret =3D gpiod_direction_output(data->gpio[POWERPATH_IO_WATCHD=
OG], 0);
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to use watchdog-gpio as o=
utput\n");
> +               goto err_io;
> +       }
> +
> +       ret =3D gpiod_direction_output(data->gpio[POWERPATH_IO_KILL],=
 0);
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to use kill-gpio as outpu=
t\n");
> +               goto err_io;
> +       }
> +
> +       virq =3D gpiod_to_irq(data->gpio[POWERPATH_IO_TRIGGER]);
> +       if (virq < 0) {
> +               dev_err(&pdev->dev, "cannot map GPIO as interrupt");
> +               goto err_io;
> +       }
> +
> +       data->virq =3D virq;
> +       ret =3D request_irq(virq,
> +               powerpath_poweroff_handler,
> +               (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
> +               "powerpath-poweroff",
> +               data
> +       );
> +
> +       if (ret) {
> +               dev_err(&pdev->dev, "cannot configure an interrupt ha=
ndler\n");
> +               goto err_io;
> +       }
> +
> +       return 0;
> +
> +err_io:
> +       for (i =3D 0; i < ARRAY_SIZE(data->gpio); i++)
> +               gpiod_put(data->gpio[i]);
> +
> +err:
> +       return ret;
> +}
> +
> +static int powerpath_poweroff_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct powerpath_poweroff_data *data;
> +
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);

I'd use devm_kzalloc, devm_gpiod_get and devm_request_irq. That would=20
clean up the error handling and remove the need for the _remove functio=
n.

> +       if (!data)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, data);
> +       data->dev =3D &pdev->dev;
> +
> +       ret =3D powerpath_poweroff_init(pdev, data);
> +       if (ret)
> +               goto err;
> +
> +       dev_info(&pdev->dev, "probe successful\n");
> +
> +       return 0;
> +
> +err:
> +       kfree(data);
> +       return ret;
> +}
> +
> +static int powerpath_poweroff_remove(struct platform_device *pdev)
> +{
> +       unsigned int i;
> +       struct powerpath_poweroff_data *data =3D platform_get_drvdata=
(pdev);
> +
> +       if (data) {
> +               free_irq(data->virq, data);
> +
> +               for (i =3D 0; i < ARRAY_SIZE(data->gpio); i++)
> +                       gpiod_put(data->gpio[i]);
> +
> +               kfree(data);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id of_powerpath_poweroff_match[] =3D {
> +       { .compatible =3D "powerpath,ltc2952" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, of_powerpath_poweroff_match);
> +
> +static struct platform_driver powerpath_poweroff_driver =3D {
> +       .probe =3D powerpath_poweroff_probe,
> +       .remove =3D powerpath_poweroff_remove,
> +       .driver =3D {
> +               .name =3D "powerpath-poweroff",
> +               .owner =3D THIS_MODULE,
> +               .of_match_table =3D of_powerpath_poweroff_match,
> +       },
> +       .suspend =3D powerpath_poweroff_suspend,
> +       .resume =3D powerpath_poweroff_resume,
> +       .shutdown =3D powerpath_poweroff_shutdown,

Based on other drivers, looks like what you're supposed to do is store =
a=20
function pointer in `pm_power_off'. Also, no need to specify suspend an=
d=20
resume if you don't implement them anyway.

> +};
> +
> +static int powerpath_poweroff_notify_panic(struct notifier_block *nb=
,
> +       unsigned long code, void *unused)
> +{
> +       powerpath_poweroff_panic =3D 1;
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block powerpath_poweroff_panic_nb =3D {
> +       .notifier_call =3D powerpath_poweroff_notify_panic,
> +};
> +
> +static int __init powerpath_poweroff_platform_init(void)
> +{
> +       powerpath_poweroff_panic =3D 0;
> +
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +               &powerpath_poweroff_panic_nb);
> +
> +       return platform_driver_register(&powerpath_poweroff_driver);
> +}
> +
> +static void __exit powerpath_poweroff_platform_exit(void)
> +{
> +       atomic_notifier_chain_unregister(&panic_notifier_list,
> +               &powerpath_poweroff_panic_nb);
> +
> +       platform_driver_unregister(&powerpath_poweroff_driver);
> +}
> +
> +module_init(powerpath_poweroff_platform_init);
> +module_exit(powerpath_poweroff_platform_exit);

You can leave a lot of this out by using module_platform_driver()

> +
> +MODULE_AUTHOR("Ren=E9 Moll <rene.moll@xsens.com>");
> +MODULE_DESCRIPTION("PowerPath power-off driver");
> +MODULE_LICENSE("GPL v2");
> +
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks for contributing!

Cheers,
Mikko
