From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 6 Apr 2016 15:19:56 +0800
Message-ID: <20160406071956.GA21101@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36415 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbcDFH0l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 03:26:41 -0400
Content-Disposition: inline
In-Reply-To: <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Fri, Apr 01, 2016 at 03:21:50PM +0800, Baolin Wang wrote:
> For supporting the usb charger, it adds the usb_charger_init() and
> usb_charger_exit() functions for usb charger initialization and exit.
> 
> It will report to the usb charger when the gadget state is changed,
> then the usb charger can do the power things.
> 
> Introduce a callback 'get_charger_type' which will implemented by
> user for usb gadget operations to get the usb charger type.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/usb/gadget/udc/udc-core.c |   11 +++++++++++
>  include/linux/usb/gadget.h        |   15 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index b86a6f0..8d98c6b 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -28,6 +28,7 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb.h>
> +#include <linux/usb/charger.h>
>  
>  /**
>   * struct usb_udc - describes one usb device controller
> @@ -230,6 +231,9 @@ static void usb_gadget_state_work(struct work_struct *work)
>  	struct usb_gadget *gadget = work_to_gadget(work);
>  	struct usb_udc *udc = gadget->udc;
>  
> +	/* when the gadget state is changed, then report to USB charger */
> +	usb_charger_plug_by_gadget(gadget, gadget->state);
> +
>  	if (udc)
>  		sysfs_notify(&udc->dev.kobj, NULL, "state");
>  }
> @@ -423,8 +427,14 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
>  
>  	mutex_unlock(&udc_lock);
>  
> +	ret = usb_charger_init(gadget);
> +	if (ret)
> +		goto err5;
> +
>  	return 0;
>  
> +err5:
> +	device_del(&udc->dev);
>  err4:
>  	list_del(&udc->list);
>  	mutex_unlock(&udc_lock);
> @@ -503,6 +513,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	flush_work(&gadget->work);
>  	device_unregister(&udc->dev);
> +	usb_charger_exit(gadget);
>  	device_unregister(&gadget->dev);
>  }
>  EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index d82d006..054488a 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -24,6 +24,7 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <linux/usb/ch9.h>
> +#include <linux/usb/charger.h>
>  
>  struct usb_ep;
>  
> @@ -563,6 +564,8 @@ struct usb_gadget_ops {
>  	struct usb_ep *(*match_ep)(struct usb_gadget *,
>  			struct usb_endpoint_descriptor *,
>  			struct usb_ss_ep_comp_descriptor *);
> +	/* get the charger type */
> +	enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
>  };

Since we already have get_charger_type callback at usb_charger
structure, why we still need this API at usb_gadget_ops?

>  
>  /**
> @@ -635,6 +638,8 @@ struct usb_gadget {
>  	unsigned			out_epnum;
>  	unsigned			in_epnum;
>  	struct usb_otg_caps		*otg_caps;
> +	/* negotiate the power with the usb charger */
> +	struct usb_charger		*charger;
>  
>  	unsigned			sg_supported:1;
>  	unsigned			is_otg:1;
> @@ -839,10 +844,20 @@ static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
>   * reporting how much power the device may consume.  For example, this
>   * could affect how quickly batteries are recharged.
>   *
> + * It will also notify the USB charger how much power the device may
> + * consume if there is a USB charger linking with the gadget.
> + *
>   * Returns zero on success, else negative errno.
>   */
>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
>  {
> +	enum usb_charger_type type;
> +
> +	if (gadget->charger) {
> +		type = usb_charger_get_type(gadget->charger);
> +		usb_charger_set_cur_limit_by_type(gadget->charger, type, mA);
> +	}
> +

You may do something redundant.

- Charger detection only occurs at connection period, at other periods,
we only change the current limit, and notify charger IC. That is to
say, we may only need to save charger type and current limit at
usb_charger structure, we don't need to distinguish all chargers
type from time to time.

- The purpose of usb_gadget_vbus_draw design is notify charger IC too,
so you can do set current limit and notify charger IC together at this
API together, it has already covered all situations. We don't need to
notify charger IC again when the gadget status has changed again.

>  	if (!gadget->ops->vbus_draw)
>  		return -EOPNOTSUPP;
>  	return gadget->ops->vbus_draw(gadget, mA);
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
