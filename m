From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 6/6] USB / PM: Allow USB devices to remain runtime-suspended
 when sleeping
Date: Wed, 1 Apr 2015 10:36:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504011035540.1420-100000@iolanthe.rowland.org>
References: <1427898406.30440.12.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56839 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753730AbbDAOgv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 10:36:51 -0400
In-Reply-To: <1427898406.30440.12.camel@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scot Doyle <lkml14@scotdoyle.com>, Dan Williams <dan.j.williams@intel.com>, Julius Werner <jwerner@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

On Wed, 1 Apr 2015, Oliver Neukum wrote:

> On Wed, 2015-04-01 at 10:01 -0400, Alan Stern wrote:
> > On Wed, 1 Apr 2015, Oliver Neukum wrote:
> > 
> > > On Tue, 2015-03-31 at 13:09 -0400, Alan Stern wrote:
> > > > In other words, if the device is currently in runtime suspend with 
> > > > remote wakeup enabled, but device_may_wakeup() returns 0 (so that the 
> > > > device should be disabled for wakeup when the system goes into 
> > > > suspend), then the prepare callback has to return 0.
> > > > 
> > > > Therefore what you need to do here is something like this:
> > > > 
> > > >         struct usb_device       *udev = to_usb_device(dev);
> > > > 
> > > >         /* Return 0 if the current wakeup setting is wrong, otherwise
> > > > 1 */
> > > 
> > > And the other way round?
> > 
> > Your meaning isn't clear.  Are you asking what should happen if the 
> > device is in runtime suspend with remote wakeup disabled, but 
> > device_may_wakeup() returns 1?
> 
> Yes. I was thinking about that case.
> 
> >   That case should never happen -- but 
> > if it does then the prepare callback should return 0.
> 
> Exactly. It didn't seem to do so.

Well, Tomeu can fix it up to handle both cases properly.

Alan Stern

