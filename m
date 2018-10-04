From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v7 05/14] sched: Introduce a sched_feat for Energy Aware
 Scheduling
Date: Thu, 4 Oct 2018 10:57:04 +0100
Message-ID: <20181004095701.j5zt5guetxswdbi7@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-6-quentin.perret@arm.com>
 <20181002123416.GA3439@hirez.programming.kicks-ass.net>
 <20181002130818.fciw7cmlwggymxrz@queper01-lin>
 <20181003162435.GA19252@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003162435.GA19252@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 Oct 2018 at 18:24:35 (+0200), Peter Zijlstra wrote:
> Yeah, sysctl, see for example: sysctl.kernel.numa_balancing and the
> sched_numa_balancing static_key that goes with it.

OK, that works for me.

> I would default enable EAS if the EM is there and valid, but allow
> people to disable it.

Right, that'd be much nicer than the sched_feat off by default, I
agree. I'll see what I can do :-)

Thanks,
Quentin
