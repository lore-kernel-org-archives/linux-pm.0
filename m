From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle
 support
Date: Fri, 4 Apr 2014 18:00:30 -0500
Message-ID: <1396652430.32034.122.camel@snotra.buserror.net>
References: <1396341234-40515-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:8370
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752155AbaDDXA5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Apr 2014 19:00:57 -0400
In-Reply-To: <1396341234-40515-1-git-send-email-dongsheng.wang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: daniel.lezcano@linaro.org, rjw@sisk.pl, leoli@freescale.com, jason.jin@freescale.com, chenhui.zhao@freescale.com, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tue, 2014-04-01 at 16:33 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add cpuidle support for e500 family, using cpuidle framework to
> manage various low power modes. The new implementation will remain
> compatible with original idle method.
> 
> I have done test about power consumption and latency. Cpuidle framework
> will make CPU response time faster than original method, but power
> consumption is higher than original method.
> 
> Power consumption:
> The original method, power consumption is 10.51202 (W).
> The cpuidle framework, power consumption is 10.5311 (W).
> 
> Latency:
> The original method, avg latency is 6782 (us).
> The cpuidle framework, avg latency is 6482 (us).
> 
> Initially, this supports PW10, PW20 and subsequent patches will support
> DOZE/NAP and PH10, PH20.

Have you tried tuning the timebase bit for the original method, to match
what you're doing in cpuidle and/or for general optimization?

Do you get similar results for a variety of workloads?

> +static struct cpuidle_state pw_idle_states[] = {
> +	{
> +		.name = "pw10",
> +		.desc = "pw10",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = &pw10_enter
> +	},
> +
> +	{
> +		.name = "pw20",
> +		.desc = "pw20-core-idle",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 1,
> +		.target_residency = 50,
> +		.enter = &pw20_enter
> +	},
> +};

Where did exit_latency and target_residency come from?  It looks rather
different from the ~1ms delay before entering PW20 with the original
method.

Though, I'd have expected a shorter PW20 delay to have longer wake
latency, due to entering the lower power state more often...

> +static void replace_orig_idle(void *dummy)
> +{
> +	return;
> +}

Why?  If you're using this as some sort of barrier to ensure that all
CPUs have done something before continuing, explain that, along with why
it matters.

-Scott


