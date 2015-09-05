From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Sat, 5 Sep 2015 11:39:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509051133100.30865-100000@netrider.rowland.org>
References: <55EA113D.9000806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47665 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751353AbbIEPjV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Sep 2015 11:39:21 -0400
In-Reply-To: <55EA113D.9000806@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Sat, 5 Sep 2015, Grygorii Strashko wrote:

> On 09/04/2015 09:45 PM, Alan Stern wrote:
> > On Fri, 4 Sep 2015, Grygorii Strashko wrote:
> > 
> >> There is one "small" problem with such approach :(
> >>
> >> - It's incompatible with -RT kernel, because PM runtime can't be used
> >> in atomic context on -RT.
> > 
> > Can you explain this more fully?  Why can't runtime PM be used in
> > atomic context in the -rt kernels?
> >  
> 
> See:
>  http://lwn.net/Articles/146861/
>  https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions#How_does_the_CONFIG_PREEMPT_RT_patch_work.3F
> 
> spinlock_t
>     Critical sections are preemptible. The _irq operations (e.g., spin_lock_irqsave())
>  do -not- disable hardware interrupts. Priority inheritance is used to prevent priority
>  inversion. An underlying rt_mutex is used to implement spinlock_t in PREEMPT_RT. 
> 
> As result, have to do things like:
> https://lkml.org/lkml/2015/8/18/161
> https://lkml.org/lkml/2015/8/18/162
> 
> Sorry for brief reply - Friday/Sat night :)

I see.  Although we normally think of interrupt contexts as being
atomic, in an -rt kernel this isn't true any more because things like
spin_lock_irq don't actually disable interrupts.

Therefore it would be correct to say that in -rt kernels, runtime PM
can be used in interrupt context (if the device is marked as irq-safe),
but not in atomic context.  Right?

Alan Stern

