From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 6 Apr 2016 15:25:13 +0800
Message-ID: <20160406072513.GB21101@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35353 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbcDFHb6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 03:31:58 -0400
Content-Disposition: inline
In-Reply-To: <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
 +
> +static struct attribute *usb_charger_attrs[] = {
> +	&dev_attr_sdp_current.attr,
> +	&dev_attr_dcp_current.attr,
> +	&dev_attr_cdp_current.attr,
> +	&dev_attr_aca_current.attr,
> +	&dev_attr_charger_type.attr,
> +	&dev_attr_charger_state.attr,
> +	NULL
> +};

The user may only care about current limit, type and state, why they
need to care what type's current limit, it is the usb charger
framework handles, the framework judge the current according to
charger type and USB state (connect/configured/suspended).

Peter

> +ATTRIBUTE_GROUPS(usb_charger);
> +
> +/*
> + * usb_charger_find_by_name() - Get the usb charger device by name.
> + * @name - usb charger device name.
> + *
> + * return the instance of usb charger device, the device must be
> + * released with usb_charger_put().
> + */
> +struct usb_charger *usb_charger_find_by_name(const char *name)
> +{
> +	struct class_dev_iter iter;
> +	struct device *dev;
> +
> +	if (WARN(!name, "can't work with NULL name"))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Iterate all usb charger devices in the class */
> +	class_dev_iter_init(&iter, usb_charger_class, NULL, NULL);
> +	while ((dev = class_dev_iter_next(&iter))) {
> +		if (!strcmp(dev_name(dev), name))
> +			break;
> +	}
> +	class_dev_iter_exit(&iter);
> +
> +	if (WARN(!dev, "can't find usb charger device"))
> +		return ERR_PTR(-ENODEV);
> +
> +	return dev_to_uchger(dev);
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
> + * usb_charger_get_type() - get the usb charger type with lock protection.
> + * @uchger - usb charger device
> + *
> + * Users can get the charger type by this safe API, rather than using the
> + * usb_charger structure directly.
> + */
> +enum usb_charger_type usb_charger_get_type(struct usb_charger *uchger)
> +{
> +	enum usb_charger_type type;
> +
> +	mutex_lock(&uchger->lock);
> +	type = uchger->type;
> +	mutex_unlock(&uchger->lock);
> +
> +	return type;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_get_type);
> +
> +/*
> + * usb_charger_detect_type() - detect the charger type manually.
> + * @uchger - usb charger device
> + *
> + * Note: You should ensure you need to detect the charger type manually on your
> + * platform.
> + * You should call it at the right gadget state to avoid affecting gadget
> + * enumeration.
> + */
> +int usb_charger_detect_type(struct usb_charger *uchger)
> +{
> +	enum usb_charger_type type;
> +
> +	if (WARN(!uchger->charger_detect,
> +		 "charger detection method should not be NULL"))
> +		return -EINVAL;
> +
> +	type = uchger->charger_detect(uchger);
> +
> +	mutex_lock(&uchger->lock);
> +	uchger->type = type;
> +	mutex_unlock(&uchger->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_detect_type);
> +
> +/*
> + * usb_charger_get_type_by_others() - Get the usb charger type by the callback
> + * which is implemented by users.
> + * @uchger - the usb charger device.
> + *
> + * Note: This function is just used for getting the charger type, not for
> + * detecting charger type which might affect the DP/DM line when gadget is on
> + * enumeration state.
> + */
> +static enum usb_charger_type
> +usb_charger_get_type_by_others(struct usb_charger *uchger)
> +{
> +	if (uchger->type != UNKNOWN_TYPE)
> +		return uchger->type;
> +
> +	if (uchger->psy) {
> +		union power_supply_propval val;
> +
> +		power_supply_get_property(uchger->psy,
> +					  POWER_SUPPLY_PROP_CHARGE_TYPE,
> +					  &val);
> +		switch (val.intval) {
> +		case POWER_SUPPLY_TYPE_USB:
> +			uchger->type = SDP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_DCP:
> +			uchger->type = DCP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_CDP:
> +			uchger->type = CDP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_ACA:
> +			uchger->type = ACA_TYPE;
> +			break;
> +		default:
> +			uchger->type = UNKNOWN_TYPE;
> +			break;
> +		}
> +	} else if (uchger->get_charger_type) {
> +		uchger->type = uchger->get_charger_type(uchger);
> +	} else {
> +		uchger->type = UNKNOWN_TYPE;
> +	}
> +
> +	return uchger->type;
> +}
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
> +	if (WARN(!uchger, "charger can not be NULL"))
> +		return -EINVAL;
> +
> +	mutex_lock(&uchger->lock);
> +	switch (type) {
> +	case SDP_TYPE:
> +		uchger->cur_limit.sdp_cur_limit = cur_limit;
> +		break;
> +	case DCP_TYPE:
> +		uchger->cur_limit.dcp_cur_limit = cur_limit;
> +		break;
> +	case CDP_TYPE:
> +		uchger->cur_limit.cdp_cur_limit	= cur_limit;
> +		break;
> +	case ACA_TYPE:
> +		uchger->cur_limit.aca_cur_limit	= cur_limit;
> +		break;
> +	default:
> +		mutex_unlock(&uchger->lock);
> +		return -EINVAL;
> +	}
> +
> +	mutex_unlock(&uchger->lock);
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
> +	if (WARN(!uchger || !cur_limit_set, "charger or setting can't be NULL"))
> +		return -EINVAL;
> +
> +	mutex_lock(&uchger->lock);
> +	uchger->cur_limit.sdp_cur_limit = cur_limit_set->sdp_cur_limit;
> +	uchger->cur_limit.dcp_cur_limit = cur_limit_set->dcp_cur_limit;
> +	uchger->cur_limit.cdp_cur_limit = cur_limit_set->cdp_cur_limit;
> +	uchger->cur_limit.aca_cur_limit = cur_limit_set->aca_cur_limit;
> +	mutex_unlock(&uchger->lock);
> +
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
> +static unsigned int
> +usb_charger_get_cur_limit(struct usb_charger *uchger)
> +{
> +	enum usb_charger_type uchger_type =
> +		usb_charger_get_type_by_others(uchger);
> +	unsigned int cur_limit;
> +
> +	switch (uchger_type) {
> +	case SDP_TYPE:
> +		cur_limit = uchger->cur_limit.sdp_cur_limit;
> +		break;
> +	case DCP_TYPE:
> +		cur_limit = uchger->cur_limit.dcp_cur_limit;
> +		break;
> +	case CDP_TYPE:
> +		cur_limit = uchger->cur_limit.cdp_cur_limit;
> +		break;
> +	case ACA_TYPE:
> +		cur_limit = uchger->cur_limit.aca_cur_limit;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return cur_limit;
> +}
> +
> +/*
> + * usb_charger_get_current() - Get the charger current with lock protection.
> + * @uchger - the usb charger device.
> + *
> + * Users should get the charger current by this safe API.
> + */
> +unsigned int usb_charger_get_current(struct usb_charger *uchger)
> +{
> +	unsigned int cur;
> +
> +	mutex_lock(&uchger->lock);
> +	cur = usb_charger_get_cur_limit(uchger);
> +	mutex_unlock(&uchger->lock);
> +
> +	return cur;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_get_current);
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
> +	if (WARN(!uchger || !nb, "charger or nb can not be NULL"))
> +		return -EINVAL;
> +
> +	mutex_lock(&uchger->lock);
> +	ret = raw_notifier_chain_register(&uchger->uchger_nh, nb);
> +
> +	/* Generate an initial notify so users start in the right state */
> +	if (!ret) {
> +		usb_charger_get_type_by_others(uchger);
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
> + * usb_charger_unregister_notify() - Unregister a notifiee from the usb charger.
> + * @uchger - the usb charger device which is monitored.
> + * @nb - a notifier block to be unregistered.
> + */
> +int usb_charger_unregister_notify(struct usb_charger *uchger,
> +				  struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	if (WARN(!uchger || !nb, "charger or nb can not be NULL"))
> +		return -EINVAL;
> +
> +	mutex_lock(&uchger->lock);
> +	ret = raw_notifier_chain_unregister(&uchger->uchger_nh, nb);
> +	mutex_unlock(&uchger->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_unregister_notify);
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
> +	char uchger_state[50] = { 0 };
> +	char *envp[] = { uchger_state, NULL };
> +
> +	mutex_lock(&uchger->lock);
> +	uchger->state = state;
> +
> +	switch (state) {
> +	case USB_CHARGER_PRESENT:
> +		usb_charger_get_type_by_others(uchger);
> +		raw_notifier_call_chain(&uchger->uchger_nh,
> +			usb_charger_get_cur_limit(uchger),
> +			uchger);
> +		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
> +			 "USB_CHARGER_STATE=%s", "USB_CHARGER_PRESENT");
> +		break;
> +	case USB_CHARGER_REMOVE:
> +		uchger->type = UNKNOWN_TYPE;
> +		raw_notifier_call_chain(&uchger->uchger_nh, 0, uchger);
> +		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
> +			 "USB_CHARGER_STATE=%s", "USB_CHARGER_REMOVE");
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
> + * usb_charger_plug_by_extcon() - The notifier call function which is registered
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
> +	struct usb_charger_nb *extcon_nb =
> +		container_of(nb, struct usb_charger_nb, nb);
> +	struct usb_charger *uchger = extcon_nb->uchger;
> +	enum usb_charger_state uchger_state;
> +
> +	if (WARN(!uchger, "charger can not be NULL"))
> +		return NOTIFY_BAD;
> +
> +	/*
> +	 * Report event to power to setting the current limitation
> +	 * for this usb charger when one usb charger is added or removed
> +	 * with detecting by extcon device.
> +	 */
> +	if (state)
> +		uchger_state = USB_CHARGER_PRESENT;
> +	else
> +		uchger_state = USB_CHARGER_REMOVE;
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
> +static int devm_uchger_dev_match(struct device *dev, void *res, void *data)
> +{
> +	struct usb_charger **r = res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r == data;
> +}
> +
> +static void usb_charger_release(struct device *dev)
> +{
> +	struct usb_charger *uchger = dev_get_drvdata(dev);
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
> +	if (WARN(!uchger, "charger can not be NULL"))
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
> +EXPORT_SYMBOL_GPL(devm_usb_charger_unregister);
> +
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
> +	if (WARN(!uchger, "charger can not be NULL"))
> +		return -EINVAL;
> +
> +	uchger->dev.parent = parent;
> +	uchger->dev.release = usb_charger_release;
> +	uchger->dev.class = usb_charger_class;
> +	uchger->dev.groups = usb_charger_groups;
> +
> +	ret = ida_simple_get(&usb_charger_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto fail_ida;
> +
> +	uchger->id = ret;
> +	dev_set_name(&uchger->dev, "usb-charger.%d", uchger->id);
> +	dev_set_drvdata(&uchger->dev, uchger);
> +
> +	ret = device_register(&uchger->dev);
> +	if (ret)
> +		goto fail_register;
> +
> +	return 0;
> +
> +fail_register:
> +	put_device(&uchger->dev);
> +	ida_simple_remove(&usb_charger_ida, uchger->id);
> +	uchger->id = -1;
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
> +	ptr = devres_alloc(devm_uchger_dev_unreg, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = usb_charger_register(dev, uchger);
> +	if (ret) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr = uchger;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_usb_charger_register);
> +
> +int usb_charger_init(struct usb_gadget *ugadget)
> +{
> +	struct usb_charger *uchger;
> +	struct extcon_dev *edev;
> +	struct power_supply *psy;
> +	int ret;
> +
> +	uchger = kzalloc(sizeof(struct usb_charger), GFP_KERNEL);
> +	if (!uchger)
> +		return -ENOMEM;
> +
> +	uchger->type = UNKNOWN_TYPE;
> +	uchger->state = USB_CHARGER_DEFAULT;
> +	uchger->id = -1;
> +
> +	if (ugadget->speed >= USB_SPEED_SUPER)
> +		uchger->cur_limit.sdp_cur_limit = DEFAULT_SDP_CUR_LIMIT_SS;
> +	else
> +		uchger->cur_limit.sdp_cur_limit = DEFAULT_SDP_CUR_LIMIT;
> +	uchger->cur_limit.dcp_cur_limit = DEFAULT_DCP_CUR_LIMIT;
> +	uchger->cur_limit.cdp_cur_limit = DEFAULT_CDP_CUR_LIMIT;
> +	uchger->cur_limit.aca_cur_limit = DEFAULT_ACA_CUR_LIMIT;
> +
> +	mutex_init(&uchger->lock);
> +	RAW_INIT_NOTIFIER_HEAD(&uchger->uchger_nh);
> +
> +	/* register a notifier on a extcon device if it is exsited */
> +	edev = extcon_get_edev_by_phandle(ugadget->dev.parent, 0);
> +	if (!IS_ERR_OR_NULL(edev)) {
> +		uchger->extcon_dev = edev;
> +		uchger->extcon_nb.nb.notifier_call = usb_charger_plug_by_extcon;
> +		uchger->extcon_nb.uchger = uchger;
> +		extcon_register_notifier(edev, EXTCON_USB,
> +					 &uchger->extcon_nb.nb);
> +	}
> +
> +	/* to check if the usb charger is link to a power supply */
> +	psy = devm_power_supply_get_by_phandle(ugadget->dev.parent,
> +					       "power-supplies");
> +	if (!IS_ERR_OR_NULL(psy))
> +		uchger->psy = psy;
> +	else
> +		uchger->psy = NULL;
> +
> +	/* register a notifier on a usb gadget device */
> +	uchger->gadget = ugadget;
> +	uchger->old_gadget_state = ugadget->state;
> +
> +	/* register a new usb charger */
> +	ret = usb_charger_register(&ugadget->dev, uchger);
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
> +static int __init usb_charger_class_init(void)
> +{
> +	usb_charger_class = class_create(THIS_MODULE, "usb_charger");
> +	if (IS_ERR(usb_charger_class)) {
> +		pr_err("couldn't create class\n");
> +		return PTR_ERR(usb_charger_class);
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit usb_charger_class_exit(void)
> +{
> +	class_destroy(usb_charger_class);
> +}
> +subsys_initcall(usb_charger_class_init);
> +module_exit(usb_charger_class_exit);
> +
> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
> +MODULE_DESCRIPTION("USB charger driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/usb/charger.h b/include/linux/usb/charger.h
> new file mode 100644
> index 0000000..1bf1d55
> --- /dev/null
> +++ b/include/linux/usb/charger.h
> @@ -0,0 +1,171 @@
> +#ifndef __LINUX_USB_CHARGER_H__
> +#define __LINUX_USB_CHARGER_H__
> +
> +#include <uapi/linux/usb/ch9.h>
> +#include <uapi/linux/usb/charger.h>
> +
> +/* Current limitation by charger type */
> +struct usb_charger_cur_limit {
> +	unsigned int sdp_cur_limit;
> +	unsigned int dcp_cur_limit;
> +	unsigned int cdp_cur_limit;
> +	unsigned int aca_cur_limit;
> +};
> +
> +struct usb_charger_nb {
> +	struct notifier_block	nb;
> +	struct usb_charger	*uchger;
> +};
> +
> +struct usb_charger {
> +	struct device		dev;
> +	struct raw_notifier_head	uchger_nh;
> +	/* protect the notifier head and charger */
> +	struct mutex		lock;
> +	int			id;
> +	enum usb_charger_type	type;
> +	enum usb_charger_state	state;
> +
> +	/* for supporting extcon usb gpio */
> +	struct extcon_dev	*extcon_dev;
> +	struct usb_charger_nb	extcon_nb;
> +
> +	/* for supporting usb gadget */
> +	struct usb_gadget	*gadget;
> +	enum usb_device_state	old_gadget_state;
> +
> +	/* for supporting power supply */
> +	struct power_supply	*psy;
> +
> +	/* user can get charger type by implementing this callback */
> +	enum usb_charger_type	(*get_charger_type)(struct usb_charger *);
> +	/*
> +	 * charger detection method can be implemented if you need to
> +	 * manually detect the charger type.
> +	 */
> +	enum usb_charger_type	(*charger_detect)(struct usb_charger *);
> +
> +	/* current limitation */
> +	struct usb_charger_cur_limit	cur_limit;
> +};
> +
> +#ifdef CONFIG_USB_CHARGER
> +extern struct usb_charger *usb_charger_find_by_name(const char *name);
> +
> +extern struct usb_charger *usb_charger_get(struct usb_charger *uchger);
> +extern void usb_charger_put(struct usb_charger *uchger);
> +
> +extern int usb_charger_register_notify(struct usb_charger *uchger,
> +				       struct notifier_block *nb);
> +extern int usb_charger_unregister_notify(struct usb_charger *uchger,
> +					 struct notifier_block *nb);
> +
> +extern int usb_charger_set_cur_limit(struct usb_charger *uchger,
> +				struct usb_charger_cur_limit *cur_limit_set);
> +extern int usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
> +					     enum usb_charger_type type,
> +					     unsigned int cur_limit);
> +extern unsigned int usb_charger_get_current(struct usb_charger *uchger);
> +
> +extern int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
> +				      unsigned long state);
> +extern enum usb_charger_type usb_charger_get_type(struct usb_charger *uchger);
> +extern int usb_charger_detect_type(struct usb_charger *uchger);
> +
> +extern void devm_usb_charger_unregister(struct device *dev,
> +					struct usb_charger *uchger);
> +extern int devm_usb_charger_register(struct device *dev,
> +				     struct usb_charger *uchger);
> +
> +extern int usb_charger_init(struct usb_gadget *ugadget);
> +extern int usb_charger_exit(struct usb_gadget *ugadget);
> +#else
> +static inline struct usb_charger *usb_charger_find_by_name(const char *name)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline struct usb_charger *usb_charger_get(struct usb_charger *uchger)
> +{
> +	return NULL;
> +}
> +
> +static inline void usb_charger_put(struct usb_charger *uchger)
> +{
> +}
> +
> +static inline int
> +usb_charger_register_notify(struct usb_charger *uchger,
> +			    struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +usb_charger_unregister_notify(struct usb_charger *uchger,
> +			      struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +usb_charger_set_cur_limit(struct usb_charger *uchger,
> +			  struct usb_charger_cur_limit *cur_limit_set)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
> +				  enum usb_charger_type type,
> +				  unsigned int cur_limit)
> +{
> +	return 0;
> +}
> +
> +static inline unsigned int
> +usb_charger_get_current(struct usb_charger *uchger)
> +{
> +	return 0;
> +}
> +
> +static inline enum usb_charger_type
> +usb_charger_get_type(struct usb_charger *uchger)
> +{
> +	return UNKNOWN_TYPE;
> +}
> +
> +static inline int usb_charger_detect_type(struct usb_charger *uchger)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +usb_charger_plug_by_gadget(struct usb_gadget *gadget, unsigned long state)
> +{
> +	return 0;
> +}
> +
> +static inline void devm_usb_charger_unregister(struct device *dev,
> +					       struct usb_charger *uchger)
> +{
> +}
> +
> +static inline int devm_usb_charger_register(struct device *dev,
> +					    struct usb_charger *uchger)
> +{
> +	return 0;
> +}
> +
> +static inline int usb_charger_init(struct usb_gadget *ugadget)
> +{
> +	return 0;
> +}
> +
> +static inline int usb_charger_exit(struct usb_gadget *ugadget)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* __LINUX_USB_CHARGER_H__ */
> diff --git a/include/uapi/linux/usb/charger.h b/include/uapi/linux/usb/charger.h
> new file mode 100644
> index 0000000..3c56ec4
> --- /dev/null
> +++ b/include/uapi/linux/usb/charger.h
> @@ -0,0 +1,31 @@
> +/*
> + * This file defines the USB charger type and state that are needed for
> + * USB device APIs.
> + */
> +
> +#ifndef _UAPI__LINUX_USB_CHARGER_H
> +#define _UAPI__LINUX_USB_CHARGER_H
> +
> +/*
> + * USB charger type:
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
> +
> +#endif /* _UAPI__LINUX_USB_CHARGER_H */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
