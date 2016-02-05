From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 8/10] cpufreq: governor: Rename cpu_common_dbs_info to
 policy_dbs_info
Date: Fri, 5 Feb 2016 14:04:06 +0530
Message-ID: <20160205083406.GK21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2973464.jyrWv0qA55@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2973464.jyrWv0qA55@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 03:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The struct cpu_common_dbs_info structure represents the per-policy
> part of the governor data (for the ondemand and conservative
> governors), but its name doesn't reflect its purpose.
> 
> Rename it to struct policy_dbs_info and rename variables related to
> it accordingly.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |  120 ++++++++++++++++++-------------------
>  drivers/cpufreq/cpufreq_governor.h |    8 +-
>  drivers/cpufreq/cpufreq_ondemand.c |   32 ++++-----
>  3 files changed, 80 insertions(+), 80 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -132,7 +132,7 @@ static void *get_cpu_dbs_info_s(int cpu)
>   */
>  
>  /* Common to all CPUs of a policy */
> -struct cpu_common_dbs_info {
> +struct policy_dbs_info {
>  	struct cpufreq_policy *policy;
>  	/*
>  	 * Per policy mutex that serializes load evaluation from limit-change
> @@ -162,7 +162,7 @@ struct cpu_dbs_info {
>  	 */
>  	unsigned int prev_load;
>  	struct update_util_data update_util;
> -	struct cpu_common_dbs_info *shared;
> +	struct policy_dbs_info *shared;

You should replaced shared with policy_dbs here as well ? Apart from
that:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
