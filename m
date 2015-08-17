From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 1/3] gadget: Support for the usb charger framework
Date: Mon, 17 Aug 2015 08:40:10 +0800
Message-ID: <20150817004009.GB1864@shlinux2>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <33e56f632418b8e42162d5b64decb6ffc8de3e01.1439519412.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <33e56f632418b8e42162d5b64decb6ffc8de3e01.1439519412.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 14, 2015 at 05:47:44PM +0800, Baolin Wang wrote:
> The usb charger framework is based on usb gadget, and each usb gadget
> can be one usb charger to set the current limitation.
> 
> This patch adds a notifier mechanism for usb charger to report to usb
> charger when the usb gadget state is changed.
> 
> Also we introduce a callback 'get_charger_type' which will implemented
> by user for usb gadget operations to get the usb charger type.
> 
> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/usb/gadget/udc/udc-core.c |   38 +++++++++++++++++++++++++++++++++++++
>  include/linux/usb/gadget.h        |   20 +++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index f660afb..47b231c 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -28,6 +28,7 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb.h>
> +#include <linux/usb/usb_charger.h>
>  
>  /**
>   * struct usb_udc - describes one usb device controller
> @@ -129,6 +130,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
>  }
>  EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
>  
> +int usb_gadget_register_notify(struct usb_gadget *gadget,
> +			       struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	mutex_lock(&gadget->lock);
> +	ret = raw_notifier_chain_register(&gadget->nh, nb);
> +	mutex_unlock(&gadget->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_gadget_register_notify);
> +
> +int usb_gadget_unregister_notify(struct usb_gadget *gadget,
> +				 struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	mutex_lock(&gadget->lock);
> +	ret = raw_notifier_chain_unregister(&gadget->nh, nb);
> +	mutex_unlock(&gadget->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_gadget_unregister_notify);
> +
>  /* ------------------------------------------------------------------------- */
>  
>  /**
> @@ -226,6 +253,10 @@ static void usb_gadget_state_work(struct work_struct *work)
>  	struct usb_gadget *gadget = work_to_gadget(work);
>  	struct usb_udc *udc = gadget->udc;
>  
> +	mutex_lock(&gadget->lock);
> +	raw_notifier_call_chain(&gadget->nh, gadget->state, gadget);
> +	mutex_unlock(&gadget->lock);
> +
>  	if (udc)
>  		sysfs_notify(&udc->dev.kobj, NULL, "state");
>  }
> @@ -364,6 +395,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
>  
>  	dev_set_name(&gadget->dev, "gadget");
>  	INIT_WORK(&gadget->work, usb_gadget_state_work);
> +	RAW_INIT_NOTIFIER_HEAD(&gadget->nh);
> +	mutex_init(&gadget->lock);
>  	gadget->dev.parent = parent;
>  
>  #ifdef	CONFIG_HAS_DMA
> @@ -405,6 +438,10 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
>  
>  	mutex_unlock(&udc_lock);
>  
> +	ret = usb_charger_init(gadget);
> +	if (ret)
> +		goto err4;
> +

If the charger's initialization fails, you may need to
call device_del(&udc->dev).

Peter

>  	return 0;
>  
>  err4:
> @@ -481,6 +518,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	flush_work(&gadget->work);
>  	device_unregister(&udc->dev);
> +	usb_charger_exit(gadget);
>  	device_unregister(&gadget->dev);
>  }
>  EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index c14a69b..78cc862 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -537,6 +537,7 @@ struct usb_gadget_ops {
>  	struct usb_ep *(*match_ep)(struct usb_gadget *,
>  			struct usb_endpoint_descriptor *,
>  			struct usb_ss_ep_comp_descriptor *);
> +	enum usb_charger_type	(*get_charger_type)(struct usb_gadget *);
>  };
>  
>  /**
> @@ -609,6 +610,9 @@ struct usb_gadget {
>  	unsigned			out_epnum;
>  	unsigned			in_epnum;
>  	struct usb_otg_caps		*otg_caps;
> +	struct raw_notifier_head	nh;
> +	struct usb_charger		*uchger;
> +	struct mutex			lock;
>  
>  	unsigned			sg_supported:1;
>  	unsigned			is_otg:1;
> @@ -1183,6 +1187,22 @@ extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
>  
>  /*-------------------------------------------------------------------------*/
>  
> +/**
> + * Register a notifiee to get notified by any attach status changes from
> + * the usb gadget
> + */
> +int usb_gadget_register_notify(struct usb_gadget *gadget,
> +			       struct notifier_block *nb);
> +
> +/*-------------------------------------------------------------------------*/
> +
> +
> +/* Unregister a notifiee from the usb gadget */
> +int usb_gadget_unregister_notify(struct usb_gadget *gadget,
> +				 struct notifier_block *nb);
> +
> +/*-------------------------------------------------------------------------*/
> +
>  /* utility to set gadget state properly */
>  
>  extern void usb_gadget_set_state(struct usb_gadget *gadget,
> -- 
> 1.7.9.5
> 

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
