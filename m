From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 18 Apr 2018 12:06:35 +0100
Message-ID: <20180418110635.GA6783@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180417152213.GC18509@leoy-ThinkPad-X240s>
 <20180418081339.GB3943@e108498-lin.cambridge.arm.com>
 <20180418091928.GA15682@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180418091928.GA15682@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 18 Apr 2018 at 17:19:28 (+0800), Leo Yan wrote:
> > > BTW, CPU utilization is decayed value and task_util() is not decayed
> > > value, so 'util - task_util(p)' calculates a smaller value than the
> > > prev CPU pure utilization, right?
> > 
> > task_util() is the raw PELT signal, without UTIL_EST, so I think it's
> > fine to do `util - task_util()`.
> > 
> > > 
> > > Another question is can we reuse the function cpu_util_wake() and
> > > just compenstate task util for dst cpu?
> > 
> > Well it's not that simple. cpu_util_wake() will give you the max between
> > the util_avg and the util_est value, so which task_util() should you add
> > to it ? The util_avg or the uti_est value ?
> 
> If feature 'UTIL_EST' is enabled, then add task's util_est; otherwise
> add task util_avg value.

I don't think this is correct. If UTIL_EST is enabled, cpu_util_wake()
will return the max between the util_avg and the util_est. When you call
it, you don't know what you get. Adding the _task_util_est() to
cpu_util_wake() is wrong if cpu_util_avg > cpu_util_est for example.

> 
> I think cpu_util_wake() has similiar logic with here, it merely returns
> CPU level util; but here needs to accumulate CPU level util + task level
> util.  So seems to me, the logic is:
> 
>   cpu_util_wake() + task_util_wake()

I'm not sure to get that one ... What is task_util_wake() ?

Thanks,
Quentin
