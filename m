From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: Add a mechanism for registering utilization
 update callbacks
Date: Thu, 4 Feb 2016 09:01:44 +0530
Message-ID: <20160204033144.GR3469@vireshk>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <1895005.WdX4A2LmI5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1895005.WdX4A2LmI5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 29-01-16, 23:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a mechanism by which parts of the cpufreq subsystem
> ("setpolicy" drivers or the core) can register callbacks to be
> executed from cpufreq_update_util() which is invoked by the
> scheduler's update_load_avg() on CPU utilization changes.
> 
> This allows the "setpolicy" drivers to dispense with their timers
> and do all of the computations they need and frequency/voltage
> adjustments in the update_load_avg() code path, among other things.
> 
> The scheduler changes were suggested by Peter Zijlstra.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |    7 +++++++
>  include/linux/sched.h     |    2 ++
>  kernel/sched/fair.c       |   29 ++++++++++++++++++++++++++++-
>  4 files changed, 81 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
