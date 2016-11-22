From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v10 2/8] power: add power sequence library
Date: Tue, 22 Nov 2016 08:36:38 +0800
Message-ID: <20161122003638.GA10439@b29397-desktop>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
 <1479087359-7547-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479087359-7547-3-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2016 at 09:35:53AM +0800, Peter Chen wrote:
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

Rafael, would you get any chances to review this version, it makes
some changes according to your comments, I hope this patch set could
be in v4.10-rc1, thanks.

Peter
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
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
> @@ -9621,6 +9621,15 @@ F:	include/linux/pm_*
>  F:	include/linux/powercap.h
>  F:	drivers/powercap/
>  
> +POWER SEQUENCE LIBRARY
> +M:	Peter Chen <Peter.Chen@nxp.com>
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/pwrseq/
> +F:	drivers/power/pwrseq/
> +F:	include/linux/power/pwrseq.h/
> +
>  POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-pm@vger.kernel.org
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
>  obj-$(CONFIG_POWER_AVS)		+= avs/
>  obj-$(CONFIG_POWER_RESET)	+= reset/
>  obj-$(CONFIG_POWER_SUPPLY)	+= supply/
> +obj-$(CONFIG_POWER_SEQUENCE)	+= pwrseq/
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
> +	bool "Power sequence control"
> +	depends on OF
> +	help
> +	   It is used for drivers which needs to do power sequence
> +	   (eg, turn on clock, toggle reset gpio) before the related
> +	   devices can be found by hardware, eg, USB bus.
> +
> +if POWER_SEQUENCE
> +
> +config PWRSEQ_GENERIC
> +	bool "Generic power sequence control"
> +	default y
> +	help
> +	   This is the generic power sequence control library, and is
> +	   supposed to support common power sequence usage.
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
> + * core.c	power sequence core file
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Author: Peter Chen <peter.chen@nxp.com>
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
> +	if (p && p->get)
> +		return p->get(np, p);
> +
> +	return -ENOTSUPP;
> +}
> +
> +static int pwrseq_on(struct pwrseq *p)
> +{
> +	if (p && p->on)
> +		return p->on(p);
> +
> +	return -ENOTSUPP;
> +}
> +
> +static void pwrseq_off(struct pwrseq *p)
> +{
> +	if (p && p->off)
> +		p->off(p);
> +}
> +
> +static void pwrseq_put(struct pwrseq *p)
> +{
> +	if (p && p->put)
> +		p->put(p);
> +}
> +
> +static int pwrseq_suspend(struct pwrseq *p)
> +{
> +	if (p && p->suspend)
> +		return p->suspend(p);
> +
> +	return 0;
> +}
> +
> +static int pwrseq_resume(struct pwrseq *p)
> +{
> +	if (p && p->resume)
> +		return p->resume(p);
> +
> +	return 0;
> +}
> +
> +/**
> + * pwrseq_register: add pwrseq instance to global pwrseq list
> + *
> + * @pwrseq: the pwrseq instance
> + */
> +void pwrseq_register(struct pwrseq *pwrseq)
> +{
> +	mutex_lock(&pwrseq_list_mutex);
> +	list_add(&pwrseq->node, &pwrseq_list);
> +	mutex_unlock(&pwrseq_list_mutex);
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
> +	mutex_lock(&pwrseq_list_mutex);
> +	list_del(&pwrseq->node);
> +	mutex_unlock(&pwrseq_list_mutex);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_unregister);
> +
> +static struct pwrseq *pwrseq_find_available_instance(struct device_node *np)
> +{
> +	struct pwrseq *pwrseq;
> +
> +	list_for_each_entry(pwrseq, &pwrseq_list, node) {
> +		if (pwrseq->used)
> +			continue;
> +
> +		/* compare compatible string for pwrseq node */
> +		if (of_match_node(pwrseq->pwrseq_of_match_table, np)) {
> +			pwrseq->used = true;
> +			return pwrseq;
> +		}
> +
> +		/* return generic pwrseq instance */
> +		if (!strcmp(pwrseq->pwrseq_of_match_table->compatible,
> +				"generic")) {
> +			pr_debug("using generic pwrseq instance for %s\n",
> +				np->full_name);
> +			pwrseq->used = true;
> +			return pwrseq;
> +		}
> +	}
> +	pr_warn("Can't find any pwrseq instances for %s\n", np->full_name);
> +
> +	return NULL;
> +}
> +
> +/**
> + * of_pwrseq_on: do power sequence on for device node
> + *
> + * This API is used to power on single device, if the host
> + * controller only needs to handle one child device (this device
> + * node points to), use this API. If multiply devices are needed
> + * to handle on bus, use of_pwrseq_on_list.
> + *
> + * @np: the device node would like to power on
> + *
> + * On successful, it returns pwrseq instance, otherwise an error value.
> + */
> +struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +	struct pwrseq *pwrseq;
> +	int ret;
> +
> +	pwrseq = pwrseq_find_available_instance(np);
> +	if (!pwrseq)
> +		return ERR_PTR(-ENONET);
> +
> +	ret = pwrseq_get(np, pwrseq);
> +	if (ret) {
> +		/* Mark current pwrseq as unused */
> +		pwrseq->used = false;
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = pwrseq_on(pwrseq);
> +	if (ret)
> +		goto pwr_put;
> +
> +	return pwrseq;
> +
> +pwr_put:
> +	pwrseq_put(pwrseq);
> +	return ERR_PTR(ret);
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
> +	pwrseq_off(pwrseq);
> +	pwrseq_put(pwrseq);
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_off);
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
> + */
> +int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
> +{
> +	struct pwrseq *pwrseq;
> +	struct pwrseq_list_per_dev *pwrseq_list_node;
> +
> +	pwrseq = of_pwrseq_on(np);
> +	if (IS_ERR(pwrseq))
> +		return PTR_ERR(pwrseq);
> +
> +	pwrseq_list_node = kzalloc(sizeof(*pwrseq_list_node), GFP_KERNEL);
> +	if (!pwrseq_list_node) {
> +		of_pwrseq_off(pwrseq);
> +		return -ENOMEM;
> +	}
> +	pwrseq_list_node->pwrseq = pwrseq;
> +	list_add(&pwrseq_list_node->list, head);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_on_list);
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
> +	struct pwrseq *pwrseq;
> +	struct pwrseq_list_per_dev *pwrseq_list_node, *tmp_node;
> +
> +	list_for_each_entry_safe(pwrseq_list_node, tmp_node, head, list) {
> +		pwrseq = pwrseq_list_node->pwrseq;
> +		of_pwrseq_off(pwrseq);
> +		list_del(&pwrseq_list_node->list);
> +		kfree(pwrseq_list_node);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_off_list);
> diff --git a/drivers/power/pwrseq/pwrseq_generic.c b/drivers/power/pwrseq/pwrseq_generic.c
> new file mode 100644
> index 0000000..d7a77f2
> --- /dev/null
> +++ b/drivers/power/pwrseq/pwrseq_generic.c
> @@ -0,0 +1,183 @@
> +/*
> + * pwrseq_generic.c	Generic power sequence handling
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Author: Peter Chen <peter.chen@nxp.com>
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
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/slab.h>
> +
> +#include <linux/power/pwrseq.h>
> +
> +struct pwrseq_generic {
> +	struct pwrseq pwrseq;
> +	struct gpio_desc *gpiod_reset;
> +	struct clk *clks[PWRSEQ_MAX_CLKS];
> +	u32 duration_us;
> +};
> +
> +#define to_generic_pwrseq(p) container_of(p, struct pwrseq_generic, pwrseq)
> +
> +static int pwrseq_generic_alloc_instance(void);
> +static const struct of_device_id generic_id_table[] = {
> +	{ .compatible = "generic",},
> +	{ /* sentinel */ }
> +};
> +
> +static void pwrseq_generic_put(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk;
> +
> +	if (pwrseq_gen->gpiod_reset)
> +		gpiod_put(pwrseq_gen->gpiod_reset);
> +
> +	for (clk = 0; clk < PWRSEQ_MAX_CLKS; clk++)
> +		clk_put(pwrseq_gen->clks[clk]);
> +
> +	pwrseq_unregister(&pwrseq_gen->pwrseq);
> +	kfree(pwrseq_gen);
> +}
> +
> +static void pwrseq_generic_off(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk;
> +
> +	for (clk = PWRSEQ_MAX_CLKS - 1; clk >= 0; clk--)
> +		clk_disable_unprepare(pwrseq_gen->clks[clk]);
> +}
> +
> +static int pwrseq_generic_on(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk, ret = 0;
> +	struct gpio_desc *gpiod_reset = pwrseq_gen->gpiod_reset;
> +
> +	for (clk = 0; clk < PWRSEQ_MAX_CLKS && pwrseq_gen->clks[clk]; clk++) {
> +		ret = clk_prepare_enable(pwrseq_gen->clks[clk]);
> +		if (ret) {
> +			pr_err("Can't enable clock, ret=%d\n", ret);
> +			goto err_disable_clks;
> +		}
> +	}
> +
> +	if (gpiod_reset) {
> +		u32 duration_us = pwrseq_gen->duration_us;
> +
> +		if (duration_us <= 10)
> +			udelay(10);
> +		else
> +			usleep_range(duration_us, duration_us + 100);
> +		gpiod_set_value(gpiod_reset, 0);
> +	}
> +
> +	return ret;
> +
> +err_disable_clks:
> +	while (--clk >= 0)
> +		clk_disable_unprepare(pwrseq_gen->clks[clk]);
> +
> +	return ret;
> +}
> +
> +static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	enum of_gpio_flags flags;
> +	int reset_gpio, clk, ret = 0;
> +
> +	for (clk = 0; clk < PWRSEQ_MAX_CLKS; clk++) {
> +		pwrseq_gen->clks[clk] = of_clk_get(np, clk);
> +		if (IS_ERR(pwrseq_gen->clks[clk])) {
> +			ret = PTR_ERR(pwrseq_gen->clks[clk]);
> +			if (ret != -ENOENT)
> +				goto err_put_clks;
> +			pwrseq_gen->clks[clk] = NULL;
> +			break;
> +		}
> +	}
> +
> +	reset_gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, &flags);
> +	if (gpio_is_valid(reset_gpio)) {
> +		unsigned long gpio_flags;
> +
> +		if (flags & OF_GPIO_ACTIVE_LOW)
> +			gpio_flags = GPIOF_ACTIVE_LOW | GPIOF_OUT_INIT_LOW;
> +		else
> +			gpio_flags = GPIOF_OUT_INIT_HIGH;
> +
> +		ret = gpio_request_one(reset_gpio, gpio_flags,
> +				"pwrseq-reset-gpios");
> +		if (ret)
> +			goto err_put_clks;
> +
> +		pwrseq_gen->gpiod_reset = gpio_to_desc(reset_gpio);
> +		of_property_read_u32(np, "reset-duration-us",
> +				&pwrseq_gen->duration_us);
> +	} else if (reset_gpio == -ENOENT) {
> +		; /* no such gpio */
> +	} else {
> +		ret = reset_gpio;
> +		pr_err("Failed to get reset gpio on %s, err = %d\n",
> +				np->full_name, reset_gpio);
> +		goto err_put_clks;
> +	}
> +
> +	/* allocate new one for later pwrseq instance request */
> +	ret = pwrseq_generic_alloc_instance();
> +	if (ret)
> +		goto err_put_gpio;
> +
> +	return 0;
> +
> +err_put_gpio:
> +	if (pwrseq_gen->gpiod_reset)
> +		gpiod_put(pwrseq_gen->gpiod_reset);
> +err_put_clks:
> +	while (--clk >= 0)
> +		clk_put(pwrseq_gen->clks[clk]);
> +	return ret;
> +}
> +
> +static int pwrseq_generic_alloc_instance(void)
> +{
> +	struct pwrseq_generic *pwrseq_gen;
> +
> +	pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> +	if (!pwrseq_gen)
> +		return -ENOMEM;
> +
> +	pwrseq_gen->pwrseq.pwrseq_of_match_table = generic_id_table;
> +	pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> +	pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> +	pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> +	pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> +
> +	pwrseq_register(&pwrseq_gen->pwrseq);
> +	return 0;
> +}
> +
> +static int __init pwrseq_generic_register(void)
> +{
> +	return pwrseq_generic_alloc_instance();
> +}
> +postcore_initcall(pwrseq_generic_register)
> diff --git a/include/linux/power/pwrseq.h b/include/linux/power/pwrseq.h
> new file mode 100644
> index 0000000..598301a
> --- /dev/null
> +++ b/include/linux/power/pwrseq.h
> @@ -0,0 +1,60 @@
> +#ifndef __LINUX_PWRSEQ_H
> +#define __LINUX_PWRSEQ_H
> +
> +#include <linux/of.h>
> +
> +#define PWRSEQ_MAX_CLKS		3
> +
> +/**
> + * struct pwrseq - the power sequence structure
> + * @pwrseq_of_match_table: the OF device id table this pwrseq library supports
> + * @node: the list pointer to be added to pwrseq list
> + * @get: the API is used to get pwrseq instance from the device node
> + * @on: do power on for this pwrseq instance
> + * @off: do power off for this pwrseq instance
> + * @put: release the resources on this pwrseq instance
> + * @suspend: do suspend operation on this pwrseq instance
> + * @resume: do resume operation on this pwrseq instance
> + * @used: this pwrseq instance is used by device
> + */
> +struct pwrseq {
> +	const struct of_device_id *pwrseq_of_match_table;
> +	struct list_head node;
> +	int (*get)(struct device_node *np, struct pwrseq *p);
> +	int (*on)(struct pwrseq *p);
> +	void (*off)(struct pwrseq *p);
> +	void (*put)(struct pwrseq *p);
> +	int (*suspend)(struct pwrseq *p);
> +	int (*resume)(struct pwrseq *p);
> +	bool used;
> +};
> +
> +/* used for power sequence instance list in one driver */
> +struct pwrseq_list_per_dev {
> +	struct pwrseq *pwrseq;
> +	struct list_head list;
> +};
> +
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCE)
> +void pwrseq_register(struct pwrseq *pwrseq);
> +void pwrseq_unregister(struct pwrseq *pwrseq);
> +struct pwrseq *of_pwrseq_on(struct device_node *np);
> +void of_pwrseq_off(struct pwrseq *pwrseq);
> +int of_pwrseq_on_list(struct device_node *np, struct list_head *head);
> +void of_pwrseq_off_list(struct list_head *head);
> +#else
> +static inline void pwrseq_register(struct pwrseq *pwrseq) {}
> +static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
> +static inline struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +	return NULL;
> +}
> +void of_pwrseq_off(struct pwrseq *pwrseq) {}
> +int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
> +{
> +	return 0;
> +}
> +void of_pwrseq_off_list(struct list_head *head) {}
> +#endif /* CONFIG_POWER_SEQUENCE */
> +
> +#endif  /* __LINUX_PWRSEQ_H */
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
