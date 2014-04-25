From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC] A new CPU load metric for power-efficient scheduler: CPU ConCurrency
Date: Fri, 25 Apr 2014 10:00:02 +0200
Message-ID: <CAKfTPtDUdmf3gpTJAqf49Hddpv2h4XQffz1OLpuhjuRpKOU7jg@mail.gmail.com>
References: <20140424193004.GA2467@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140424193004.GA2467@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuyang Du <yuyang.du@intel.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, arjan.van.de.ven@intel.com, Len Brown <len.brown@intel.com>, rafael.j.wysocki@intel.com, alan.cox@intel.com, "Gross, Mark" <mark.gross@intel.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 24 April 2014 21:30, Yuyang Du <yuyang.du@intel.com> wrote:
> Hi Ingo, PeterZ, and others,
>
> The current scheduler's load balancing is completely work-conserving. In some
> workload, generally low CPU utilization but immersed with CPU bursts of
> transient tasks, migrating task to engage all available CPUs for
> work-conserving can lead to significant overhead: cache locality loss,
> idle/active HW state transitional latency and power, shallower idle state,
> etc, which are both power and performance inefficient especially for today's
> low power processors in mobile.
>
> This RFC introduces a sense of idleness-conserving into work-conserving (by
> all means, we really don't want to be overwhelming in only one way). But to
> what extent the idleness-conserving should be, bearing in mind that we don't
> want to sacrifice performance? We first need a load/idleness indicator to that
> end.
>
> Thanks to CFS's "model an ideal, precise multi-tasking CPU", tasks can be seen
> as concurrently running (the tasks in the runqueue). So it is natural to use
> task concurrency as load indicator. Having said that, we do two things:
>
> 1)      Divide continuous time into periods of time, and average task concurrency
> in period, for tolerating the transient bursts:
> a = sum(concurrency * time) / period
> 2)      Exponentially decay past periods, and synthesize them all, for hysteresis
> to load drops or resilience to load rises (let f be decaying factor, and a_x
> the xth period average since period 0):
> s = a_n + f^1 * a_n-1 + f^2 * a_n-2 +, .....,+ f^(n-1) * a_1 + f^n * a_0

In the original version of entity load tracking patchset, there was a
usage_avg_sum field that was counting the time the task was really
running on the CPU. By combining this (disappeared ) field with the
runnable_avg_sum, you should have similar concurrency value but with
the current load tracking mechanism (instead of creating new one).

Vincent

>
> We name this load indicator as CPU ConCurrency (CC): task concurrency
> determines how many CPUs are needed to be running concurrently.
>
> To track CC, we intercept the scheduler in 1) enqueue, 2) dequeue, 3)
> scheduler tick, and 4) enter/exit idle.
>
> By CC, we implemented a Workload Consolidation patch on two Intel mobile
> platforms (a quad-core composed of two dual-core modules): contain load and load
> balancing in the first dual-core when aggregated CC low, and if not in the
> full quad-core. Results show that we got power savings and no substantial
> performance regression (even gains for some).
>
> Thanks,
> Yuyang
