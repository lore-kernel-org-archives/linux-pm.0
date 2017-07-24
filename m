From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after performance governor changes
Date: Mon, 24 Jul 2017 13:36:15 +0200
Message-ID: <7185077.O26hx51RqR@aspire.rjw.lan>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59812 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752513AbdGXLoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 07:44:13 -0400
In-Reply-To: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday, July 24, 2017 05:43:14 AM Huaisheng HS1 Ye wrote:
> After commit 82b4e03e01bc (intel_pstate: skip scheduler hook when
> in "performance" mode) Software P-state control modes couldn't get
> dynamic value during performance mode,

Please explain what you mean here.

I guess you carried out some tests and the results were not as expected,
so what was the test?

> and it still in last value from powersave mode, so clear its value to get
> same behavior as Hardware P-state to avoid confusion.

And please explain why it should be fixed the way you've done that.

> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 6cd5035..c675626 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2050,6 +2050,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  		 */
>  		intel_pstate_clear_update_util_hook(policy->cpu);
>  		intel_pstate_max_within_limits(cpu);
> +		cpu->sample.core_avg_perf = 0;
>  	} else {
>  		intel_pstate_set_update_util_hook(policy->cpu);
>  	}
> 
