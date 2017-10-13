From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] USB: Force disconnect Huawei 4G modem during suspend
Date: Fri, 13 Oct 2017 12:15:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1710131211200.1364-100000@iolanthe.rowland.org>
References: <20171013015501.5889-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53732 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750872AbdJMQPq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 12:15:46 -0400
In-Reply-To: <20171013015501.5889-1-drake@endlessm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oneukum@suse.com, linux-pm@vger.kernel.org, linux@endlessm.com, chiu@endlessm.com

On Fri, 13 Oct 2017, Daniel Drake wrote:

> When going into S3 suspend, the Acer TravelMate P648-M and P648-G3
> laptops immediately wake up 3-4 seconds later for no obvious reason.
> 
> Unbinding the integrated Huawei 4G LTE modem before suspend avoids
> the issue, even though we are not using the modem at all (checked
> from rescue.target/runlevel1). The problem also occurs when the option
> and cdc-ether modem drivers aren't loaded; it reproduces just with the
> base usb driver. Under Windows the system can suspend fine.
> 
> Seeking a better fix, we've tried a lot of things, including:
>  - Check that the device's power/wakeup is disabled
>  - Check that remote wakeup is off at the USB level
>  - All the quirks in drivers/usb/core/quirks.c e.g. USB_QUIRK_RESET_RESUME,
>    USB_QUIRK_RESET, USB_QUIRK_IGNORE_REMOTE_WAKEUP, USB_QUIRK_NO_LPM.
> 
> but none of that makes any difference.
> 
> There are no errors in the logs showing any suspend/resume-related issues.
> When the system wakes up due to the modem, log-wise it appears to be a
> normal resume.
> 
> Introduce a quirk to disable the port during suspend when the modem is
> detected.

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index eb87a259d55c..7c048afc9bfd 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1461,6 +1461,7 @@ static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
>  int usb_suspend(struct device *dev, pm_message_t msg)
>  {
>  	struct usb_device	*udev = to_usb_device(dev);
> +	int r;
>  
>  	unbind_no_pm_drivers_interfaces(udev);
>  
> @@ -1469,7 +1470,14 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	 * so we may still need to unbind and rebind upon resume
>  	 */
>  	choose_wakeup(udev, msg);
> -	return usb_suspend_both(udev, msg);
> +	r = usb_suspend_both(udev, msg);
> +	if (r)
> +		return r;
> +
> +	if (udev->quirks & USB_QUIRK_DISCONNECT_SUSPEND)
> +		r = usb_port_disable(udev);
> +
> +	return r;

Here it's probably best to ignore the return value.  Even if 
usb_port_disable failed, you want the system suspend to move forward -- 
even if the system spontaneously wakes up a second later.

>  }
>  
>  /* The device lock is held by the PM core */
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b5c733613823..9662eaa9c44d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4180,6 +4180,19 @@ static int hub_port_disable(struct usb_hub *hub, int port1, int set_state)
>  	return ret;
>  }
>  
> +/*
> + * usb_port_disable - disable a usb device's upstream port
> + * @udev: device to disable
> + * Context: must be able to sleep; device not locked; pm locks held

Actually the device _is_ locked when this routine gets called.  And the 
PM locks are not held.

> + *
> + * Disables a USB device that isn't in active use.
> + */
> +int usb_port_disable(struct usb_device *udev)
> +{
> +	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
> +
> +	return hub_port_disable(hub, udev->portnum, 1);
> +}

You probably want the last argument to be 0, not 1.  The 1 will cause
the device to be marked as disconnected, so when the system wakes up it
will think that a new device has been plugged in rather than the old
device having been attached all along.

Alan Stern
