From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/6] cpufreq: Reduce cpufreq_update_util() overhead a bit
Date: Thu, 3 Mar 2016 11:18:38 +0530
Message-ID: <20160303054838.GH2891@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <3575770.L1lplNLqVv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3575770.L1lplNLqVv@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 02-03-16, 03:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the observation that cpufreq_update_util() is only called
> by the scheduler with rq->lock held, so the callers of
> cpufreq_set_update_util_data() can use synchronize_sched()
> instead of synchronize_rcu() to wait for cpufreq_update_util()
> to complete.  Moreover, if they are updated to do that,
> rcu_read_(un)lock() calls in cpufreq_update_util() might be
> replaced with rcu_read_(un)lock_sched(), respectively, but
> those aren't really necessary, because the scheduler calls
> that function from RCU-sched read-side critical sections
> already.
> 
> In addition to that, if cpufreq_set_update_util_data() checks
> the func field in the struct update_util_data before setting
> the per-CPU pointer to it, the data->func check may be dropped
> from cpufreq_update_util() as well.
> 
> Make the above changes to reduce the overhead from
> cpufreq_update_util() in the scheduler paths invoking it
> and to make the cleanup after removing its callbacks less
> heavy-weight somewhat.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Supersedes https://patchwork.kernel.org/patch/8443191/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
