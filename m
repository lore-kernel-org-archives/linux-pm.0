From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 17:58:05 -0400
Message-ID: <20170707175805.6bd8f34d@gandalf.local.home>
References: <20170705085905.6558-1-juri.lelli@arm.com>
        <alpine.DEB.2.20.1707071244520.1871@nanos>
        <20170707105316.whutk3h6x2h6xvyt@e106622-lin>
        <4582085.aKtjXTl7qR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbdGGV6K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 17:58:10 -0400
In-Reply-To: <4582085.aKtjXTl7qR@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes <joelaf@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>, Rafael J . Wysocki

On Fri, 07 Jul 2017 15:11:45 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, July 07, 2017 11:53:16 AM Juri Lelli wrote:
> > On 07/07/17 12:46, Thomas Gleixner wrote:  
> > > On Fri, 7 Jul 2017, Juri Lelli wrote:  
> > > > How about SCHED_FLAG_SUGOV then?  
> > > 
> > > I know sugo della carne, but what's sugo V?
> > >   
> > 
> > Right.. can't really help not thinking about the same (especially close
> > to lunch) :)
> > 
> > But the abbreviation stands for SchedUtil GOVernor (AFAIK). We already
> > have a SUGOV_KTHREAD_PRIORITY (that I just noticed I need to remove BTW)
> > in sched/cpufreq_schedutil.c.  
> 
> SCHED_FLAG_CPUFREQ_WORKER comes to mind, but it's somewhat long.
> 

It is rather long. Although I actually hate the SUGOV, it is easily
grepable. Just comment what it stands for. We can always change it
later.

-- Steve
