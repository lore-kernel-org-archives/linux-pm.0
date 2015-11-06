From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/5] gadget: Introduce the notifier functions
Date: Fri, 6 Nov 2015 08:56:44 -0800
Message-ID: <20151106165644.GA23834@kroah.com>
References: <cover.1446807915.git.baolin.wang@linaro.org>
 <acd08255d6535082973a5e432c40433429544dbc.1446807915.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42635 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412AbbKFQ4p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 11:56:45 -0500
Content-Disposition: inline
In-Reply-To: <acd08255d6535082973a5e432c40433429544dbc.1446807915.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, linux-kernel@vger.kernel.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

On Fri, Nov 06, 2015 at 07:35:10PM +0800, Baolin Wang wrote:
> The usb charger framework is based on usb gadget. The usb charger
> need to be notified the state changing of usb gadget to confirm the
> usb charger state.
> 
> Thus this patch adds a notifier mechanism for usb gadget to report a
> event to usb charger when the usb gadget state is changed.

I thought we said we did not want another notifier chain in the previous
versions of this patch?

> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/usb/gadget/udc/udc-core.c |   32 ++++++++++++++++++++++++++++++++
>  include/linux/usb/gadget.h        |   18 ++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index f660afb..4238fc3 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -129,6 +129,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
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
> @@ -226,6 +252,10 @@ static void usb_gadget_state_work(struct work_struct *work)
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
> @@ -364,6 +394,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
>  
>  	dev_set_name(&gadget->dev, "gadget");
>  	INIT_WORK(&gadget->work, usb_gadget_state_work);
> +	RAW_INIT_NOTIFIER_HEAD(&gadget->nh);
> +	mutex_init(&gadget->lock);
>  	gadget->dev.parent = parent;
>  
>  #ifdef	CONFIG_HAS_DMA
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index c14a69b..755e8bc 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -609,6 +609,8 @@ struct usb_gadget {
>  	unsigned			out_epnum;
>  	unsigned			in_epnum;
>  	struct usb_otg_caps		*otg_caps;
> +	struct raw_notifier_head	nh;
> +	struct mutex			lock;

You have to document what this lock protects.


>  
>  	unsigned			sg_supported:1;
>  	unsigned			is_otg:1;
> @@ -1183,6 +1185,22 @@ extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
>  
>  /*-------------------------------------------------------------------------*/
>  
> +/**
> + * Register a notifiee to get notified by any attach status changes from
> + * the usb gadget
> + */

kerneldoc does not belong in a .h file.

And the kbuild system found lots of problems with this series, please
fix those at the very least :(

thanks,

greg k-h
