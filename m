From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Auto suspend not working on usb hid devices
Date: Tue, 13 Jan 2015 10:37:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1501131029040.1520-100000@iolanthe.rowland.org>
References: <CAOVJa8GkYnT3MV-jgLhoagUL1N3GhTGooho=pbVr7LcUUWXwvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41429 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751132AbbAMPhh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 10:37:37 -0500
In-Reply-To: <CAOVJa8GkYnT3MV-jgLhoagUL1N3GhTGooho=pbVr7LcUUWXwvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: linux-pm@vger.kernel.org

On Tue, 13 Jan 2015, vichy wrote:

> I purposely dump runtime_usage after calling
> pm_runtime_put_async_autosuspend(), but the value is still 2.
> I found the value increase/decrease like below:

In usb_new_device():
> pm_runtime_get_noresume => 1
> usb_disable_autosuspend => 2
> usb_probe_device
>     -> usb_autoresume_device => 3

That's where you go wrong.  usb_probe_device() does this:

	if (!udriver->supports_autosuspend)
		error = usb_autoresume_device(udev);

and udriver->supports_autosuspend should be 1.  See the definition of 
usb_generic_driver at the end of generic.c.

> usb_set_configuration
>     ->usb_autoresume_device =>4
> usb_set_configuration
>     ->usb_autosuspend_device =>3
> pm_runtime_put_sync_autosuspend => 2
> 
> so even after calling pm_runtime_put_async_autosuspend() at end fo
> usb_new_device()
> the runtime_usage will not be back to 1

It would be 1 if udriver in usb_probe_device() was equal to 
usb_generic_driver.

> is there any rule for us to determine where we add those
> usb_autoresume_device/usb_autosuspend_device in usb driver?

The rule is very simple: You autoresume in places where you need the 
device to be active, and you autosuspend when you don't need the device 
to be active any more.

Alan Stern


