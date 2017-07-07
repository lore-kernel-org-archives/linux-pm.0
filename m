From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 11:53:16 +0100
Message-ID: <20170707105316.whutk3h6x2h6xvyt@e106622-lin>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-4-juri.lelli@arm.com>
 <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com>
 <20170707104341.vrx4gm2bgoaaixwf@e106622-lin>
 <alpine.DEB.2.20.1707071244520.1871@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdGGKxX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 06:53:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1707071244520.1871@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>, Rafael J .

On 07/07/17 12:46, Thomas Gleixner wrote:
> On Fri, 7 Jul 2017, Juri Lelli wrote:
> > How about SCHED_FLAG_SUGOV then?
> 
> I know sugo della carne, but what's sugo V?
> 

Right.. can't really help not thinking about the same (especially close
to lunch) :)

But the abbreviation stands for SchedUtil GOVernor (AFAIK). We already
have a SUGOV_KTHREAD_PRIORITY (that I just noticed I need to remove BTW)
in sched/cpufreq_schedutil.c.

Thanks,

- Juri
