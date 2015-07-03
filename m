From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Fri, 3 Jul 2015 11:11:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507031102520.23132-100000@netrider.rowland.org>
References: <CAAObsKD1AbpkWytnA0=uwzUih-g4p-kXU8zSv-csnihCjvvteg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:46294 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755294AbbGCPLU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 11:11:20 -0400
In-Reply-To: <CAAObsKD1AbpkWytnA0=uwzUih-g4p-kXU8zSv-csnihCjvvteg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 3 Jul 2015, Tomeu Vizoso wrote:

> >> Yeah, that would remove the need for messing with the runtime PM
> >> enable status of descendant devices, but I wonder why Rafael went that
> >> way initially.
> >
> > I forget the details.  Probably it was just to be safe.  We probably
> > thought that if a device was disabled for runtime PM then its runtime
> > PM status might not be accurate.  But if direct_complete is set then it
> > may be reasonable to assume that the runtime PM status _is_ accurate.
> 
> Cool.

> > Rafael and I briefly discussed ignore_children while the original
> > direct_complete patch was being designed.  We didn't come to any
> > definite conclusion and decided to forget about it for the time being.
> > Maybe now would be a good time to reconsider it.
> 
> I would prefer to have ignore_children ignore whether the children of
> a device were able to do direct_complete, rather than having a
> direct_complete_default flag (plus not requiring that all its
> descendants have runtime PM enabled).

Okay, but remember that sometimes these "virtual" devices will exist 
beneath a device that needs to have ignore_children off.  So this won't 
be a complete solution to your problem.

Let's see what Rafael thinks about these two issues.  It seems to me
that the hardest part is dealing with drivers/subsystems that have no
runtime PM support.  In such cases, we have to be very careful not to
use direct_complete unless we know that the device does no power 
management at all.

Alan Stern

