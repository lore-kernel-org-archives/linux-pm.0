From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Tue, 25 Jul 2017 17:54:32 -0700
Message-ID: <65601d57-81fb-d8b8-195c-6ec0a429d4c3@codeaurora.org>
References: <20170724160342.1879-1-waldemarx.rymarkiewicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdGZAye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 20:54:34 -0400
In-Reply-To: <20170724160342.1879-1-waldemarx.rymarkiewicz@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org
Cc: waldemar.rymarkiewicz@gmail.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 07/24/2017 09:03 AM, Waldemar Rymarkiewicz wrote:
> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
> exist. This can happen on platforms where not all possible CPUs are
> available at start up ie. hotplugged out. Cpu device is not registered in
> the system so we are not able to check struct device to set the sharing
> CPUs bitmask properly.
>
> Example (real use case):
> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
> due to the fact there is no struct device for cpu1 (remains offline at
> bootup).
>
> To solve the bug, stop using device struct to check device_node. Instead
> get cpu device_node directly from device tree with of_get_cpu_node().
>
> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

One minor nit, but it's fine to change later as well.

> @@ -593,18 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  		if (cpu == cpu_dev->id)
>  			continue;
>  
> -		tcpu_dev = get_cpu_device(cpu);
> -		if (!tcpu_dev) {
> -			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
> +		cpu_np = of_get_cpu_node(cpu, NULL);
> +		if (!cpu_np) {
> +			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
>  				__func__, cpu);
> -			ret = -ENODEV;
> +			ret = -ENOENT;
>  			goto put_cpu_node;
>  		}
>  
>  		/* Get OPP descriptor node */
> -		tmp_np = dev_pm_opp_of_get_opp_desc_node(tcpu_dev);
> +		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
>  		if (!tmp_np) {
> -			dev_err(tcpu_dev, "%s: Couldn't find opp node.\n",
> +			dev_err(cpu_dev, "%s: Couldn't find opp node.\n",

I would remove the full-stop. And also use %pOF with cpu_np and pr_err()
instead of dev_err() here so that we print out the node that's missing
the OPP node pointer.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
