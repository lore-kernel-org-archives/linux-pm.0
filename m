From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Ignore turbo active ratio in HWP
Date: Sun, 12 Aug 2018 13:20:58 +0200
Message-ID: <7876484.jIFljIylbc@aspire.rjw.lan>
References: <20180802002606.42766-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802002606.42766-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, August 2, 2018 2:26:06 AM CEST Srinivas Pandruvada wrote:
> When HWP is active turbo active ratio is not used, so we should allow
> policy max frequency above turbo activation ratio to be set. When HWP is
> not active, then any policy max frequency above turbo activation ratio
> can result upto max one-core turbo frequency.
> 
> This fix helps better thermal control in turbo region when other methods
> like "Running Average Power Limit" is not available to use.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index efb015a5f7ac..32c10e69241e 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2020,7 +2020,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
>  					 struct cpudata *cpu)
>  {
> -	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
> +	if (!hwp_active &&
> +	    cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
>  	    policy->max < policy->cpuinfo.max_freq &&
>  	    policy->max > cpu->pstate.max_freq) {
>  		pr_debug("policy->max > max non turbo frequency\n");
> 

Applied, thanks!
