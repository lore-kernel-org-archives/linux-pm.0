From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe
 drivers
Date: Wed, 3 Dec 2014 13:12:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1412031309520.1538-100000@iolanthe.rowland.org>
References: <547F3210.2010604@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55420 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751273AbaLCSMr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 13:12:47 -0500
In-Reply-To: <547F3210.2010604@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com

On Wed, 3 Dec 2014, Tomi Valkeinen wrote:

> On 03/12/14 17:22, Alan Stern wrote:
> > On Tue, 2 Dec 2014, Jyri Sarha wrote:
> > 
> >> Is there something seriously wrong with the code part too? Or is this 
> >> just a matter of updating the comment (sorry that I missed that)?
> >>
> >> If the thing I am doing somehow fundamentally flawed, I 	apologize. 
> >> However, this was an RFC patch after all and the problem I am trying to 
> >> solve is real.
> > 
> > What exactly _is_ the problem you are trying to solve?
> > 
> > When I first wrote the irq_safe stuff, I considered doing something 
> > like what you want.  But there was no demand for it at the time, and 
> > leaving it out seemed simpler and safer.
> > 
> > However, if you have a genuine use case then I don't object to allowing
> > parents of irq-safe devices to enter runtime suspend, provided the
> > parents are also irq-safe.
> 
> OMAP Display subsystem hardware has one main module (dss) and multiple
> submodules (dispc being the important one here). The submodules require
> the main module to be enabled and configured to work. These are modeled
> as a dss parent platform device, and a number of child platform devices.

Although you didn't say so, it sounds like you want the dss device to 
go into runtime suspend whenever it isn't needed by any of the child 
devices.

> The DRM driver for OMAP (omapdrm uses the dispc device, and uses runtime
> PM to control dispc's power state. Unfortunately on some cases omapdrm
> wants to access the hardware from atomic context, and needs to enable
> the dispc first.
> 
> omapdrm could be changed not to touch the hardware from atomic context,
> but that is a big change, requiring rewrite of its core logic. I hope we
> get that done some day, as it would be a performance boost also. But as
> for today, omapdrm will crash in some cases when it happens to call
> runtime_get from atomic context.
> 
> So... If what's proposed in this patch is messy and risky, I think we
> should skip it and try to change omapdrm as soon as we manage to. If so,
> I'd still be interested to hear what problems this might cause, as we're
> planning to apply it to our internal tree to fix the issue with omapdrm.
> 
> But as the functionality in this patch sounded sane and something which
> could be usable for others also, we wanted to try this approach.

It seems reasonable to me.  But Rafael is the person you need to 
convince.

Alan Stern

