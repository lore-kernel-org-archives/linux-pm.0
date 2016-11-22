From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 2/8] power: add power sequence library
Date: Tue, 22 Nov 2016 03:23:12 +0100
Message-ID: <CAJZ5v0i-_pHS+N-k7QVuc_0StT+BaFB+2fuHJpCfngtQV5z76w@mail.gmail.com>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com> <1479087359-7547-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479087359-7547-3-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2016 at 2:35 AM, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org> wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
>
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices. The pwrseq
> librares always need to allocate extra instance for compatible
> string match.
>
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover other controls in
> future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
>
> For new power sequence library, it can add its compatible string
> to pwrseq_of_match_table, then the pwrseq core will match it with
> DT's, and choose this library at runtime.
>
> Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> Tested-by: Maciej S. Szmigiero <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
> Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  MAINTAINERS                           |   9 ++
>  drivers/power/Kconfig                 |   1 +
>  drivers/power/Makefile                |   1 +
>  drivers/power/pwrseq/Kconfig          |  21 +++
>  drivers/power/pwrseq/Makefile         |   2 +
>  drivers/power/pwrseq/core.c           | 237 ++++++++++++++++++++++++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c | 183 ++++++++++++++++++++++++++
>  include/linux/power/pwrseq.h          |  60 +++++++++
>  8 files changed, 514 insertions(+)
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d838cf..066b1e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9621,6 +9621,15 @@ F:       include/linux/pm_*
>  F:     include/linux/powercap.h
>  F:     drivers/powercap/
>
> +POWER SEQUENCE LIBRARY
> +M:     Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> +L:     linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/power/pwrseq/
> +F:     drivers/power/pwrseq/
> +F:     include/linux/power/pwrseq.h/
> +
>  POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
>  M:     Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>  L:     linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 63454b5..c1bb046 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -1,3 +1,4 @@
>  source "drivers/power/avs/Kconfig"
>  source "drivers/power/reset/Kconfig"
>  source "drivers/power/supply/Kconfig"
> +source "drivers/power/pwrseq/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index ff35c71..7db8035 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_POWER_AVS)                += avs/
>  obj-$(CONFIG_POWER_RESET)      += reset/
>  obj-$(CONFIG_POWER_SUPPLY)     += supply/
> +obj-$(CONFIG_POWER_SEQUENCE)   += pwrseq/
> diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
> new file mode 100644
> index 0000000..88f5597
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,21 @@
> +#
> +# Power Sequence library
> +#
> +
> +menuconfig POWER_SEQUENCE
> +       bool "Power sequence control"
> +       depends on OF
> +       help
> +          It is used for drivers which needs to do power sequence
> +          (eg, turn on clock, toggle reset gpio) before the related
> +          devices can be found by hardware, eg, USB bus.
> +
> +if POWER_SEQUENCE
> +
> +config PWRSEQ_GENERIC
> +       bool "Generic power sequence control"
> +       default y
> +       help
> +          This is the generic power sequence control library, and is
> +          supposed to support common power sequence usage.
> +endif
> diff --git a/drivers/power/pwrseq/Makefile b/drivers/power/pwrseq/Makefile
> new file mode 100644
> index 0000000..ad82389
> --- /dev/null
> +++ b/drivers/power/pwrseq/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_POWER_SEQUENCE) += core.o
> +obj-$(CONFIG_PWRSEQ_GENERIC) += pwrseq_generic.o
> diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
> new file mode 100644
> index 0000000..e3c1fbb
> --- /dev/null
> +++ b/drivers/power/pwrseq/core.c
> @@ -0,0 +1,237 @@
> +/*
> + * core.c      power sequence core file
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Author: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.

The last paragraph is not necessary AFAICS.

> + */
> +
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/power/pwrseq.h>
> +
> +static DEFINE_MUTEX(pwrseq_list_mutex);
> +static LIST_HEAD(pwrseq_list);
> +
> +static int pwrseq_get(struct device_node *np, struct pwrseq *p)
> +{
> +       if (p && p->get)
> +               return p->get(np, p);
> +
> +       return -ENOTSUPP;
> +}
> +
> +static int pwrseq_on(struct pwrseq *p)
> +{
> +       if (p && p->on)
> +               return p->on(p);
> +
> +       return -ENOTSUPP;
> +}
> +
> +static void pwrseq_off(struct pwrseq *p)
> +{
> +       if (p && p->off)
> +               p->off(p);
> +}
> +
> +static void pwrseq_put(struct pwrseq *p)
> +{
> +       if (p && p->put)
> +               p->put(p);
> +}
> +
> +static int pwrseq_suspend(struct pwrseq *p)
> +{
> +       if (p && p->suspend)
> +               return p->suspend(p);
> +
> +       return 0;
> +}
> +
> +static int pwrseq_resume(struct pwrseq *p)
> +{
> +       if (p && p->resume)
> +               return p->resume(p);
> +
> +       return 0;
> +}
> +
> +/**
> + * pwrseq_register: add pwrseq instance to global pwrseq list
> + *
> + * @pwrseq: the pwrseq instance
> + */
> +void pwrseq_register(struct pwrseq *pwrseq)
> +{
> +       mutex_lock(&pwrseq_list_mutex);
> +       list_add(&pwrseq->node, &pwrseq_list);
> +       mutex_unlock(&pwrseq_list_mutex);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_register);
> +
> +/**
> + * pwrseq_unregister: remove pwrseq instance from global pwrseq list
> + *
> + * @pwrseq: the pwrseq instance
> + */
> +void pwrseq_unregister(struct pwrseq *pwrseq)
> +{
> +       mutex_lock(&pwrseq_list_mutex);
> +       list_del(&pwrseq->node);
> +       mutex_unlock(&pwrseq_list_mutex);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_unregister);
> +
> +static struct pwrseq *pwrseq_find_available_instance(struct device_node *np)
> +{
> +       struct pwrseq *pwrseq;
> +
> +       list_for_each_entry(pwrseq, &pwrseq_list, node) {
> +               if (pwrseq->used)
> +                       continue;
> +
> +               /* compare compatible string for pwrseq node */
> +               if (of_match_node(pwrseq->pwrseq_of_match_table, np)) {
> +                       pwrseq->used = true;
> +                       return pwrseq;
> +               }
> +
> +               /* return generic pwrseq instance */
> +               if (!strcmp(pwrseq->pwrseq_of_match_table->compatible,
> +                               "generic")) {
> +                       pr_debug("using generic pwrseq instance for %s\n",
> +                               np->full_name);
> +                       pwrseq->used = true;
> +                       return pwrseq;
> +               }
> +       }
> +       pr_warn("Can't find any pwrseq instances for %s\n", np->full_name);

pr_debug() ?

> +
> +       return NULL;
> +}
> +
> +/**
> + * of_pwrseq_on: do power sequence on for device node

of_pwrseq_on - Carry out power sequence on for device node

Argument description should follow this line.

> + *
> + * This API is used to power on single device, if the host
> + * controller only needs to handle one child device (this device
> + * node points to), use this API. If multiply devices are needed
> + * to handle on bus, use of_pwrseq_on_list.

That's unclear.

What about "Carry out a single device power on.  If multiple devices
need to be handled, use of_pwrseq_on_list() instead."

> + *
> + * @np: the device node would like to power on
> + *
> + * On successful, it returns pwrseq instance, otherwise an error value.

"Return a pointer to the power sequence instance on success, or an
error code otherwise."

> + */
> +struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +       struct pwrseq *pwrseq;
> +       int ret;
> +
> +       pwrseq = pwrseq_find_available_instance(np);

What does guarantee the integrity of ths list at this point?

> +       if (!pwrseq)
> +               return ERR_PTR(-ENONET);

ENOENT I suppose?

> +
> +       ret = pwrseq_get(np, pwrseq);
> +       if (ret) {
> +               /* Mark current pwrseq as unused */
> +               pwrseq->used = false;
> +               return ERR_PTR(ret);
> +       }
> +
> +       ret = pwrseq_on(pwrseq);
> +       if (ret)
> +               goto pwr_put;
> +
> +       return pwrseq;
> +
> +pwr_put:
> +       pwrseq_put(pwrseq);
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_on);
> +
> +/**
> + * of_pwrseq_off: do power sequence off for this pwrseq instance
> + *
> + * This API is used to power off single device, it is the opposite
> + * operation for of_pwrseq_on.
> + *
> + * @pwrseq: the pwrseq instance which related device would like to be off
> + */
> +void of_pwrseq_off(struct pwrseq *pwrseq)
> +{
> +       pwrseq_off(pwrseq);
> +       pwrseq_put(pwrseq);
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_off);

What happens if two code paths attempt to turn the same power sequence
off in parallel?  Can it ever happen?  If not, then why not?

> +
> +/**
> + * of_pwrseq_on_list: do power sequence on for list
> + *
> + * This API is used to power on multiple devices at single bus.
> + * If there are several devices on bus (eg, USB bus), uses this
> + * this API. Otherwise, use of_pwrseq_on. After the device
> + * is powered on successfully, it will be added to pwrseq list for
> + * this bus.
> + *
> + * @np: the device node would like to power on
> + * @head: the list head for pwrseq list on this bus
> + *
> + * On successful, it returns 0, otherwise an error value.

Please format the kerneldoc comment in a usual way.

> + */
> +int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
> +{
> +       struct pwrseq *pwrseq;
> +       struct pwrseq_list_per_dev *pwrseq_list_node;
> +
> +       pwrseq = of_pwrseq_on(np);
> +       if (IS_ERR(pwrseq))
> +               return PTR_ERR(pwrseq);
> +
> +       pwrseq_list_node = kzalloc(sizeof(*pwrseq_list_node), GFP_KERNEL);

Why don't you allocate memory before turning the power sequence on?

> +       if (!pwrseq_list_node) {
> +               of_pwrseq_off(pwrseq);
> +               return -ENOMEM;
> +       }
> +       pwrseq_list_node->pwrseq = pwrseq;
> +       list_add(&pwrseq_list_node->list, head);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_on_list);

So the caller is supposed to provide a list head of the list to put
the power sequence object into on success, right?

Can you explain to me what the idea here is, please?

Also, what's the protection of the list against concurrent access?

> +
> +/**
> + * of_pwrseq_off_list: do power sequence off for the list
> + *
> + * This API is used to power off all devices on this bus, it is
> + * the opposite operation for of_pwrseq_on_list.
> + *
> + * @head: the list head for pwrseq instance list on this bus
> + */
> +void of_pwrseq_off_list(struct list_head *head)
> +{
> +       struct pwrseq *pwrseq;
> +       struct pwrseq_list_per_dev *pwrseq_list_node, *tmp_node;
> +
> +       list_for_each_entry_safe(pwrseq_list_node, tmp_node, head, list) {
> +               pwrseq = pwrseq_list_node->pwrseq;
> +               of_pwrseq_off(pwrseq);
> +               list_del(&pwrseq_list_node->list);
> +               kfree(pwrseq_list_node);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_off_list);

This looks horribly inefficient.

Is the user expected to create the list from scratch every time things
are turned on?

OK, let's stop here.  I need the above to be clarified first.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
