From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v2 10/10] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 4 Mar 2016 11:26:39 +0000
Message-ID: <20160304112639.GD4061@e106622-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <4627718.FT18d2LR5p@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4627718.FT18d2LR5p@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 04/03/16 04:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new cpufreq scaling governor, called "schedutil", that uses
> scheduler-provided CPU utilization information as input for making
> its decisions.
> 
> Doing that is possible after commit fe7034338ba0 (cpufreq: Add
> mechanism for registering utilization update callbacks) that
> introduced cpufreq_update_util() called by the scheduler on
> utilization changes (from CFS) and RT/DL task status updates.
> In particular, CPU frequency scaling decisions may be based on
> the the utilization data passed to cpufreq_update_util() by CFS.
> 
> The new governor is relatively simple.
> 
> The frequency selection formula used by it is
> 
> 	next_freq = util * max_freq / max
> 
> where util and max are the utilization and CPU capacity coming from CFS.
> 

The formula looks better to me now. However, problem is that, if you
have freq. invariance, util will slowly saturate to the current
capacity. So, we won't trigger OPP changes for a task that for example
starts light and then becomes big.

This is the same problem we faced with schedfreq. The current solution
there is to use a margin for calculating a threshold (80% of current
capacity ATM). Once util goes above that threshold we trigger an OPP
change.  Current policy is pretty aggressive, we go to max_f and then
adapt to the "real" util during successive enqueues. This was also
tought to cope with the fact that PELT seems slow to react to abrupt
changes in tasks behaviour.

I'm not saying this is the definitive solution, but I fear something
along this line is needed when you add freq invariance in the mix.

Best,

- Juri
