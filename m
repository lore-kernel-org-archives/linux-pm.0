From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / sleep: Don't unset parent's direct_complete
Date: Wed, 25 Mar 2015 13:55:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503251346170.1401-100000@iolanthe.rowland.org>
References: <1427297276-6370-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45976 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753216AbbCYRzb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 13:55:31 -0400
In-Reply-To: <1427297276-6370-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wed, 25 Mar 2015, Tomeu Vizoso wrote:

> If a device isn't going to be fully-suspended because there isn't an
> implementation of the suspend callback, there's no need to make sure
> that its parent is going to be fully-suspended as well.

What do you mean by "fully-suspended"?

What if the parent has several children?  Maybe some of them have 
implementations of the suspend callback and the others don't.  Will 
your patch do the right thing then?

> Without this change, USB interface devices will always prevent the
> proper USB device to stay in runtime suspension when the system
> suspends.

For USB it doesn't matter; everything gets resumed when the system 
wakes up.

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> Hi,
> 
> I'm not sure if this is the right fix,

What are you trying to fix?  Is something currently wrong?

>  because I don't see why the USB
> interface devices are in the dpm_list in the first place, so any comments will
> be welcome.

_Every_ device is in the dpm_list, including USB interfaces.

If your goal is to prevent USB devices from being resumed when the
system wakes up, then the correct approach is to make usb_dev_prepare()  
return 1 rather than 0 under the appropriate conditions, and to add a
dev_pm_ops to the usb_if_device_type structure with a prepare callback 
that returns 1.

Alan Stern

