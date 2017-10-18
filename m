From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3] USB: Force disconnect Huawei 4G modem during suspend
Date: Wed, 18 Oct 2017 10:55:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1710181051270.1528-100000@iolanthe.rowland.org>
References: <20171018071501.4900-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58222 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751585AbdJROzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 10:55:01 -0400
In-Reply-To: <20171018071501.4900-1-drake@endlessm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oneukum@suse.com, linux-pm@vger.kernel.org, linux@endlessm.com, chiu@endlessm.com

On Wed, 18 Oct 2017, Daniel Drake wrote:

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

...

> Based on an earlier patch by Chris Chiu.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> 
> Notes:
>     v2:
>     - Handle quirk later in suspend, to avoid interfering with other parts
>       of the suspend routine.
>     - Don't do the disconnect on runtime suspend, only for S3 suspend
>     
>     v3:
>     - Ignore return value from usb_port_disable()
>     - Correct kerneldoc Context information
>     - Don't mark device as disconnected
> 
>  drivers/usb/core/driver.c  | 10 +++++++++-
>  drivers/usb/core/hub.c     | 13 +++++++++++++
>  drivers/usb/core/quirks.c  |  6 ++++++
>  drivers/usb/core/usb.h     |  1 +
>  include/linux/usb/quirks.h |  6 ++++++
>  5 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index eb87a259d55c..353993f983c8 100644
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
> +		usb_port_disable(udev);
> +
> +	return 0;
>  }

Bikeshedding: I would write this as:

	if (r == 0 && (udev->quirks & USB_QUIRK_DISCONNECT_SUSPEND))
		usb_port_disable(udev);
	return r;

But it doesn't matter; the compiler probably will generate the same
code either way.  In any case:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
