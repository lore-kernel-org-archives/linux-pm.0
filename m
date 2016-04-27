From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: st: enable selective initialization based on
 the platform
Date: Wed, 27 Apr 2016 17:17:22 +0530
Message-ID: <20160427114722.GO4225@vireshk-i7>
References: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33643 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbcD0Lr0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 07:47:26 -0400
Received: by mail-pa0-f41.google.com with SMTP id zm5so20442105pac.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 04:47:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 27-04-16, 12:40, Sudeep Holla wrote:
> The sti-cpufreq does unconditional registration of the cpufreq-dt driver
> which causes issue on an multi-platform build. For example, on Vexpress
> TC2 platform, we get the following error on boot:
> 
> cpu cpu0: OPP-v2 not supported
> cpu cpu0: Not doing voltage scaling
> cpu: dev_pm_opp_of_cpumask_add_table: couldn't find opp table
> 	for cpu:0, -19
> cpu cpu0: dev_pm_opp_get_max_volt_latency: Invalid regulator (-6)
> ...
> arm_big_little: bL_cpufreq_register: Failed registering platform driver:
> 		vexpress-spc, err: -17
> 
> The actual driver fails to initialise as cpufreq-dt is probed
> successfully, which is incorrect. This issue can happen to any platform
> not using cpufreq-dt in a multi-platform build.
> 
> This patch adds a check to do selective initialization of the driver.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Fixes: ab0ea257fc58 ("cpufreq: st: Provide runtime initialised driver for ST's platforms")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index a9c659f58974..5fce58712a97 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -259,6 +259,10 @@ static int sti_cpufreq_init(void)
>  {
>  	int ret;
>  
> +	if ((!of_machine_is_compatible("st,stih407-b2120")) &&
> +		(!of_machine_is_compatible("st,stih407")))

Isn't just testing this for stih407 enough? instead of two ?

> +		return -ENODEV;
> +
>  	ddata.cpu = get_cpu_device(0);
>  	if (!ddata.cpu) {
>  		dev_err(ddata.cpu, "Failed to get device for CPU0\n");
> -- 
> 1.9.1

-- 
viresh
