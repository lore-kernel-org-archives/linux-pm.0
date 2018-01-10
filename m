From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: scpi: remove arm_big_little dependency
Date: Wed, 10 Jan 2018 09:49:05 +0530
Message-ID: <20180110041905.GC3335@vireshk-i7>
References: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
 <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45734 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965353AbeAJETI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 23:19:08 -0500
Received: by mail-pl0-f67.google.com with SMTP id o2so6548460plk.12
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 20:19:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 09-01-18, 16:49, Sudeep Holla wrote:
> +static int
> +scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  {
> -	return scpi_ops->get_transition_latency(cpu_dev);
> +	int cpu, domain, tdomain;
> +	struct device *tcpu_dev;
> +
> +	domain = scpi_ops->device_domain_id(cpu_dev);
> +	if (domain < 0)
> +		return domain;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu == cpu_dev->id)
> +			continue;
> +
> +		tcpu_dev = get_cpu_device(cpu);
> +		if (!tcpu_dev)
> +			continue;
> +
> +		tdomain = scpi_ops->device_domain_id(tcpu_dev);
> +		if (tdomain == domain)
> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +	return 0;
>  }

So this is the main thing you want to achieve ? i.e. get the
policy->cpus from scpi_ops, right ?

Why can't we update .init_opp_table() to include policy as a parameter
and let individual stub drivers update policy->cpus then ?

-- 
viresh
