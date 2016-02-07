From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3 v5] cpufreq: governor: Replace timers with
 utilization update callbacks
Date: Sun, 7 Feb 2016 21:06:30 +0530
Message-ID: <20160207153630.GE3808@vireshk>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <1486401.1RcnnVKZNP@vostro.rjw.lan>
 <2848076.UWJmIl2O1K@vostro.rjw.lan>
 <2448026.UXsVxjJmrX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2448026.UXsVxjJmrX@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 07-02-16, 15:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using a per-CPU deferrable timer for queuing up governor
> work items, register a utilization update callback that will be
> invoked from the scheduler on utilization changes.
> 
> The sampling rate is still the same as what was used for the
> deferrable timers and the added irq_work overhead should be offset by
> the eliminated timers overhead, so in theory the functional impact of
> this patch should not be significant.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Changes from v4:
> - Moved init_irq_work() to alloc_common_dbs_info() so it is done along with
>   the INIT_WORK() on the main work structure (which seems more logical to me).
> - Added the ACK from Viresh (in the hope that it still applied).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
