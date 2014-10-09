From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [RFC PATCH v2 2/3] CPPC as a PID controller backend
Date: Thu, 09 Oct 2014 09:22:45 -0700
Message-ID: <5436B655.6090403@gmail.com>
References: <1412799064-2339-1-git-send-email-ashwin.chaugule@linaro.org> <1412799064-2339-3-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43890 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbaJIQWt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:22:49 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so59852pab.9
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 09:22:48 -0700 (PDT)
In-Reply-To: <1412799064-2339-3-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, viresh.kumar@linaro.org
Cc: dirk.brandewie@gmail.com, rwells@codeaurora.org, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, linda.knippers@hp.com

On 10/08/2014 01:11 PM, Ashwin Chaugule wrote:

> +static int __init acpi_pid_init(void)
> +{
> +	int cpu, rc = 0;
> +

You should add a check here to not bind to Intel CPU. The CPPC interface
was created to provided an ACPI interface to to hardware controlled P states
(HWP) described in Volume 3 section 14.4 of the Intel SDM.
intel_pstate will be enabling HWP by controlling the MSRs directly and
not using CPPC.

Adding this check will keep us from having to fight load order since
this driver and intel_pstate are at the same init level.

> +	rc = acpi_cppc_init();
> +
> +	if (rc)
> +		return -ENODEV;
> +
> +	pr_info("ACPI PID driver initializing.\n");
> +
> +	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
> +	if (!all_cpu_data)
> +		return -ENOMEM;
> +
> +	rc = cpufreq_register_driver(&acpi_pid_driver);
> +	if (rc)
> +		goto out;
> +
> +	acpi_pid_debug_expose_params();
> +	acpi_pid_sysfs_expose_params();
> +
> +	return rc;
> +out:
> +	get_online_cpus();
> +	for_each_online_cpu(cpu) {
> +		if (all_cpu_data[cpu]) {
> +			del_timer_sync(&all_cpu_data[cpu]->timer);
> +			kfree(all_cpu_data[cpu]);
> +		}
> +	}
> +
> +	put_online_cpus();
> +	vfree(all_cpu_data);
> +	return -ENODEV;
> +}
> +
> +late_initcall(acpi_pid_init);
>

