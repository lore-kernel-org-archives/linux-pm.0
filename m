From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Wed, 30 Mar 2016 13:09:00 +0300
Message-ID: <87h9foqnur.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28840 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbcC3KK4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 06:10:56 -0400
In-Reply-To: <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
> This patch introduces the usb charger driver based on usb gadget that
> makes an enhancement to a power driver. It works well in practice but
> that requires a system with suitable hardware.
>
> The basic conception of the usb charger is that, when one usb charger
> is added or removed by reporting from the usb gadget state change or
> the extcon device state change, the usb charger will report to power
> user to set the current limitation.
>
> The usb charger will register notifiees on the usb gadget or the extcon
> device to get notified the usb charger state. It also supplies the
> notification mechanism to userspace When the usb charger state is changed.
>
> Power user will register a notifiee on the usb charger to get notified
> by status changes from the usb charger. It will report to power user
> to set the current limitation when detecting the usb charger is added
> or removed from extcon device state or usb gadget state.
>
> This patch doesn't yet integrate with the gadget code, so some functions
> which rely on the 'gadget' are not completed, that will be implemented
> in the following patches.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/usb/gadget/Kconfig      |    7 +
>  drivers/usb/gadget/Makefile     |    1 +
>  drivers/usb/gadget/charger.c    |  669 +++++++++++++++++++++++++++++++++=
++++++

It seems to me this should be part of udc-core's functionality. Maybe
move this to drivers/usb/gadget/udc and statically link it to
udc-core.ko ?

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index af5d922..82a5b3c 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -133,6 +133,13 @@ config U_SERIAL_CONSOLE
>  	help
>  	   It supports the serial gadget can be used as a console.
>=20=20
> +config USB_CHARGER
> +	bool "USB charger support"
> +	help
> +	  The usb charger driver based on the usb gadget that makes an
> +	  enhancement to a power driver which can set the current limitation
> +	  when the usb charger is added or removed.

sure you don't depend on anything ?

> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index 598a67d..1e421c1 100644
> --- a/drivers/usb/gadget/Makefile
> +++ b/drivers/usb/gadget/Makefile
> @@ -10,3 +10,4 @@ libcomposite-y			:=3D usbstring.o config.o epautoconf.o
>  libcomposite-y			+=3D composite.o functions.o configfs.o u_f.o
>=20=20
>  obj-$(CONFIG_USB_GADGET)	+=3D udc/ function/ legacy/
> +obj-$(CONFIG_USB_CHARGER)	+=3D charger.o
> diff --git a/drivers/usb/gadget/charger.c b/drivers/usb/gadget/charger.c
> new file mode 100644
> index 0000000..82a9973
> --- /dev/null
> +++ b/drivers/usb/gadget/charger.c
> @@ -0,0 +1,669 @@
> +/*
> + * charger.c -- USB charger driver
> + *
> + * Copyright (C) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/extcon.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>

not very nice to depend on either of or platform_device here. What about
PCI-based devices ?

> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/usb_charger.h>
> +#include <linux/power_supply.h>
> +
> +#define DEFAULT_CUR_PROTECT	(50)

Where is this coming from ? Also, () are not necessary.

> +#define DEFAULT_SDP_CUR_LIMIT	(500 - DEFAULT_CUR_PROTECT)

According to the spec we should always be talking about unit loads (1
unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
work for SS capable ports and SS gadgets (we have quite a few of them,
actually). You're missing the opportunity of charging at 900mA.

> +#define DEFAULT_DCP_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
> +#define DEFAULT_CDP_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
> +#define DEFAULT_ACA_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
> +#define UCHGER_STATE_LENGTH	(50)

what is this UCHGER_STATE_LENGTH ? And also, why don't you spell it out?
Is this weird name coming from a spec ? Which spec ?

> +static DEFINE_IDA(usb_charger_ida);
> +static struct bus_type usb_charger_subsys =3D {
> +	.name           =3D "usb-charger",
> +	.dev_name       =3D "usb-charger",
> +};
> +
> +static struct usb_charger *dev_to_uchger(struct device *udev)

nit-picking but I'd rather call this struct device *dev. Also, I'm not
sure this fits as a bus_type. There's no "usb charger" bus. There's USB
bus and its VBUS/GND lines. Why are you using a bus_type here ?

> +{
> +	return container_of(udev, struct usb_charger, dev);
> +}
> +
> +static ssize_t sdp_limit_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +
> +	return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
> +}
> +
> +static ssize_t sdp_limit_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +	unsigned int sdp_limit;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &sdp_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D usb_charger_set_cur_limit_by_type(uchger, SDP_TYPE, sdp_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(sdp_limit);

why RW ? Who's going to use these ? Also, you're not documenting this
new sysfs file.

> +static ssize_t dcp_limit_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +
> +	return sprintf(buf, "%d\n", uchger->cur_limit.dcp_cur_limit);
> +}
> +
> +static ssize_t dcp_limit_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +	unsigned int dcp_limit;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &dcp_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D usb_charger_set_cur_limit_by_type(uchger, DCP_TYPE, dcp_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(dcp_limit);

likewise, why RW ? Missing doc.

> +static ssize_t cdp_limit_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +
> +	return sprintf(buf, "%d\n", uchger->cur_limit.cdp_cur_limit);
> +}
> +
> +static ssize_t cdp_limit_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +	unsigned int cdp_limit;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &cdp_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D usb_charger_set_cur_limit_by_type(uchger, CDP_TYPE, cdp_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(cdp_limit);

why RW? Where's doc ?

> +static ssize_t aca_limit_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +
> +	return sprintf(buf, "%d\n", uchger->cur_limit.aca_cur_limit);
> +}
> +
> +static ssize_t aca_limit_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +	unsigned int aca_limit;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &aca_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D usb_charger_set_cur_limit_by_type(uchger, ACA_TYPE, aca_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(aca_limit);

why RW ? where's doc ?

> +static struct attribute *usb_charger_attrs[] =3D {

const ?

> +	&dev_attr_sdp_limit.attr,
> +	&dev_attr_dcp_limit.attr,
> +	&dev_attr_cdp_limit.attr,
> +	&dev_attr_aca_limit.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(usb_charger);

static ?

> +struct usb_charger *usb_charger_find_by_name(const char *name)
> +{
> +	struct device *udev;
> +
> +	if (!name)
> +		return ERR_PTR(-EINVAL);

quite frankly, this deserves, at a minimum, a big fat WARN():

	if (WARN(!name, "can't work with NULL name"))
		return .....

> +	udev =3D bus_find_device_by_name(&usb_charger_subsys, NULL, name);
> +	if (!udev)
> +		return ERR_PTR(-ENODEV);

still not convinced this deserves to be a bus_type.

> +	return dev_to_uchger(udev);
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_find_by_name);
> +
> +/*
> + * usb_charger_get() - Reference a usb charger.
> + * @uchger - usb charger
> + */
> +struct usb_charger *usb_charger_get(struct usb_charger *uchger)
> +{
> +	return (uchger && get_device(&uchger->dev)) ? uchger : NULL;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_get);
> +
> +/*
> + * usb_charger_put() - Dereference a usb charger.
> + * @uchger - charger to release
> + */
> +void usb_charger_put(struct usb_charger *uchger)
> +{
> +	if (uchger)
> +		put_device(&uchger->dev);
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_put);
> +
> +/*
> + * usb_charger_register_notify() - Register a notifiee to get notified by
> + * any attach status changes from the usb charger detection.
> + * @uchger - the usb charger device which is monitored.
> + * @nb - a notifier block to be registered.
> + */
> +int usb_charger_register_notify(struct usb_charger *uchger,
> +				struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	if (!uchger || !nb)
> +		return -EINVAL;
> +
> +	mutex_lock(&uchger->lock);
> +	ret =3D raw_notifier_chain_register(&uchger->uchger_nh, nb);
> +
> +	/* Generate an initial notify so users start in the right state */
> +	if (!ret) {
> +		usb_charger_detect_type(uchger);
> +		raw_notifier_call_chain(&uchger->uchger_nh,
> +					usb_charger_get_cur_limit(uchger),
> +					uchger);
> +	}
> +	mutex_unlock(&uchger->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_register_notify);
> +
> +/*
> + * usb_charger_unregister_notify() - Unregister a notifiee from the usb =
charger.
> + * @uchger - the usb charger device which is monitored.
> + * @nb - a notifier block to be unregistered.
> + */
> +int usb_charger_unregister_notify(struct usb_charger *uchger,
> +				  struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	if (!uchger || !nb)

WARN() ?

> +		return -EINVAL;
> +
> +	mutex_lock(&uchger->lock);
> +	ret =3D raw_notifier_chain_unregister(&uchger->uchger_nh, nb);
> +	mutex_unlock(&uchger->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_unregister_notify);
> +
> +/*
> + * usb_charger_detect_type() - Get the usb charger type by the callback
> + * which is implemented by gadget operations.
> + * @uchger - the usb charger device.
> + *
> + * return the usb charger type.
> + */
> +enum usb_charger_type
> +usb_charger_detect_type(struct usb_charger *uchger)
> +{
> +	if (uchger->psy) {
> +		union power_supply_propval val;
> +
> +		power_supply_get_property(uchger->psy,
> +					  POWER_SUPPLY_PROP_CHARGE_TYPE,
> +					  &val);
> +		switch (val.intval) {
> +		case POWER_SUPPLY_TYPE_USB:
> +			uchger->type =3D SDP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_DCP:
> +			uchger->type =3D DCP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_CDP:
> +			uchger->type =3D CDP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_ACA:
> +			uchger->type =3D ACA_TYPE;
> +			break;
> +		default:
> +			uchger->type =3D UNKNOWN_TYPE;
> +			break;
> +		}
> +	} else if (uchger->get_charger_type) {
> +		uchger->type =3D uchger->get_charger_type(uchger);
> +	} else {
> +		uchger->type =3D UNKNOWN_TYPE;
> +	}
> +
> +	return uchger->type;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_detect_type);
> +
> +/*
> + * usb_charger_set_cur_limit_by_type() - Set the current limitation
> + * by charger type.
> + * @uchger - the usb charger device.
> + * @type - the usb charger type.
> + * @cur_limit - the current limitation.
> + */
> +int usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
> +				      enum usb_charger_type type,
> +				      unsigned int cur_limit)
> +{
> +	if (!uchger)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case SDP_TYPE:
> +		uchger->cur_limit.sdp_cur_limit =3D cur_limit;
> +		break;
> +	case DCP_TYPE:
> +		uchger->cur_limit.dcp_cur_limit =3D cur_limit;
> +		break;
> +	case CDP_TYPE:
> +		uchger->cur_limit.cdp_cur_limit	=3D cur_limit;
> +		break;
> +	case ACA_TYPE:
> +		uchger->cur_limit.aca_cur_limit	=3D cur_limit;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_type);
> +
> +/*
> + * usb_charger_set_cur_limit() - Set the current limitation.
> + * @uchger - the usb charger device.
> + * @cur_limit_set - the current limitation.
> + */
> +int usb_charger_set_cur_limit(struct usb_charger *uchger,
> +			      struct usb_charger_cur_limit *cur_limit_set)
> +{
> +	if (!uchger || !cur_limit_set)
> +		return -EINVAL;
> +
> +	uchger->cur_limit.sdp_cur_limit =3D cur_limit_set->sdp_cur_limit;
> +	uchger->cur_limit.dcp_cur_limit =3D cur_limit_set->dcp_cur_limit;
> +	uchger->cur_limit.cdp_cur_limit =3D cur_limit_set->cdp_cur_limit;
> +	uchger->cur_limit.aca_cur_limit =3D cur_limit_set->aca_cur_limit;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit);
> +
> +/*
> + * usb_charger_get_cur_limit() - Get the current limitation by
> + * different usb charger type.
> + * @uchger - the usb charger device.
> + *
> + * return the current limitation to set.
> + */
> +unsigned int
> +usb_charger_get_cur_limit(struct usb_charger *uchger)
> +{
> +	enum usb_charger_type uchger_type =3D usb_charger_detect_type(uchger);
> +	unsigned int cur_limit;
> +
> +	switch (uchger_type) {
> +	case SDP_TYPE:
> +		cur_limit =3D uchger->cur_limit.sdp_cur_limit;
> +		break;
> +	case DCP_TYPE:
> +		cur_limit =3D uchger->cur_limit.dcp_cur_limit;
> +		break;
> +	case CDP_TYPE:
> +		cur_limit =3D uchger->cur_limit.cdp_cur_limit;
> +		break;
> +	case ACA_TYPE:
> +		cur_limit =3D uchger->cur_limit.aca_cur_limit;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return cur_limit;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_get_cur_limit);
> +
> +/*
> + * usb_charger_notifier_others() - It will notify other device registered
> + * on usb charger when the usb charger state is changed.
> + * @uchger - the usb charger device.
> + * @state - the state of the usb charger.
> + */
> +static void
> +usb_charger_notify_others(struct usb_charger *uchger,
> +			  enum usb_charger_state state)
> +{
> +	char uchger_state[UCHGER_STATE_LENGTH];
> +	char *envp[] =3D { uchger_state, NULL };
> +
> +	mutex_lock(&uchger->lock);
> +	uchger->state =3D state;
> +
> +	switch (state) {
> +	case USB_CHARGER_PRESENT:
> +		usb_charger_detect_type(uchger);
> +		raw_notifier_call_chain(&uchger->uchger_nh,
> +			usb_charger_get_cur_limit(uchger),
> +			uchger);
> +		snprintf(uchger_state, UCHGER_STATE_LENGTH,
> +			 "USB_CHARGER_STATE=3D%s", "USB_CHARGER_PRESENT");
> +		break;
> +	case USB_CHARGER_REMOVE:
> +		uchger->type =3D UNKNOWN_TYPE;
> +		raw_notifier_call_chain(&uchger->uchger_nh, 0, uchger);
> +		snprintf(uchger_state, UCHGER_STATE_LENGTH,
> +			 "USB_CHARGER_STATE=3D%s", "USB_CHARGER_REMOVE");
> +		break;
> +	default:
> +		dev_warn(&uchger->dev, "Unknown USB charger state: %d\n",
> +			 state);
> +		mutex_unlock(&uchger->lock);
> +		return;
> +	}
> +
> +	kobject_uevent_env(&uchger->dev.kobj, KOBJ_CHANGE, envp);
> +	mutex_unlock(&uchger->lock);
> +}
> +
> +/*
> + * usb_charger_plug_by_extcon() - The notifier call function which is re=
gistered
> + * on the extcon device.
> + * @nb - the notifier block that notified by extcon device.
> + * @state - the extcon device state.
> + * @data - here specify a extcon device.
> + *
> + * return the notify flag.
> + */
> +static int
> +usb_charger_plug_by_extcon(struct notifier_block *nb,
> +			   unsigned long state, void *data)
> +{
> +	struct usb_charger_nb *extcon_nb =3D
> +		container_of(nb, struct usb_charger_nb, nb);
> +	struct usb_charger *uchger =3D extcon_nb->uchger;
> +	enum usb_charger_state uchger_state;
> +
> +	if (!uchger)
> +		return NOTIFY_BAD;
> +
> +	/* Report event to power to setting the current limitation
> +	 * for this usb charger when one usb charger is added or removed
> +	 * with detecting by extcon device.
> +	 */
> +	if (state)
> +		uchger_state =3D USB_CHARGER_PRESENT;
> +	else
> +		uchger_state =3D USB_CHARGER_REMOVE;
> +
> +	usb_charger_notify_others(uchger, uchger_state);
> +
> +	return NOTIFY_OK;
> +}
> +
> +/*
> + * usb_charger_plug_by_gadget() - Set the usb charger current limitation
> + * according to the usb gadget device state.
> + * @gadget - the usb gadget device.
> + * @state - the usb gadget state.
> + */
> +int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
> +			       unsigned long state)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_plug_by_gadget);
> +
> +static int devm_uchger_dev_match(struct device *dev, void *res, void *da=
ta)
> +{
> +	struct usb_charger **r =3D res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r =3D=3D data;
> +}
> +
> +static void usb_charger_release(struct device *dev)
> +{
> +	struct usb_charger *uchger =3D dev_get_drvdata(dev);
> +
> +	kfree(uchger);
> +}
> +
> +/*
> + * usb_charger_unregister() - Unregister a usb charger device.
> + * @uchger - the usb charger to be unregistered.
> + */
> +static int usb_charger_unregister(struct usb_charger *uchger)
> +{
> +	if (!uchger)

WARN()

> +		return -EINVAL;
> +
> +	device_unregister(&uchger->dev);
> +	return 0;
> +}
> +
> +static void devm_uchger_dev_unreg(struct device *dev, void *res)
> +{
> +	usb_charger_unregister(*(struct usb_charger **)res);
> +}
> +
> +void devm_usb_charger_unregister(struct device *dev,
> +				 struct usb_charger *uchger)
> +{
> +	devres_release(dev, devm_uchger_dev_unreg,
> +		       devm_uchger_dev_match, uchger);
> +}

does this need EXPORT_SYMBOL_GPL() too ?

> +/*
> + * usb_charger_register() - Register a new usb charger device
> + * which is created by the usb charger framework.
> + * @parent - the parent device of the new usb charger.
> + * @uchger - the new usb charger device.
> + */
> +static int usb_charger_register(struct device *parent,
> +				struct usb_charger *uchger)
> +{
> +	int ret;
> +
> +	if (!uchger)

WARN()

> +		return -EINVAL;
> +
> +	uchger->dev.parent =3D parent;
> +	uchger->dev.release =3D usb_charger_release;
> +	uchger->dev.bus =3D &usb_charger_subsys;
> +	uchger->dev.groups =3D usb_charger_groups;
> +
> +	ret =3D ida_simple_get(&usb_charger_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto fail_ida;
> +
> +	uchger->id =3D ret;
> +	dev_set_name(&uchger->dev, "usb-charger.%d", uchger->id);
> +	dev_set_drvdata(&uchger->dev, uchger);
> +
> +	ret =3D device_register(&uchger->dev);
> +	if (ret)
> +		goto fail_register;
> +
> +	return 0;
> +
> +fail_register:
> +	put_device(&uchger->dev);
> +	ida_simple_remove(&usb_charger_ida, uchger->id);
> +	uchger->id =3D -1;
> +fail_ida:
> +	dev_err(parent, "Failed to register usb charger: %d\n", ret);
> +	return ret;
> +}
> +
> +int devm_usb_charger_register(struct device *dev,
> +			      struct usb_charger *uchger)
> +{
> +	struct usb_charger **ptr;
> +	int ret;
> +
> +	ptr =3D devres_alloc(devm_uchger_dev_unreg, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret =3D usb_charger_register(dev, uchger);
> +	if (ret) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr =3D uchger;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +
> +int usb_charger_init(struct usb_gadget *ugadget)
> +{
> +	struct usb_charger *uchger;
> +	struct extcon_dev *edev;
> +	struct power_supply *psy;
> +	int ret;
> +
> +	if (!ugadget)

WARN()

but I don't like this. This should be done from udc-core.c itself when
the UDC registers itself.

> +		return -EINVAL;
> +
> +	uchger =3D kzalloc(sizeof(struct usb_charger), GFP_KERNEL);
> +	if (!uchger)
> +		return -ENOMEM;
> +
> +	uchger->type =3D UNKNOWN_TYPE;
> +	uchger->state =3D USB_CHARGER_DEFAULT;
> +	uchger->id =3D -1;
> +	uchger->cur_limit.sdp_cur_limit =3D DEFAULT_SDP_CUR_LIMIT;
> +	uchger->cur_limit.dcp_cur_limit =3D DEFAULT_DCP_CUR_LIMIT;
> +	uchger->cur_limit.cdp_cur_limit =3D DEFAULT_CDP_CUR_LIMIT;
> +	uchger->cur_limit.aca_cur_limit =3D DEFAULT_ACA_CUR_LIMIT;
> +	uchger->get_charger_type =3D NULL;
> +
> +	mutex_init(&uchger->lock);
> +	RAW_INIT_NOTIFIER_HEAD(&uchger->uchger_nh);
> +
> +	/* register a notifier on a extcon device if it is exsited */
> +	edev =3D extcon_get_edev_by_phandle(ugadget->dev.parent, 0);
> +	if (!IS_ERR_OR_NULL(edev)) {
> +		uchger->extcon_dev =3D edev;
> +		uchger->extcon_nb.nb.notifier_call =3D usb_charger_plug_by_extcon;
> +		uchger->extcon_nb.uchger =3D uchger;
> +		extcon_register_notifier(edev, EXTCON_USB,
> +					 &uchger->extcon_nb.nb);
> +	}
> +
> +	/* to check if the usb charger is link to a power supply */
> +	psy =3D devm_power_supply_get_by_phandle(ugadget->dev.parent,
> +					       "power-supplies");
> +	if (!IS_ERR_OR_NULL(psy))
> +		uchger->psy =3D psy;
> +	else
> +		uchger->psy =3D NULL;
> +
> +	/* register a notifier on a usb gadget device */
> +	uchger->gadget =3D ugadget;
> +	uchger->old_gadget_state =3D ugadget->state;
> +
> +	/* register a new usb charger */
> +	ret =3D usb_charger_register(&ugadget->dev, uchger);
> +	if (ret)
> +		goto fail;
> +
> +	return 0;
> +
> +fail:
> +	if (uchger->extcon_dev)
> +		extcon_unregister_notifier(uchger->extcon_dev,
> +					   EXTCON_USB, &uchger->extcon_nb.nb);
> +
> +	kfree(uchger);
> +	return ret;
> +}
> +
> +int usb_charger_exit(struct usb_gadget *ugadget)
> +{
> +	return 0;
> +}
> +
> +static int __init usb_charger_sysfs_init(void)
> +{
> +	return subsys_system_register(&usb_charger_subsys, NULL);
> +}
> +core_initcall(usb_charger_sysfs_init);

please don't. This should be indication that there's something wrong
with your patchset.

> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
> +MODULE_DESCRIPTION("USB charger driver");
> +MODULE_LICENSE("GPL");

GPLv2 or GPLv2+ ??

> diff --git a/include/linux/usb/usb_charger.h b/include/linux/usb/usb_char=
ger.h
> new file mode 100644
> index 0000000..eed422f
> --- /dev/null
> +++ b/include/linux/usb/usb_charger.h

usb_ is redundant. I'd prefer to:

#include <linux/usb/charger.h>

> @@ -0,0 +1,164 @@
> +#ifndef __LINUX_USB_CHARGER_H__
> +#define __LINUX_USB_CHARGER_H__
> +
> +#include <uapi/linux/usb/ch9.h>
> +
> +/* USB charger type:
> + * SDP (Standard Downstream Port)
> + * DCP (Dedicated Charging Port)
> + * CDP (Charging Downstream Port)
> + * ACA (Accessory Charger Adapters)
> + */
> +enum usb_charger_type {
> +	UNKNOWN_TYPE,
> +	SDP_TYPE,
> +	DCP_TYPE,
> +	CDP_TYPE,
> +	ACA_TYPE,
> +};
> +
> +/* USB charger state */
> +enum usb_charger_state {
> +	USB_CHARGER_DEFAULT,
> +	USB_CHARGER_PRESENT,
> +	USB_CHARGER_REMOVE,
> +};

userland really doesn't need these two ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+6W9AAoJEIaOsuA1yqRElDAP+wTz2aGoMME6EhPslc9hytDD
0PmCaB3O4K9N8VOGFo4F1aAkjnMaolZd+nizTLhDHklmM0JRFAMGtIkIiiur00XQ
iofl3xjbUI+ugPsiuOvZaZPCvDWNotKkyjGWzB8jgv1VWJ7xQLXJAOA39CLYdu1r
W9oOjetZvCWvoE/GJYWbiTdI2cnWI50k3ES0C1pDDGcCmwO7H7Yw3EMs+nIzTWG/
bT/YQB15/U3XErLu1gGEkvOfkKIZFgkCjhFw4IpBy5H04YWCbNMFQiXNlAxzODak
wOUVcAfaI6voyTQKbKBJOjr+coHrMAo31OPqkcQ5LDJx+lMuwoXSAO4LRIbomoKY
2uGBVklCzLnh1EhZ5LvmyE+hBlrtGItR46gOUnmMESYFRf7cPkdJrBFVPZpb37hV
9AgIewiD9bClWo64+/Qq2ty8FNXbfFQBBrnjswMKhTic4Zq2LSTjEH/TvQT/Wy6K
mTw8h/fqiPGOh6FqjOOjV2t5Qadu76W2JzKEh7jAcNkjivGhEGeDLGccr4cKnkid
k84c5EMzhg/OmTewG1uvVNHOBQQwHHK4pGN/rojTpJ66H0ge4oGonyAz2mdeQxDp
LOlvI+H9ZlTsDc6pSqvj6G7WMhnwxTCpIfitTLT8XnrQFPRs2m1InL/Pu1AcWM5S
PJhjKZeFD6TvH31FkDJY
=WeoO
-----END PGP SIGNATURE-----
--=-=-=--
