From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] irq / PM: New driver interface for wakeup
 interrupts
Date: Thu, 31 Jul 2014 00:56:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407302350260.4170@nanos>
References: <20140724212620.GO3935@laptop> <3042738.6Ohp3GcNCj@vostro.rjw.lan> <8151374.tpuvaHv3nd@vostro.rjw.lan> <5808955.xYYC2DJrBV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58050 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaG3W5E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jul 2014 18:57:04 -0400
In-Reply-To: <5808955.xYYC2DJrBV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

On Wed, 30 Jul 2014, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Device drivers currently use enable_irq_wake() to configure their
> interrupts for system wakeup, but that API is not particularly
> well suited for this purpose, because it goes directly all the
> way to the hardware and attempts to change the IRQ configuration
> at the chip level.
>
> The first problem with this approach is that the IRQ subsystem
> is not told which interrupt handler is supposed to handle
> interrupts from the wakeup line should they occur during system
> suspend or resume.  That is problematic if the IRQ is shared
> and the other devices sharing it with the wakeup device in question
> are not wakeup devices.  In that case their drivers may not be
> prepared to handle interrupts after the devices have been powered
> down and they may expect suspend_device_irqs() to disable the
> interrupt.  For this reason, the IRQ should not be left enabled
> by suspend_device_irqs() in that case.  On the other hand, though,
> it needs to be left enabled to prevent wakeup events occuring
> after suspend_device_irqs() has returned from being lost.

I really disagree here. The API was designed at a point where it was
very well suited for the purpose. At least from the POV of the
hardware which caused that infrastructure to be built. Looking at it
10 years later with a different set of hardware requirements in mind
does not make it invalid.

That's really not the way it works. x86 didn't give a rats ass 10
years ago when this was introduced, simply because there was no x86
hardware which could support this or if there was hardware nobody was
interested to do so. Coming in 10 years after the fact and telling
those who designed and used this for 10 years, that it's a design
failure is more than inappropriate.

There is nothing wrong to point out that existing infrastructure is
not able to handle the new requirements of differently (and partially
ass backwards) designed hardware. But that's different from stating:

   "that API is not particularly well suited for the purpose"

What's worse is that you are merily fiddling around in the existing
code without doing a proper analysis of the existing semantics and a
proper description of your new semantics.

Before this code changes in any way I want to see:

 1) a description of the existing semantics and their background

 2) a description of the short comings of the existing semantics w/o
    considering the new fangled (hardware) use cases

 3) a description how to mitigate the short comings described in #2
    w/o breaking the world and some more and introducing hard to
    decode regressions

 4) a description why the improvements introduced by #3 are not
    sufficient for the new fangled (hardware) use cases

 5) a description how to mitigate the short comings described in #4
    w/o breaking the world and some more and introducing hard to
    decode regressions

Thanks,

	tglx
