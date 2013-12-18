From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Wed, 18 Dec 2013 22:38:38 +0100
Message-ID: <1451068.r0h0sa1DaG@vostro.rjw.lan>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131218203102.9F9692036@prod-mail-relay06.akamai.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>
Cc: viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>, dirk.brandewie@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 18, 2013 08:31:02 PM Jason Baron wrote:
> When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
> 'intel_pstate' driver, I found that the default is not honored. For example,
> configure 'CONFIG_CPU_FREQ_GOV_PERFORMANCE', and then do:

intel_pstate doesn't use any cpufreq governors, so all of this is pointless
for that particular driver anyway.

Thanks!

> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> powersave
> 
> However, I can do:
> 
> echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> 
> and it takes properly.
> 
> Fix by setting the default governor, if its either 'powersave' or 'performance'.
> Otherwise, fall back to what the driver originally set via its 'init' routine.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 02d534d..931fa67 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -826,8 +826,19 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
>  	struct cpufreq_policy new_policy;
>  	int ret = 0;
> +	int init_policy;
>  
>  	memcpy(&new_policy, policy, sizeof(*policy));
> +
> +	/* honor the default governor policy, unless its invalid */
> +	if (cpufreq_driver->setpolicy) {
> +		init_policy = new_policy.policy;
> +		if (cpufreq_parse_governor(policy->governor->name,
> +				&new_policy.policy, &new_policy.governor)) {
> +			new_policy.policy = init_policy;
> +		}
> +	}
> +
>  	/* assure that the starting sequence is run in cpufreq_set_policy */
>  	policy->governor = NULL;
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
