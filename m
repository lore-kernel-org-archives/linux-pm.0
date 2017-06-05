From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 5/7] USB: of: fix root-hub device-tree node handling
Date: Mon, 5 Jun 2017 12:51:04 +0800
Message-ID: <20170605045103.GB20014@b29397-desktop>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-6-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:56379
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbdFEEvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jun 2017 00:51:05 -0400
Content-Disposition: inline
In-Reply-To: <20170530162554.26159-6-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 30, 2017 at 06:25:52PM +0200, Johan Hovold wrote:
> In an attempt to work around a pinmux over-allocation issue in driver
> core, commit dc5878abf49c ("usb: core: move root hub's device node
> assignment after it is added to bus") moved the device-tree node
> assignment until after the root hub had been registered.
> 
> This not only makes the device-tree node unavailable to the usb driver
> during probe, but also prevents the of_node from being linked to in
> sysfs and causes a race with user-space for the (recently added) devspec
> attribute.
> 
> Use the new device_set_of_node_from_dev() helper to reuse the node of
> the sysdev device, something which now prevents driver core from trying
> to reclaim any pinctrl pins during probe.
> 
> Fixes: dc5878abf49c ("usb: core: move root hub's device node assignment after it is added to bus")
> Fixes: 51fa91475e43 ("usb/core: Added devspec sysfs entry for devices behind the usb hub")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/core/hcd.c | 2 --
>  drivers/usb/core/usb.c | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 5dea98358c05..2cff59e9c268 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1076,7 +1076,6 @@ static void usb_deregister_bus (struct usb_bus *bus)
>  static int register_root_hub(struct usb_hcd *hcd)
>  {
>  	struct device *parent_dev = hcd->self.controller;
> -	struct device *sysdev = hcd->self.sysdev;
>  	struct usb_device *usb_dev = hcd->self.root_hub;
>  	const int devnum = 1;
>  	int retval;
> @@ -1123,7 +1122,6 @@ static int register_root_hub(struct usb_hcd *hcd)
>  		/* Did the HC die before the root hub was registered? */
>  		if (HCD_DEAD(hcd))
>  			usb_hc_died (hcd);	/* This time clean up */
> -		usb_dev->dev.of_node = sysdev->of_node;
>  	}
>  	mutex_unlock(&usb_bus_idr_lock);
>  
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 62e1906bb2f3..17681d5638ac 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -416,8 +416,7 @@ static void usb_release_dev(struct device *dev)
>  
>  	usb_destroy_configuration(udev);
>  	usb_release_bos_descriptor(udev);
> -	if (udev->parent)
> -		of_node_put(dev->of_node);
> +	of_node_put(dev->of_node);
>  	usb_put_hcd(hcd);
>  	kfree(udev->product);
>  	kfree(udev->manufacturer);
> @@ -616,6 +615,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>  		dev->route = 0;
>  
>  		dev->dev.parent = bus->controller;
> +		device_set_of_node_from_dev(&dev->dev, bus->sysdev);
>  		dev_set_name(&dev->dev, "usb%d", bus->busnum);
>  		root_hub = 1;
>  	} else {
> -- 
> 2.13.0

I am OK with it, but I suggest adding it for new rc1 since it is based
on the 1st patch which is a bug-fix. If this one is really needed for
stable tree in future, you can cherry-pick it.

-- 

Best Regards,
Peter Chen
