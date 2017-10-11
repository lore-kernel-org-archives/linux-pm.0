From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] USB: Force disconnect Huawei 4G modem during suspend
Date: Wed, 11 Oct 2017 11:04:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1710111058380.1339-100000@iolanthe.rowland.org>
References: <20171011064753.11471-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011064753.11471-1-drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oneukum-IBi9RG/b67k@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Oct 2017, Daniel Drake wrote:

> From: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
> 
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

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3160,6 +3160,9 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  			goto err_ltm;
>  	}
>  
> +	if (udev->quirks & USB_QUIRK_DISCONNECT_SUSPEND)
> +		usb_clear_port_feature(hub->hdev, port1, USB_PORT_FEAT_ENABLE);
> +
>  	/* see 7.1.7.6 */
>  	if (hub_is_superspeed(hub->hdev))
>  		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U3);

I'm not so sure this is the right way to do it.  If you turn off the 
enable feature then the following calls to turn on the suspend feature 
will fail.  At the very least, you should change the following line so 
that it does:

	else if (hub_is_superspeed(hub->hdev)) ...

Also, you should check whether this is for a runtime suspend or a
system suspend.  You don't want to go around disconnecting a device
whenever it gets runtime suspended!

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
