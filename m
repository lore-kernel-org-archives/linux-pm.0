From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 2/8] power: add power sequence library
Date: Mon, 22 Aug 2016 14:51:58 +0800
Message-ID: <20160822065158.GB4362@shlinux2>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <1471252398-957-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471252398-957-3-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org
Cc: ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, stern@rowland.harvard.edu, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 15, 2016 at 05:13:12PM +0800, Peter Chen wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
> 
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices.
> 
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover regulator and pinctrl
> in future. The host driver calls pwrseq_alloc_generic to create
> an generic pwrseq instance.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Hi Greg, Sebastian, Dmitry, and David

I find the code under drivers/power have several subsystems.
Does this power sequence patch set can go git://git.infradead.org/battery-2.6.git?
Or can go the Greg's tree?

Peter

> ---
>  MAINTAINERS                           |   9 ++
>  drivers/power/Kconfig                 |   1 +
>  drivers/power/Makefile                |   1 +
>  drivers/power/pwrseq/Kconfig          |  20 ++++
>  drivers/power/pwrseq/Makefile         |   2 +
>  drivers/power/pwrseq/core.c           |  62 +++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c | 168 ++++++++++++++++++++++++++++++++++
>  include/linux/power/pwrseq.h          |  47 ++++++++++
>  8 files changed, 310 insertions(+)
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ae6c84..407254b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9283,6 +9283,15 @@ F:	include/linux/pm_*
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
>  M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index acd4a15..f6aa4fd 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -515,3 +515,4 @@ endif # POWER_SUPPLY
>  
>  source "drivers/power/reset/Kconfig"
>  source "drivers/power/avs/Kconfig"
> +source "drivers/power/pwrseq/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index e46b75d..4ed2e12 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -74,3 +74,4 @@ obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
>  obj-$(CONFIG_POWER_RESET)	+= reset/
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
> +obj-$(CONFIG_POWER_SEQUENCE)	+= pwrseq/
> diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
> new file mode 100644
> index 0000000..188729e
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Power Sequence library
> +#
> +
> +config POWER_SEQUENCE
> +	bool
> +
> +menu "Power Sequence Support"
> +
> +config PWRSEQ_GENERIC
> +	bool "Generic power sequence control"
> +	depends on OF
> +	select POWER_SEQUENCE
> +	help
> +	  It is used for drivers which needs to do power sequence
> +	  (eg, turn on clock, toggle reset gpio) before the related
> +	  devices can be found by hardware. This generic one can be
> +	  used for common power sequence control.
> +
> +endmenu
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
> index 0000000..dcf96c4
> --- /dev/null
> +++ b/drivers/power/pwrseq/core.c
> @@ -0,0 +1,62 @@
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
> +#include <linux/power/pwrseq.h>
> +
> +static DEFINE_MUTEX(pwrseq_list_mutex);
> +static LIST_HEAD(pwrseq_list);
> +
> +int pwrseq_get(struct device_node *np, struct pwrseq *p)
> +{
> +	if (p && p->get)
> +		return p->get(np, p);
> +
> +	return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL(pwrseq_get);
> +
> +int pwrseq_on(struct device_node *np, struct pwrseq *p)
> +{
> +	if (p && p->on)
> +		return p->on(np, p);
> +
> +	return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL(pwrseq_on);
> +
> +void pwrseq_off(struct pwrseq *p)
> +{
> +	if (p && p->off)
> +		p->off(p);
> +}
> +EXPORT_SYMBOL(pwrseq_off);
> +
> +void pwrseq_put(struct pwrseq *p)
> +{
> +	if (p && p->put)
> +		p->put(p);
> +}
> +EXPORT_SYMBOL(pwrseq_put);
> +
> +void pwrseq_free(struct pwrseq *p)
> +{
> +	if (p && p->free)
> +		p->free(p);
> +}
> +EXPORT_SYMBOL(pwrseq_free);
> diff --git a/drivers/power/pwrseq/pwrseq_generic.c b/drivers/power/pwrseq/pwrseq_generic.c
> new file mode 100644
> index 0000000..8af626f
> --- /dev/null
> +++ b/drivers/power/pwrseq/pwrseq_generic.c
> @@ -0,0 +1,168 @@
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
> +};
> +
> +#define to_generic_pwrseq(p) container_of(p, struct pwrseq_generic, pwrseq)
> +
> +static void pwrseq_generic_free(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +
> +	kfree(pwrseq_gen);
> +}
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
> +static int pwrseq_generic_on(struct device_node *np, struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk, ret = 0;
> +	struct gpio_desc *gpiod_reset = pwrseq_gen->gpiod_reset;
> +
> +	for (clk = 0; clk < PWRSEQ_MAX_CLKS && pwrseq_gen->clks[clk]; clk++) {
> +		ret = clk_prepare_enable(pwrseq_gen->clks[clk]);
> +		if (ret) {
> +			pr_err("Can't enable clock on %s: %d\n",
> +				np->full_name, ret);
> +			goto err_disable_clks;
> +		}
> +	}
> +
> +	if (gpiod_reset) {
> +		u32 duration_us = 50;
> +
> +		of_property_read_u32(np, "reset-duration-us",
> +				&duration_us);
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
> +			if (ret == -EPROBE_DEFER)
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
> +	} else {
> +		if (reset_gpio == -ENOENT)
> +			return 0;
> +
> +		ret = reset_gpio;
> +		pr_err("Failed to get reset gpio on %s, err = %d\n",
> +				np->full_name, reset_gpio);
> +		goto err_put_clks;
> +	}
> +
> +	return ret;
> +
> +err_put_clks:
> +	while (--clk >= 0)
> +		clk_put(pwrseq_gen->clks[clk]);
> +	return ret;
> +}
> +
> +struct pwrseq *pwrseq_alloc_generic(void)
> +{
> +	struct pwrseq_generic *pwrseq_gen;
> +
> +	pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> +	if (!pwrseq_gen)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> +	pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> +	pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> +	pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> +	pwrseq_gen->pwrseq.free = pwrseq_generic_free;
> +
> +	return &pwrseq_gen->pwrseq;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_alloc_generic);
> diff --git a/include/linux/power/pwrseq.h b/include/linux/power/pwrseq.h
> new file mode 100644
> index 0000000..ebb2280
> --- /dev/null
> +++ b/include/linux/power/pwrseq.h
> @@ -0,0 +1,47 @@
> +#ifndef __LINUX_PWRSEQ_H
> +#define __LINUX_PWRSEQ_H
> +
> +#include <linux/of.h>
> +
> +#define PWRSEQ_MAX_CLKS		3
> +
> +struct pwrseq {
> +	char *name;
> +	struct list_head node;
> +	int (*get)(struct device_node *np, struct pwrseq *p);
> +	int (*on)(struct device_node *np, struct pwrseq *p);
> +	void (*off)(struct pwrseq *p);
> +	void (*put)(struct pwrseq *p);
> +	void (*free)(struct pwrseq *p);
> +};
> +
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCE)
> +int pwrseq_get(struct device_node *np, struct pwrseq *p);
> +int pwrseq_on(struct device_node *np, struct pwrseq *p);
> +void pwrseq_off(struct pwrseq *p);
> +void pwrseq_put(struct pwrseq *p);
> +void pwrseq_free(struct pwrseq *p);
> +#else
> +static inline int pwrseq_get(struct device_node *np, struct pwrseq *p)
> +{
> +	return 0;
> +}
> +static inline int pwrseq_on(struct device_node *np, struct pwrseq *p)
> +{
> +	return 0;
> +}
> +static inline void pwrseq_off(struct pwrseq *p) {}
> +static inline void pwrseq_put(struct pwrseq *p) {}
> +static inline void pwrseq_free(struct pwrseq *p) {}
> +#endif /* CONFIG_POWER_SEQUENCE */
> +
> +#if IS_ENABLED(CONFIG_PWRSEQ_GENERIC)
> +struct pwrseq *pwrseq_alloc_generic(void);
> +#else
> +static inline struct pwrseq *pwrseq_alloc_generic(void)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_PWRSEQ_GENERIC */
> +
> +#endif  /* __LINUX_PWRSEQ_H */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
