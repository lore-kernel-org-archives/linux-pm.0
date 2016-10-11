From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v17 3/4] usb: gadget: Integrate with the usb gadget
 supporting for usb charger
Date: Tue, 11 Oct 2016 11:06:36 +0800
Message-ID: <57FC573C.2060301@linux.intel.com>
References: <cover.1476000169.git.baolin.wang@linaro.org>
 <700f8d4fc3c52418eeba5445f6822093cc9ff036.1476000169.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52861 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753085AbcJKDJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 23:09:44 -0400
In-Reply-To: <700f8d4fc3c52418eeba5445f6822093cc9ff036.1476000169.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, john.stultz@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

Hi,

On 10/10/2016 02:22 PM, Baolin Wang wrote:
> When the usb gadget supporting for usb charger is ready, the usb charger
> can implement the usb_charger_plug_by_gadget() function, usb_charger_exit()
> function and dev_to_uchger() function by getting 'struct usb_charger' from
> 'struct gadget'.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Li Jun <jun.li@nxp.com>
> Tested-by: Li Jun <jun.li@nxp.com>
> ---
>  drivers/usb/gadget/udc/charger.c |   97 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
> index 16dc477..691cd75 100644
> --- a/drivers/usb/gadget/udc/charger.c
> +++ b/drivers/usb/gadget/udc/charger.c
> @@ -38,7 +38,9 @@ static DEFINE_MUTEX(charger_lock);
>  
>  static struct usb_charger *dev_to_uchger(struct device *dev)
>  {
> -	return NULL;
> +	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
> +
> +	return gadget->charger;
>  }
>  
>  /*
> @@ -308,6 +310,18 @@ static int __usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
>  int usb_charger_set_cur_limit_by_gadget(struct usb_gadget *gadget,
>  					unsigned int cur_limit)
>  {
> +	struct usb_charger *uchger = gadget->charger;
> +	int ret;
> +
> +	if (!uchger)
> +		return -EINVAL;
> +
> +	ret = __usb_charger_set_cur_limit_by_type(uchger, uchger->type,
> +						  cur_limit);
> +	if (ret)
> +		return ret;
> +
> +	schedule_work(&uchger->work);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_gadget);
> @@ -625,11 +639,67 @@ static int usb_charger_plug_by_extcon(struct notifier_block *nb,
>  int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
>  			       unsigned long state)
>  {
> +	struct usb_charger *uchger = gadget->charger;
> +	enum usb_charger_state uchger_state;
> +
> +	if (WARN(!uchger, "charger can not be NULL"))
> +		return -EINVAL;
> +
> +	/*
> +	 * Report event to power to setting the current limitation
> +	 * for this usb charger when one usb charger state is changed
> +	 * with detecting by usb gadget state.
> +	 */
> +	if (uchger->old_gadget_state != state) {
> +		uchger->old_gadget_state = state;
> +
> +		if (state >= USB_STATE_ATTACHED) {
> +			uchger_state = USB_CHARGER_PRESENT;
> +		} else if (state == USB_STATE_NOTATTACHED) {
> +			mutex_lock(&uchger->lock);
> +
> +			/*
> +			 * Need check the charger type to make sure the usb
> +			 * cable is removed, in case it just changes the usb
> +			 * function with configfs.
> +			 */
> +			uchger->type = __usb_charger_get_type(uchger);
> +			if (uchger->type != UNKNOWN_TYPE) {
> +				mutex_unlock(&uchger->lock);
> +				return 0;
> +			}
> +
> +			mutex_unlock(&uchger->lock);
> +			uchger_state = USB_CHARGER_REMOVE;
> +		} else {
> +			uchger_state = USB_CHARGER_DEFAULT;
> +		}
> +
> +		usb_charger_notify_state(uchger, uchger_state);
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(usb_charger_plug_by_gadget);
>  
>  /*
> + * usb_charger_unregister() - Unregister a usb charger.
> + * @uchger - the usb charger to be unregistered.
> + */
> +static int usb_charger_unregister(struct usb_charger *uchger)
> +{
> +	ida_simple_remove(&usb_charger_ida, uchger->id);
> +	sysfs_remove_groups(&uchger->gadget->dev.kobj, usb_charger_groups);
> +
> +	mutex_lock(&charger_lock);
> +	list_del(&uchger->list);
> +	mutex_unlock(&charger_lock);
> +
> +	kfree(uchger);

Any reasons you want to put kfree() here? You allocated the memory
in usb_charger_init(). Isn't usb_charger_exit() a better place?

Best regards,
Lu Baolu

> +	return 0;
> +}
> +
> +/*
>   * usb_charger_register() - Register a new usb charger.
>   * @uchger - the new usb charger instance.
>   */
> @@ -740,6 +810,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
>  	}
>  
>  	uchger->gadget = ugadget;
> +	ugadget->charger = uchger;
>  	uchger->old_gadget_state = USB_STATE_NOTATTACHED;
>  
>  	/* Register a new usb charger */
> @@ -777,7 +848,29 @@ fail_extcon:
>  
>  int usb_charger_exit(struct usb_gadget *ugadget)
>  {
> -	return 0;
> +	struct usb_charger *uchger = ugadget->charger;
> +
> +	if (!uchger)
> +		return -EINVAL;
> +
> +	ugadget->charger = NULL;
> +	extcon_unregister_notifier(uchger->extcon_dev,
> +				   EXTCON_USB,
> +				   &uchger->extcon_nb.nb);
> +	extcon_unregister_notifier(uchger->extcon_dev,
> +				   EXTCON_CHG_USB_SDP,
> +				   &uchger->extcon_type_nb.nb);
> +	extcon_unregister_notifier(uchger->extcon_dev,
> +				   EXTCON_CHG_USB_CDP,
> +				   &uchger->extcon_type_nb.nb);
> +	extcon_unregister_notifier(uchger->extcon_dev,
> +				   EXTCON_CHG_USB_DCP,
> +				   &uchger->extcon_type_nb.nb);
> +	extcon_unregister_notifier(uchger->extcon_dev,
> +				   EXTCON_CHG_USB_ACA,
> +				   &uchger->extcon_type_nb.nb);
> +
> +	return usb_charger_unregister(uchger);
>  }
>  
>  MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");

