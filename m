From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] genirq / PM: Add flag for shared NO_SUSPEND interrupt
 lines
Date: Fri, 27 Feb 2015 23:11:00 +0100
Message-ID: <20150227221100.GV5029@twins.programming.kicks-ass.net>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150227083859.GD21418@twins.programming.kicks-ass.net>
 <1968084.K4YyaeZfBq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38695 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbbB0WLP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 17:11:15 -0500
Content-Disposition: inline
In-Reply-To: <1968084.K4YyaeZfBq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Feb 27, 2015 at 11:13:57PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 27, 2015 09:38:59 AM Peter Zijlstra wrote:

> > Seems good to me. Should I take this through tip/irq ?
> 
> I can apply it along with the previous IRQF_NO_SUSPEND documentation patch
> from Mark Rutland if you ACK it for me. :-)

Works for me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> > Also, should we warn if people use enable_irq_wake() where there is only
> > a single descriptor with NO_SUSPEND?
> 
> We probably should do that, but that would be a separate patch IMO?

Agreed. Just wanted to raise the point.
