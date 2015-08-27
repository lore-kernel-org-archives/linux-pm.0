From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Remove usage of devm functions
Date: Thu, 27 Aug 2015 09:59:17 +0100
Message-ID: <20150827085916.GA5653@e104805>
References: <20150819062219.GA10032@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:52683 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750952AbbH0I7W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 04:59:22 -0400
Content-Disposition: inline
In-Reply-To: <20150819062219.GA10032@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 19, 2015 at 07:22:19AM +0100, Vaishali Thakkar wrote:
> In the function cpufreq_get_requested_power, the memory allocated
> for load_cpu is live within the function only. And after the
> allocation it is immediately freed with devm_kfree. There is no
> need to allocate memory for load_cpu with devm function so replace
> devm_kcalloc with kcalloc and devm_kfree with kfree.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Acked-by: Javi Merino <javi.merino@arm.com>

> ---
> This patch is having one checkpatch.pl warning which suggests that
> kfree(NULL) is safe. But I think leaving code with if is nice
> because it reflects the fact that kcalloc was under an if. So, I
> have ignored checkpatch. If maintainer wants me to go for changing
> things, I am fine with it too.

I wouldn't have minded changing the

if (load_cpu)
	kfree(load_cpu)

to just "kfree(load_cpu)" but I don't have a strong preference.  I'm
also happy with the patch as it is.

Cheers,
Javi

> ---
>  drivers/thermal/cpu_cooling.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 620dcd4..babf8b3 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -584,8 +584,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  	if (trace_thermal_power_cpu_get_power_enabled()) {
>  		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
>  
> -		load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> -					GFP_KERNEL);
> +		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
>  	}
>  
>  	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
> @@ -609,7 +608,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
>  	if (ret) {
>  		if (load_cpu)
> -			devm_kfree(&cdev->device, load_cpu);
> +			kfree(load_cpu);
>  		return ret;
>  	}
>  
> @@ -618,7 +617,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  			&cpufreq_device->allowed_cpus,
>  			freq, load_cpu, i, dynamic_power, static_power);
>  
> -		devm_kfree(&cdev->device, load_cpu);
> +		kfree(load_cpu);
>  	}
>  
>  	*power = static_power + dynamic_power;
