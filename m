From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Thu, 7 Mar 2019 12:23:44 +0100
Message-ID: <20190307112344.GC32477@hirez.programming.kicks-ass.net>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
 <20190305173746.p32xolcpueudlzwn@queper01-lin>
 <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
 <20190307110256.padefvq4e52ly3nm@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307110256.padefvq4e52ly3nm@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 07, 2019 at 11:02:58AM +0000, Quentin Perret wrote:
> Also on recent big little SoCs, the capacity ratio can be pretty high.
> You can get little CPUs with 300 of capacity or so. The arbitrary 128
> thing is basically gonna go near max freq in one step, although the CPUs
> actually 20 available OPPs or so. And I guess that's a shame.

Ah, but remember; with the latest patch the iowait_boost is scaled on
max. So in order to hit that 300, you first have to hit 1024.

+       boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
+       return max(boost, util);

So iowait_boost goes from 128 to 1024 in 4 wakeups (the first sets 128,
the next 3 get it to 1024), but the effective value is, given @max ==
300:

  128 -> 37
  256 -> 75
  512 -> 150
 1024 -> 300

so irrespective of the number of OPPs and their spread, it takes 4
wakeups to get to max.
