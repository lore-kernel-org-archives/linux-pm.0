From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Mon, 21 Oct 2013 09:03:07 -0700
Message-ID: <5265503B.7000804@gmail.com>
References: <1382333227-28231-1-git-send-email-adrian.huang@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1382333227-28231-1-git-send-email-adrian.huang@hp.com>
Sender: cpufreq-owner@vger.kernel.org
To: Adrian Huang <adrian.huang@hp.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com
List-Id: linux-pm@vger.kernel.org

On 10/20/2013 10:27 PM, Adrian Huang wrote:
>   static int __init intel_pstate_init(void)
>   {
>   	int cpu, rc = 0;
> @@ -708,6 +779,15 @@ static int __init intel_pstate_init(void)
>   	if (no_load)
>   		return -ENODEV;
>
> +	if (!acpi_disabled) {
> +		/*
> +		 * Check if the platform has its own power management modes.
> +		 * If so, the pstate cpufreq driver will be ignored.
> +		 */
> +		if (intel_pstate_platform_pwr_mgmt_exists())
> +			return 0;

Please return -ENODEV here instead of 0

> +	}
> +
>   	id = x86_match_cpu(intel_pstate_cpu_ids);
>   	if (!id)
>   		return -ENODEV;
>

