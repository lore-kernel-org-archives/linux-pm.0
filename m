From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Use CONFIG_CPU_FREQ_DEFAULT_* to set initial
 policy for setpolicy drivers
Date: Fri, 20 Dec 2013 10:40:53 +0530
Message-ID: <CAKohpok9zqsZPdph6bK7jBnBYD4uEEPXfWm8ptjp7YK645S61g@mail.gmail.com>
References: <20131219225050.E82C91FF9@prod-mail-relay06.akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41576 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab3LTFKy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 00:10:54 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so2274452oag.26
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2013 21:10:53 -0800 (PST)
In-Reply-To: <20131219225050.E82C91FF9@prod-mail-relay06.akamai.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>

On 20 December 2013 04:20, Jason Baron <jbaron@akamai.com> wrote:
> When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
> intel_pstate driver, the desired default policy is not properly set. For
> example, setting 'CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE' ended up with the
> 'powersave' policy being set.
>
> Fix by configuring the correct default policy, if either 'powersave' or
> 'performance' are requested. Otherwise, fallback to what the driver originally
> set via its 'init' routine.
>
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
>
> v2: simplify logic
>
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 02d534d..42e1ea4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -828,6 +828,12 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
>         int ret = 0;
>
>         memcpy(&new_policy, policy, sizeof(*policy));
> +
> +       /* Use the default policy if its valid. */
> +       if (cpufreq_driver->setpolicy)
> +               cpufreq_parse_governor(policy->governor->name,
> +                                       &new_policy.policy, NULL);
> +
>         /* assure that the starting sequence is run in cpufreq_set_policy */
>         policy->governor = NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
