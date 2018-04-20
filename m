From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Fri, 20 Apr 2018 15:42:45 +0100
Message-ID: <20180420144245.GB14391@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180418121547.GC15682@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180418121547.GC15682@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Leo,

On Wednesday 18 Apr 2018 at 20:15:47 (+0800), Leo Yan wrote:
> Sorry I introduce mess at here to spread my questions in several
> replying, later will try to ask questions in one replying.  Below are
> more questions which it's good to bring up:
> 
> The code for energy computation is quite neat and simple, but I think
> the energy computation mixes two concepts for CPU util: one concept is
> the estimated CPU util which is used to select CPU OPP in schedutil,
> another concept is the raw CPU util according to CPU real running time;
> for example, cpu_util_next() predicts CPU util but this value might be
> much higher than cpu_util(), especially after enabled UTIL_EST feature
> (I have shallow understanding for UTIL_EST so correct me as needed);

I'm not not sure to understand what you mean by higher than cpu_util()
here ... In which case would that happen ?

cpu_util_next() is basically used to figure out what will be the
cpu_util() of CPU A after task p has been enqueued on CPU B (no matter
what A and B are).

> but this patch simply computes CPU capacity and energy with the single
> one CPU utilization value (and it will be an inflated value afte enable
> UTIL_EST).  Is this purposed for simple implementation?
> 
> IMHO, cpu_util_next() can be used to predict CPU capacity, on the other
> hand, should we use the CPU util without UTIL_EST capping for 'sum_util',
> this can be more reasonable to reflect the CPU utilization?

Why would a decayed utilisation be a better estimate of the time that
a task is going to spend on a CPU ?

> 
> Furthermore, if we consider RT thread is running on CPU and connect with
> 'schedutil' governor, the CPU will run at maximum frequency, but we
> cannot say the CPU has 100% utilization.  The RT thread case is not
> handled in this patch.

Right, we don't account for RT tasks in the OPP prediction for now.
Vincent's patches to have a util_avg for RT runqueues could help us
do that I suppose ...

Thanks !
Quentin
