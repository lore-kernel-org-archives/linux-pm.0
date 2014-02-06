From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
Date: Thu, 6 Feb 2014 14:09:59 +0000 (GMT)
Message-ID: <alpine.LFD.2.11.1402061152550.1906@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org> <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org> <20140130152500.GB5002@laptop.programming.kicks-ass.net> <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140130162753.GF5002@laptop.programming.kicks-ass.net>
Sender: linux-sh-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jan 2014, Peter Zijlstra wrote:

> On Thu, Jan 30, 2014 at 11:03:31AM -0500, Nicolas Pitre wrote:
> > > This is not a valid patch for PATCH(1). Please try again.
> > 
> > Don't you use git?  ;-)
> 
> Nah, git and me don't get along well.
> 
> > Here's a plain patch:
> 
> Thanks!

Hi Peter,

Did you merge those patches in your tree?  If so, is it published 
somewhere?  That would be a good idea if that could appear in linux-next 
so to prevent people from adding more calls to cpuidle_idle_call() from 
architecture code.  I'm sending you 2 additional patches right away to 
remove those that appeared in v3.14-rc1.


Nicolas
