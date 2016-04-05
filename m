From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Tue, 5 Apr 2016 15:56:12 +0800
Message-ID: <20160405075612.GB31351@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
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

When the above API is expected to call? Can we use the USB charger
without USB gadget?

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

We still haven't known bus speed here, it is better do it after
setting configuration has finished.

Peter

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
