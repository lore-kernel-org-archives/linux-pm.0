From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Wed, 05 Jul 2017 02:44:56 +0200
Message-ID: <1868803.ffQpiaMTN5@aspire.rjw.lan>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com> <1498027328-25078-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63740 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1752241AbdGEAwd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 20:52:33 -0400
In-Reply-To: <1498027328-25078-3-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org, frank.li@nxp.com, jun.li@nxp.com

On Wednesday, June 21, 2017 02:42:03 PM Peter Chen wrote:
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
> For new power sequence library, it needs to add its compatible string
> and allocation function at pwrseq_match_table_list, then the pwrseq
> core will match it with DT's, and choose this library at runtime.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

The executive summary here is that I'm not going to apply this patch (and the
following series depending on it), because in my opinion it is misguided and
I quite fundamentally disagree with the basic concept.

The code has problems too, but we first need to agree on the basics.

> ---
>  Documentation/power/power-sequence/design.rst |  54 +++++
>  MAINTAINERS                                   |   9 +
>  drivers/power/Kconfig                         |   1 +
>  drivers/power/Makefile                        |   1 +
>  drivers/power/pwrseq/Kconfig                  |  20 ++
>  drivers/power/pwrseq/Makefile                 |   2 +
>  drivers/power/pwrseq/core.c                   | 293 ++++++++++++++++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c         | 210 ++++++++++++++++++
>  include/linux/power/pwrseq.h                  |  84 ++++++++
>  9 files changed, 674 insertions(+)
>  create mode 100644 Documentation/power/power-sequence/design.rst
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
> 
> diff --git a/Documentation/power/power-sequence/design.rst b/Documentation/power/power-sequence/design.rst
> new file mode 100644
> index 0000000..554608e
> --- /dev/null
> +++ b/Documentation/power/power-sequence/design.rst
> @@ -0,0 +1,54 @@
> +====================================
> +Power Sequence Library
> +====================================
> +
> +:Date: Feb, 2017
> +:Author: Peter Chen <peter.chen@nxp.com>
> +
> +
> +Introduction
> +============
> +
> +We have an well-known problem that the device needs to do a power
> +sequence before it can be recognized by related host, the typical
> +examples are hard-wired mmc devices and usb devices. The host controller
> +can't know what kinds of this device is in its bus if the power
> +sequence has not done, since the related devices driver's probe calling
> +is determined by runtime according to eunumeration results. Besides,
> +the devices may have custom power sequence, so the power sequence library
> +which is independent with the devices is needed.

In other words, devices can be in different power states and there are power
states in which they are not accessible to software.  In order to be accessed
by software, they need to be put into power states in which that is actually
possible.

That has been known for over 20 years and by no means it is limited to MMC
or USB.

Moreover, power states of devices generally depend on the platform and if
the same IP block is used in two different platforms (or even in two different
SoCs for that matter), the power states of it can be defined differently in
each case.

It also is quite well known how to define a power state of a device.  There
usually is a list of power resources (clocks, regulators, etc) that have to
be "on" for the device to be in the given power state.  In addition to that,
it may be necessary to carry out some operations after turning those
power resources "on" in order to trigger the power state change (like
toggling a GPIO or writing to a specific register etc).

Now, of course, it is not generally guaranteed that devices will be in
software-accessible power states initially, so it is necessary to put them
into those power states before trying to access them.

Again, this isn't anything new, but it has always been about power states.

By defining a "power sequence" you generally define two power states for
the device, say "on" and "off", and a way to switch between them, but what
about simply treating power states as the primary concept in the first place?

That would be more general, because there are platforms with more than
two power states per device.  In those cases, the power state choice may
depend on additional factors, like say during system suspend it may matter
whether or not the device is a wakeup one (and it may not be able to
generate wakeup signals from certain power states).  Using a single "power
sequence" would not be sufficient then.

> +
> +Design
> +============
> +
> +The power sequence library includes the core file and customer power
> +sequence library. The core file exports interfaces are called by
> +host controller driver for power sequence and customer power sequence
> +library files to register its power sequence instance to global
> +power sequence list. The custom power sequence library creates power
> +sequence instance and implement custom power sequence.

The above paragraph is really hard to decode.

There is no explanation of basic concepts at all.  What exactly do you mean by
"power sequence"?  What is a "power sequence instance"?  What do you mean
by "custom power sequence"?

> +
> +Since the power sequence describes hardware design, the description is
> +located at board description file, eg, device tree dts file. And
> +a specific power sequence belongs to device, so its description
> +is under the device node, please refer to:
> +Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt

This, again, is really difficult to understand, especially the difference between
"the power sequence" and "a specific power sequence" is quite unclear.

> +
> +Custom power sequence library allocates one power sequence instance at
> +bootup periods using postcore_initcall, this static allocated instance is
> +used to compare with device-tree (DT) node to see if this library can be
> +used for the node or not.

Same here.

> When the result is matched, the core API will
> +try to get resourses (->get, implemented at each library) for power
> +sequence, if all resources are got, it will try to allocate another
> +instance for next possible request from host driver.
> +
> +Then, the host controller driver can carry out power sequence on for this
> +DT node, the library will do corresponding operations, like open clocks,
> +toggle gpio, etc. The power sequence off routine will close and free the
> +resources, and is called when the parent is removed. And the power
> +sequence suspend and resume routine can be called at host driver's
> +suspend and resume routine if needed.

Let me try to say what I understood from this.

If there is a DT node with a matching "compatible" string, the initialization
code will try to acquire resources needed for "power sequencing" of the
corresponding device.  It is expected that host controller drivers will
then use the provided helper functions to turn the subordinate devices
"on" during enumeration and "off" on the (host controller) driver removal.
They also are expected to use the "suspend" and "resume" helpers when
the host controller is suspended or resumed, respectively.

If the above is what you intended, then it is not the right model IMO.

In particular, I don't see why the controller driver suspend and resume
should operate "power sequences" of subordinate devices directly as the
subordinate devices are expected to be suspended (in which case they
also should have been turned "off" already) when the controller is
suspending and the controller resume need not affect the subordinate
devices at all.

Moreover, it assumes that all of the platforms including the IP block driven
by the controller driver in question will use the "power sequences" model,
but what if there are more generally defined power domains on them?

It looks like the power management should really be carried out by an
additional layer of code to avoid imposing platform dependencies on
controller drivers.

Further, what if there are "power sequences" for the host controllers
themselves?  Who's expected to operate those "power sequences" then?

> +
> +The exported interfaces
> +.. kernel-doc:: drivers/power/pwrseq/core.c
> +   :export:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7d568b..93b07aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10188,6 +10188,15 @@ F:	include/linux/pm_*
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
> +F:	include/linux/power/pwrseq.h
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
> index 0000000..c6b3569
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Power Sequence library
> +#
> +
> +menuconfig POWER_SEQUENCE
> +	bool "Power sequence control"
> +	help
> +	   It is used for drivers which needs to do power sequence
> +	   (eg, turn on clock, toggle reset gpio) before the related
> +	   devices can be found by hardware, eg, USB bus.

So the majority of people trying to configure their kernels will have no idea
whether or not they should enable this option.

Ideally, it should be clear from the description when the option is needed
or it should just be selected automatically by configurations in which it may
be necessary in principle.

> +
> +if POWER_SEQUENCE
> +
> +config PWRSEQ_GENERIC
> +	bool "Generic power sequence control"
> +	depends on OF
> +	help
> +	   This is the generic power sequence control library, and is
> +	   supposed to support common power sequence usage.

This is total fluff.  Either change the description to be more specific, so
anyone can understand it, or just don't add the config option at all.

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
> index 0000000..6b78a66
> --- /dev/null
> +++ b/drivers/power/pwrseq/core.c
> @@ -0,0 +1,293 @@
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
> + * along with this program.
> + */
> +
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/power/pwrseq.h>
> +
> +/*
> + * Static power sequence match table
> + * - Add compatible (the same with dts node) and related allocation function.
> + * - Update related binding doc.
> + */
> +static const struct of_device_id pwrseq_match_table_list[] = {
> +	{ .compatible = "usb424,2513", .data = &pwrseq_generic_alloc_instance},
> +	{ .compatible = "usb424,2514", .data = &pwrseq_generic_alloc_instance},
> +	{ /* sentinel */ }
> +};

So what exactly is the purpose of this?

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
> +/**
> + * of_pwrseq_on - Carry out power sequence on for device node
> + *
> + * @np: the device node would like to power on
> + *
> + * Carry out a single device power on.  If multiple devices
> + * need to be handled, use of_pwrseq_on_list() instead.
> + *
> + * Return a pointer to the power sequence instance on success, or NULL if
> + * not exist, or an error code on failure.
> + */

So I guess, because that hasn't been clearly stated anywhere, that host
controller drivers are expected to call this routine in order to turn the
subordinate devices "on" before probing them in case they need to be
"power sequenced".

> +struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +	struct pwrseq *pwrseq;
> +	int ret;
> +	const struct of_device_id *of_id;
> +	struct pwrseq *(*alloc_instance)(void);
> +
> +	of_id  = of_match_node(pwrseq_match_table_list, np);
> +	if (!of_id)
> +		return NULL;
> +
> +	alloc_instance = of_id->data;
> +	/* Allocate pwrseq instance */
> +	pwrseq = alloc_instance();
> +	if (IS_ERR(pwrseq))
> +		return pwrseq;
> +
> +	ret = pwrseq_get(np, pwrseq);
> +	if (ret)
> +		goto pwr_put;
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
> + * of_pwrseq_off - Carry out power sequence off for this pwrseq instance
> + *
> + * @pwrseq: the pwrseq instance which related device would like to be off
> + *
> + * This API is used to power off single device, it is the opposite
> + * operation for of_pwrseq_on.
> + */
> +void of_pwrseq_off(struct pwrseq *pwrseq)
> +{
> +	pwrseq_off(pwrseq);
> +	pwrseq_put(pwrseq);
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_off);
> +
> +/**
> + * of_pwrseq_on_list - Carry out power sequence on for list
> + *
> + * @np: the device node would like to power on
> + * @head: the list head for pwrseq list on this bus
> + *
> + * This API is used to power on multiple devices at single bus.
> + * If there are several devices on bus (eg, USB bus), uses this
> + * this API. Otherwise, use of_pwrseq_on instead. After the device
> + * is powered on successfully, it will be added to pwrseq list for
> + * this bus. The caller needs to use mutex_lock for concurrent.
> + *
> + * Return 0 on success, or -ENOENT if not exist, or an error value on failure.
> + */

Here the caller seems to be expected to allocate a list_head upfront and then
pass it to every invocation of this routine in order to create a list of devices
that have been turned "on".

Also, this is expected to be called by controller drivers for the subordinate
devices on the bus before probing those devices and the callers are
responsible for mutual exclusion.

> +int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
> +{
> +	struct pwrseq *pwrseq;
> +	struct pwrseq_list_per_dev *pwrseq_list_node;
> +
> +	pwrseq_list_node = kzalloc(sizeof(*pwrseq_list_node), GFP_KERNEL);
> +	if (!pwrseq_list_node)
> +		return -ENOMEM;
> +
> +	pwrseq = of_pwrseq_on(np);
> +	if (!pwrseq)
> +		return -ENOENT;
> +
> +	if (IS_ERR(pwrseq)) {
> +		kfree(pwrseq_list_node);
> +		return PTR_ERR(pwrseq);
> +	}
> +
> +	pwrseq_list_node->pwrseq = pwrseq;
> +	list_add(&pwrseq_list_node->list, head);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_on_list);
> +
> +/**
> + * of_pwrseq_off_list - Carry out power sequence off for the list
> + *
> + * @head: the list head for pwrseq instance list on this bus
> + *
> + * This API is used to power off all devices on this bus, it is
> + * the opposite operation for of_pwrseq_on_list.
> + * The caller needs to use mutex_lock for concurrent.
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
> +
> +/**
> + * pwrseq_suspend - Carry out power sequence suspend for this pwrseq instance
> + *
> + * @pwrseq: the pwrseq instance
> + *
> + * This API is used to do suspend operation on pwrseq instance.
> + *
> + * Return 0 on success, or an error value otherwise.
> + */
> +int pwrseq_suspend(struct pwrseq *p)
> +{
> +	int ret = 0;
> +
> +	if (p && p->suspend)
> +		ret = p->suspend(p);
> +	else
> +		return ret;
> +
> +	if (!ret)
> +		p->suspended = true;
> +	else
> +		pr_err("%s failed\n", __func__);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_suspend);
> +
> +/**
> + * pwrseq_resume - Carry out power sequence resume for this pwrseq instance
> + *
> + * @pwrseq: the pwrseq instance
> + *
> + * This API is used to do resume operation on pwrseq instance.
> + *
> + * Return 0 on success, or an error value otherwise.
> + */
> +int pwrseq_resume(struct pwrseq *p)
> +{
> +	int ret = 0;
> +
> +	if (p && p->resume)
> +		ret = p->resume(p);
> +	else
> +		return ret;
> +
> +	if (!ret)
> +		p->suspended = false;
> +	else
> +		pr_err("%s failed\n", __func__);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_resume);
> +
> +/**
> + * pwrseq_suspend_list - Carry out power sequence suspend for list
> + *
> + * @head: the list head for pwrseq instance list on this bus
> + *
> + * This API is used to do suspend on all power sequence instances on this bus.
> + * The caller needs to use mutex_lock for concurrent.
> + */

This appears to be totally misguided.

If my understanding of the idea is correct, this is supposed to operate
on subordinate devices below a controller whose driver is expected to
call it.  However, all of those devices should be suspended already at
this point and they should be "off" now.

You basically artificially create a power domain here without any particular
need for that.

> +int pwrseq_suspend_list(struct list_head *head)
> +{
> +	struct pwrseq *pwrseq;
> +	struct pwrseq_list_per_dev *pwrseq_list_node;
> +	int ret = 0;
> +
> +	list_for_each_entry(pwrseq_list_node, head, list) {
> +		ret = pwrseq_suspend(pwrseq_list_node->pwrseq);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		list_for_each_entry(pwrseq_list_node, head, list) {
> +			pwrseq = pwrseq_list_node->pwrseq;
> +			if (pwrseq->suspended)
> +				pwrseq_resume(pwrseq);
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_suspend_list);
> +
> +/**
> + * pwrseq_resume_list - Carry out power sequence resume for the list
> + *
> + * @head: the list head for pwrseq instance list on this bus
> + *
> + * This API is used to do resume on all power sequence instances on this bus.
> + * The caller needs to use mutex_lock for concurrent.
> + */
> +int pwrseq_resume_list(struct list_head *head)
> +{
> +	struct pwrseq_list_per_dev *pwrseq_list_node;
> +	int ret = 0;
> +
> +	list_for_each_entry(pwrseq_list_node, head, list) {
> +		ret = pwrseq_resume(pwrseq_list_node->pwrseq);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_resume_list);
> diff --git a/drivers/power/pwrseq/pwrseq_generic.c b/drivers/power/pwrseq/pwrseq_generic.c
> new file mode 100644
> index 0000000..b7bbd6c5
> --- /dev/null
> +++ b/drivers/power/pwrseq/pwrseq_generic.c
> @@ -0,0 +1,210 @@
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
> + * along with this program.
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

No description.

> +struct pwrseq_generic {
> +	struct pwrseq pwrseq;
> +	struct gpio_desc *gpiod_reset;
> +	struct clk *clks[PWRSEQ_MAX_CLKS];
> +	u32 duration_us;
> +	bool suspended;
> +};
> +
> +#define to_generic_pwrseq(p) container_of(p, struct pwrseq_generic, pwrseq)
> +
> +static int pwrseq_generic_suspend(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk;
> +
> +	for (clk = PWRSEQ_MAX_CLKS - 1; clk >= 0; clk--)
> +		clk_disable_unprepare(pwrseq_gen->clks[clk]);
> +
> +	pwrseq_gen->suspended = true;
> +	return 0;
> +}

So what exactly is the difference between "suspend" and "off" here?

> +
> +static int pwrseq_generic_resume(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk, ret = 0;
> +
> +	for (clk = 0; clk < PWRSEQ_MAX_CLKS && pwrseq_gen->clks[clk]; clk++) {
> +		ret = clk_prepare_enable(pwrseq_gen->clks[clk]);
> +		if (ret) {
> +			pr_err("Can't enable clock, ret=%d\n", ret);
> +			goto err_disable_clks;
> +		}
> +	}
> +
> +	pwrseq_gen->suspended = false;
> +	return ret;
> +
> +err_disable_clks:
> +	while (--clk >= 0)
> +		clk_disable_unprepare(pwrseq_gen->clks[clk]);
> +
> +	return ret;
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
> +
> +	kfree(pwrseq_gen);
> +}
> +
> +static void pwrseq_generic_off(struct pwrseq *pwrseq)
> +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	int clk;
> +
> +	if (pwrseq_gen->suspended)
> +		return;
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
> +	return 0;
> +
> +err_put_clks:
> +	while (--clk >= 0)
> +		clk_put(pwrseq_gen->clks[clk]);
> +	return ret;
> +}
> +

No comments whatever in this file above this point.

> +/**
> + * pwrseq_generic_alloc_instance - power sequence instance allocation
> + *
> + * This function is used to allocate one generic power sequence instance,
> + * it is called when the system boots up and after one power sequence
> + * instance is got successfully.

Who is responsible for calling it?

> + *
> + * Return zero on success or an error code otherwise.
> + */
> +struct pwrseq *pwrseq_generic_alloc_instance(void)
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
> +	pwrseq_gen->pwrseq.suspend = pwrseq_generic_suspend;
> +	pwrseq_gen->pwrseq.resume = pwrseq_generic_resume;

What about ->pwrseq_of_match_table?

> +
> +	return &pwrseq_gen->pwrseq;
> +}
> diff --git a/include/linux/power/pwrseq.h b/include/linux/power/pwrseq.h
> new file mode 100644
> index 0000000..c5b278f
> --- /dev/null
> +++ b/include/linux/power/pwrseq.h
> @@ -0,0 +1,84 @@
> +#ifndef __LINUX_PWRSEQ_H
> +#define __LINUX_PWRSEQ_H
> +
> +#include <linux/of.h>
> +
> +#define PWRSEQ_MAX_CLKS		3

Why is the number 3?

Some description of how the stuff below is supposed to be used would be useful
here.

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
> +	bool suspended;
> +};
> +
> +/* used for power sequence instance list in one driver */
> +struct pwrseq_list_per_dev {
> +	struct pwrseq *pwrseq;
> +	struct list_head list;
> +};
> +
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCE)
> +struct pwrseq *of_pwrseq_on(struct device_node *np);
> +void of_pwrseq_off(struct pwrseq *pwrseq);
> +int of_pwrseq_on_list(struct device_node *np, struct list_head *head);
> +void of_pwrseq_off_list(struct list_head *head);
> +int pwrseq_suspend(struct pwrseq *p);
> +int pwrseq_resume(struct pwrseq *p);
> +int pwrseq_suspend_list(struct list_head *head);
> +int pwrseq_resume_list(struct list_head *head);
> +#else
> +static inline struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +	return NULL;
> +}
> +static void of_pwrseq_off(struct pwrseq *pwrseq) {}
> +static int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
> +{
> +	return 0;
> +}
> +static void of_pwrseq_off_list(struct list_head *head) {}
> +static int pwrseq_suspend(struct pwrseq *p)
> +{
> +	return 0;
> +}
> +static int pwrseq_resume(struct pwrseq *p)
> +{
> +	return 0;
> +}
> +static int pwrseq_suspend_list(struct list_head *head)
> +{
> +	return 0;
> +}
> +static int pwrseq_resume_list(struct list_head *head)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_POWER_SEQUENCE */
> +
> +#if IS_ENABLED(CONFIG_PWRSEQ_GENERIC)
> +extern struct pwrseq *pwrseq_generic_alloc_instance(void);
> +#else
> +static inline struct pwrseq *pwrseq_generic_alloc_instance(void)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +#endif /* CONFIG_PWRSEQ_GENERIC */
> +
> +#endif  /* __LINUX_PWRSEQ_H */
> 

Overall, no, sorry.

Thanks,
Rafael
