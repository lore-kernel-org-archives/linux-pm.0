From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] genirq: better describe IRQF_NO_SUSPEND semantics
Date: Wed, 25 Feb 2015 16:19:38 +0100
Message-ID: <20150225151938.GM5029@twins.programming.kicks-ass.net>
References: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
 <3607139.EdDhxoz0si@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51891 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbBYPTu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 10:19:50 -0500
Content-Disposition: inline
In-Reply-To: <3607139.EdDhxoz0si@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Ian Campbell <ian.campbell@citrix.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, Feb 24, 2015 at 01:26:05AM +0100, Rafael J. Wysocki wrote:
> On Friday, February 20, 2015 02:53:46 PM Mark Rutland wrote:
> > The IRQF_NO_SUSPEND flag is intended to be used for interrupts required
> > to be enabled during the suspend-resume cycle. This mostly consists of
> > IPIs and timer interrupts, potentially including chained irqchip
> > interrupts if these are necessary to handle timers or IPIs. If an
> > interrupt does not fall into one of the aforementioned categories,
> > requesting it with IRQF_NO_SUSPEND is likely incorrect.
> > 
> > Using IRQF_NO_SUSPEND does not guarantee that the interrupt can wake the
> > system from a suspended state. For an interrupt to be able to trigger a
> > wakeup, it may be necessary to program various components of the system.
> > In these cases it is necessary to use {enable,disabled}_irq_wake.
> > 
> > Unfortunately, several drivers assume that IRQF_NO_SUSPEND ensures that
> > an IRQ can wake up the system, and the documentation can be read
> > ambiguously w.r.t. this property.
> > 
> > This patch updates the documentation regarding IRQF_NO_SUSPEND to make
> > this caveat explicit, hopefully making future misuse rarer. Cleanup of
> > existing misuse will occur as part of later patch series.
> > 
> > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Applied to linux-pm.git/linux-next, thanks!
> 
> Peter, please let me know if you don't want this to go it.

No seems fine, Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
