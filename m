From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 6/6] USB / PM: Allow USB devices to remain
 runtime-suspended when sleeping
Date: Wed, 01 Apr 2015 14:40:50 +0200
Message-ID: <1427892050.30440.10.camel@suse.de>
References: <Pine.LNX.4.44L0.1503311259340.1453-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1503311259340.1453-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scot Doyle <lkml14@scotdoyle.com>, Dan Williams <dan.j.williams@intel.com>, Julius Werner <jwerner@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Pratyush Anand <pratyush.anand@st.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-03-31 at 13:09 -0400, Alan Stern wrote:
> In other words, if the device is currently in runtime suspend with 
> remote wakeup enabled, but device_may_wakeup() returns 0 (so that the 
> device should be disabled for wakeup when the system goes into 
> suspend), then the prepare callback has to return 0.
> 
> Therefore what you need to do here is something like this:
> 
>         struct usb_device       *udev = to_usb_device(dev);
> 
>         /* Return 0 if the current wakeup setting is wrong, otherwise
> 1 */

And the other way round?

	Regards
		Oliver
