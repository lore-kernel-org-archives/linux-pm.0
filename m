From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no
 PM_RUNTIME
Date: Wed, 12 Nov 2014 11:34:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411121124420.1676-100000@iolanthe.rowland.org>
References: <CAPDyKFqzWvcr7qrnBed=atbtGoUTJ5-8URvn7ZMYJZoZk2+dYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44639 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753230AbaKLQeS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 11:34:18 -0500
In-Reply-To: <CAPDyKFqzWvcr7qrnBed=atbtGoUTJ5-8URvn7ZMYJZoZk2+dYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 12 Nov 2014, Ulf Hansson wrote:

> Since AMBA bus/drivers are handling runtime PM resources like
> clocks/pinctrl/etc from their runtime PM callbacks, using
> pm_runtime_force_suspen|resume() from their system PM callbacks makes
> perfect sense to me.

This sounds like a case of misdesign.  If clocks/pinctrl/etc are all
purely _runtime_ PM resources then the _system_ PM callbacks should
have nothing to do with them.  On the other hand, if they are general
PM resources then they should be handled from a general-purpose routine
that can be invoked by both the runtime-PM and system-PM callbacks.

It makes very little sense to have a special-purpose routine manage a 
general-purpose resource.

> > As I understand the problem, you've got a bus type where some of the
> > drivers have IRQ-safe runtime PM (and therefore carry out their
> > suspend/resume operations in interrupt context) and others don't.  The
> > subsystem core wants to maximize the power saving by deconfiguring some
> > clocks whenever a device is suspended, but this requires a process
> > context and so it can't be done directly when IRQ-safe runtime PM is
> > used.
> >
> > Is that a good summary?  If it is, there are ways of dealing with this
> 
> Yes.
> 
> > that don't involve messing around with the runtime PM internals, or
> > using pm_runtime_force_suspend().
> 
> The logic to handle that would in principle mean to keep track of the
> device's runtime PM status. That doesn't make sense, it's the job of
> the runtime PM core to do that!?

Why do think we have pm_runtime_suspended() and related routines?  They 
are there so that your code can make decisions based on the runtime PM 
status without having to keep track of it.

> Additionally, you would also need to protect the runtime PM resume
> callback from doing clock enable during system PM, unless you also
> disable runtime PM.
> 
> To me, pm_runtime_force_suspend|resume() will do exactly what we need
> for the AMBA case.

Your description leaves out large parts of the design.  Please list the
relevant resources, together with an explanation of exactly how each
one is handled by the system- and runtime-PM callback routines, in your
scheme.

Alan Stern

