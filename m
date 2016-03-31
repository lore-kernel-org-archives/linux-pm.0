From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 1/7][Resend] cpufreq: sched: Helpers to add and remove
 update_util hooks
Date: Thu, 31 Mar 2016 14:47:31 +0200
Message-ID: <20160331124731.GL3408@twins.programming.kicks-ass.net>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <4984400.nsZvPb32HI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4984400.nsZvPb32HI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 22, 2016 at 02:46:34AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the single helper for adding and removing cpufreq utilization
> update hooks, cpufreq_set_update_util_data(), with a pair of helpers,
> cpufreq_add_update_util_hook() and cpufreq_remove_update_util_hook(),
> and modify the users of cpufreq_set_update_util_data() accordingly.
> 
> With the new helpers, the code using them doesn't need to worry
> about the internals of struct update_util_data and in particular
> it doesn't need to worry about populating the func field in it
> properly upfront.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> No changes since v4 (this patch appeared then).
> 
> ---
>  drivers/cpufreq/cpufreq_governor.c |   76 ++++++++++++++++++-------------------
>  drivers/cpufreq/intel_pstate.c     |    8 +--
>  include/linux/sched.h              |    5 +-
>  kernel/sched/cpufreq.c             |   48 ++++++++++++++++++-----
>  4 files changed, 83 insertions(+), 54 deletions(-)
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
