From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Auto suspend not working on usb hid devices
Date: Mon, 12 Jan 2015 10:18:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1501121011580.1707-100000@iolanthe.rowland.org>
References: <CAOVJa8H1JsarfphiWmTEw8MsJUxDcYi=c5GPJzvbvhziAiDcXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39188 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751131AbbALPSd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 10:18:33 -0500
In-Reply-To: <CAOVJa8H1JsarfphiWmTEw8MsJUxDcYi=c5GPJzvbvhziAiDcXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: linux-pm@vger.kernel.org

On Mon, 12 Jan 2015, vichy wrote:

> hi alan:
> > I found the power/runtime_usage = 2 when device plug in and do nothing.
> > Except update_autosuspend will increase runtime_usage, is there any
> > function will increase it when we did not enable runtime
> > suspend/resume?
> We found the runtime_usage will be 2 after calling usb_new_device.
> in usb_new_device,
>         pm_runtime_set_active(&udev->dev);
>         pm_runtime_get_noresume(&udev->dev);  // after calling left
> function, runtime_usage =1
>         pm_runtime_use_autosuspend(&udev->dev);
>         pm_runtime_enable(&udev->dev);
> 
>        /* By default, forbid autosuspend for all devices.  It will be
>         * allowed for hubs during binding.
>         */
>        usb_disable_autosuspend(udev); // after calling left function,
> runtime_usage =2
> 
> Under what circumstance, the runtime_usage will be 1 to let "echo auto
> > power/control" work?

You need to look farther down in usb_new_device().  Near the end it 
does this:

	(void) usb_create_ep_devs(&udev->dev, &udev->ep0, udev);
	usb_mark_last_busy(udev);
	pm_runtime_put_sync_autosuspend(&udev->dev);
	return err;

The pm_runtime_put_async_autosuspend() call decrements runtime_usage 
back to 1.

Alan Stern

