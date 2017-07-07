From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Fri, 07 Jul 2017 15:11:45 +0200
Message-ID: <4582085.aKtjXTl7qR@aspire.rjw.lan>
References: <20170705085905.6558-1-juri.lelli@arm.com> <alpine.DEB.2.20.1707071244520.1871@nanos> <20170707105316.whutk3h6x2h6xvyt@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42007 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750904AbdGGNTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 09:19:23 -0400
In-Reply-To: <20170707105316.whutk3h6x2h6xvyt@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes <joelaf@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>, Rafael J . Wy

On Friday, July 07, 2017 11:53:16 AM Juri Lelli wrote:
> On 07/07/17 12:46, Thomas Gleixner wrote:
> > On Fri, 7 Jul 2017, Juri Lelli wrote:
> > > How about SCHED_FLAG_SUGOV then?
> > 
> > I know sugo della carne, but what's sugo V?
> > 
> 
> Right.. can't really help not thinking about the same (especially close
> to lunch) :)
> 
> But the abbreviation stands for SchedUtil GOVernor (AFAIK). We already
> have a SUGOV_KTHREAD_PRIORITY (that I just noticed I need to remove BTW)
> in sched/cpufreq_schedutil.c.

SCHED_FLAG_CPUFREQ_WORKER comes to mind, but it's somewhat long.

Thanks,
Rafael
