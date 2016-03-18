From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v6 7/7][Update] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 18 Mar 2016 12:34:09 +0000
Message-ID: <20160318123409.GA900@e105326-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <4088601.C2vItRYpQn@vostro.rjw.lan>
 <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <1614814.usHvZ58O6A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1614814.usHvZ58O6A@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael, all,
I have (yet another) consideration regarding the definition of the
margin for the frequency selection.

On 17-Mar 17:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: schedutil: New governor based on scheduler utilization data
> 
> Add a new cpufreq scaling governor, called "schedutil", that uses
> scheduler-provided CPU utilization information as input for making
> its decisions.
> 
> Doing that is possible after commit 34e2c555f3e1 (cpufreq: Add
> mechanism for registering utilization update callbacks) that
> introduced cpufreq_update_util() called by the scheduler on
> utilization changes (from CFS) and RT/DL task status updates.
> In particular, CPU frequency scaling decisions may be based on
> the the utilization data passed to cpufreq_update_util() by CFS.
> 
> The new governor is relatively simple.
> 
> The frequency selection formula used by it depends on whether or not
> the utilization is frequency-invariant.  In the frequency-invariant
> case the new CPU frequency is given by
> 
> 	next_freq = 1.25 * max_freq * util / max
> 
> where util and max are the last two arguments of cpufreq_update_util().
> In turn, if util is not frequency-invariant, the maximum frequency in
> the above formula is replaced with the current frequency of the CPU:
> 
> 	next_freq = 1.25 * curr_freq * util / max
> 
> The coefficient 1.25 corresponds to the frequency tipping point at
> (util / max) = 0.8.


In both this formulas the OPP jump is driven by a margin which is
effectively proportional to the capacity of the current OPP.
For example, if we consider a simple system with this set of OPPs:

  [200,400,600,800,1000) MHz

and we apply the formula for the frequency-invariant case, we get:

   util/max    min_opp    min_util   margin
        1.0       1000        0.80      20%
        0.8        800        0.64      16%
        0.6        600        0.48      12%
        0.4        400        0.32       8%
        0.2        200        0.16       4%

Where:
- min_opp: is the minimum OPP which can satisfy (util/max) capacity
  request
- min_util: is the minimum utilization value which effectively trigger
  a switch to the upper OPP
- margin: is the effective capacity margin to remain at min_opp

This means that when running at the lower OPP we can build up to 16%
utilization (i.e. 4% less than the capacity of the min_opp) before
jumping to the next OPP. But, for example, switching at the 800MHz
OPP we need to build up just 4% utilization (i.e. 16% less than the
capacity of that OPP) to jump up.

This is a really simple example, with OPPs that are equally distributed.
However, the question is: does is really make sense to have different
effective margins for different starting OPPs?

AFAIU, this solution is biasing the frequency selection to higher
OPPs.  The bigger the utilization of a CPU the more we are likely to
run at an higher the minimum OPP.
The advantage is a reduce time to reach the highest OPP, which can be
beneficial for performance oriented workload. The disadvantage is
instead a quite likely reduction of residencies on mid-range OPPs.

We should consider also that, at least in its current implementation,
PELT "builds up" slower when running at lower OPPs, which further
amplify this unbalance on OPP residencies.

IMO, biasing the selection of an OPP over another is something which
sound more like a "policy" than a "mechanism". Since here the goal
should be to provide just a mechanism, perhaps a different approach
can be evaluated.

Have we ever considered to use a "constant margin" for each OPP?

The value of such a margin can still be defined as a (configurable)
percentage of the max (or min) OPP. But once defined, the same
margin can be used to decide whenever to switch to the next OPP.

In the previous example, considering a 5% margin wrt the max capacity,
these are the new margins:

   util/max    min_opp    min_util   margin
        1.0       1000        0.95       5%
        0.8        800        0.75       5%
        0.6        600        0.55       5%
        0.4        400        0.35       5%
        0.2        200        0.15       5%

That means that when running both at the lowest OPP or in a mid-range
one, we always need to build up the same amount of utilization before
switching to the next one.

What is the translation in residencies time? This is still affected by
the PELT behaviors when running at different OPPs but IMO it should
improve a bit the fairness on OPP selections.

Moreover, from an implementation standpoint, what is now a couple of
multiplications and comparison, can potentially be reduced to a single
comparison, e.g.

   next_freq = util > (curr_cap - margin)
               ?  curr_freq + 1
               :  curr_freq

where margin is pre-computed to be for example 51 (i.e. 5% of 1024) as
well as (curr_cap - margin), which can be cached at each OPP change.

-- 
#include <best/regards.h>

Patrick Bellasi
