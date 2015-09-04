From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Thu, 3 Sep 2015 20:59:10 -0700
Message-ID: <20150904035910.GL15099@codeaurora.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38731 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757232AbbIDD7M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 23:59:12 -0400
Content-Disposition: inline
In-Reply-To: <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 09/03, Lina Iyer wrote:
> @@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
>  
> -

Please remove noise.

>  	memset(&secondary_data, 0, sizeof(secondary_data));
>  	return ret;
>  }
> @@ -271,6 +271,16 @@ void __cpu_die(unsigned int cpu)
>  void __ref cpu_die(void)
>  {
>  	unsigned int cpu = smp_processor_id();
> +	struct device *cpu_dev;
> +
> +	/*
> +	 * We dont need the CPU device anymore.

s/dont/don't/

> +	 * Lets do this before IRQs are disabled to allow

s/Lets/Let's/

> +	 * runtime PM to suspend the domain as well.
> +	 */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
