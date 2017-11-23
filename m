From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] cpufreq: Fix governor module removal race
Date: Thu, 23 Nov 2017 09:31:17 +0530
Message-ID: <20171123040117.GE4084@vireshk-i7>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
 <2007526.uAUpsoPmOG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2007526.uAUpsoPmOG@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 23-11-17, 01:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is possible to remove a cpufreq governor module after
> cpufreq_parse_governor() has returned success in
> store_scaling_governor() and before cpufreq_set_policy()
> acquires a reference to it, because the governor list is
> not protected during that period and nothing prevents the
> governor from being unregistered then.  The pointer to the
> governor structure coming from cpufreq_parse_governor() may
> become stale as a result of that.
> 
> Prevent that from happening by acquiring an extra reference
> to the governor module temporarily in cpufreq_parse_governor(),
> under cpufreq_governor_mutex, and dropping it in
> store_scaling_governor(), when cpufreq_set_policy() returns.
> 
> Note that the second cpufreq_parse_governor() call site is fine,
> because it only cares about the policy member of new_policy.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -607,11 +607,13 @@ static int cpufreq_parse_governor(char *
>  	if (cpufreq_driver->setpolicy) {
>  		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
>  			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> +			policy->governor = NULL;
>  			return 0;
>  		}
>  
>  		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
>  			policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +			policy->governor = NULL;

Why are the above two changes required? policy->governor should always be NULL
for setpolicy drivers anyway.

-- 
viresh
