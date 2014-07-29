From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC][PATCH] irq: Rework IRQF_NO_SUSPENDED
Date: Tue, 29 Jul 2014 12:20:08 -0700
Message-ID: <20140729192008.GH3711@ld-irv-0074>
References: <20140724212620.GO3935@laptop>
 <13290270.IfKaUSRMLR@vostro.rjw.lan>
 <20140725055847.GQ3935@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47909 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbaG2TUM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 15:20:12 -0400
Content-Disposition: inline
In-Reply-To: <20140725055847.GQ3935@laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

Hi Peter,

On Fri, Jul 25, 2014 at 07:58:47AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 25, 2014 at 01:10:36AM +0200, Rafael J. Wysocki wrote:
> > Yes, drivers using enable_irq_wake() will likely want IRQF_NO_SUSPEND to
> > be set for their irqactions, but that should not imply "no suspend" for
> > all irqactions sharing the same desc.  So I guess it may be better to go
> > forth and use a global "interrupts suspended" state variable instead of the
> > IRQS_SUSPENDED flag for each desc and throw away the IRQD_WAKEUP_STATE
> > check from suspend_device_irqs() entirely.
> > 
> > Peter, it looks like you'd prefer that?
> 
> My preference would be to shoot enable_irq_wake() in the head, its
> fundamentally broken.

I'm curious what you mean. Are you referring to the fact that its input
is simply an IRQ number (regardless of whether the IRQ is shared), not
something that identifies the particular handler (e.g., struct
irqaction)?

Brian
