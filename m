From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 19 Aug 2015 17:27:56 +0530
Message-ID: <CAK-LDbKdORz5-3oBd7p4BcU+t3w9=u=aQv6LKQthiZPL-qi9bQ@mail.gmail.com>
References: <20150819062219.GA10032@localhost>
	<CAOh2x==kSnXWZMhrEcRyiVc-5iixecQki5-7ZC-ajes-D48-sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33896 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbHSL55 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 07:57:57 -0400
In-Reply-To: <CAOh2x==kSnXWZMhrEcRyiVc-5iixecQki5-7ZC-ajes-D48-sA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 19, 2015 at 1:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Wed, Aug 19, 2015 at 11:52 AM, Vaishali Thakkar
> <vthakkar1994@gmail.com> wrote:
>> In the function cpufreq_get_requested_power, the memory allocated
>> for load_cpu is live within the function only. And after the
>> allocation it is immediately freed with devm_kfree. There is no
>> need to allocate memory for load_cpu with devm function so replace
>> devm_kcalloc with kcalloc and devm_kfree with kfree.
>>
>> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>> ---
>> This patch is having one checkpatch.pl warning which suggests that
>> kfree(NULL) is safe. But I think leaving code with if is nice
>> because it reflects the fact that kcalloc was under an if. So, I
>> have ignored checkpatch. If maintainer wants me to go for changing
>> things, I am fine with it too.
>
> I will rather ask you to do this:
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 620dcd405ff6..a04055ea5d94 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -584,8 +584,8 @@ static int cpufreq_get_requested_power(struct
> thermal_cooling_device *cdev,
>         if (trace_thermal_power_cpu_get_power_enabled()) {
>                 u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
>
> -               load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> -                                       GFP_KERNEL);
> +               load_cpu = kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> +                                  GFP_KERNEL);
>         }

Sorry. I forgot to ask you one more thing. devm_kcalloc takes one more
argument then
kcalloc. So, the change I did is correct I guess. And I'm not sure why
you suggested this
change? I assume you just want me to correct in my patch for last
argument. But that line
also comes under 80 characters.

>         for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
> @@ -607,22 +607,20 @@ static int cpufreq_get_requested_power(struct
> thermal_cooling_device *cdev,
>
>         dynamic_power = get_dynamic_power(cpufreq_device, freq);
>         ret = get_static_power(cpufreq_device, tz, freq, &static_power);
> -       if (ret) {
> -               if (load_cpu)
> -                       devm_kfree(&cdev->device, load_cpu);
> -               return ret;
> -       }
> +       if (ret)
> +               goto free;
>
> -       if (load_cpu) {
> +       if (load_cpu)
>                 trace_thermal_power_cpu_get_power(
>                         &cpufreq_device->allowed_cpus,
>                         freq, load_cpu, i, dynamic_power, static_power);
>
> -               devm_kfree(&cdev->device, load_cpu);
> -       }
> -
>         *power = static_power + dynamic_power;
> -       return 0;
> +
> +free:
> +       kfree(&cdev->device, load_cpu);
> +
> +       return ret;
>  }



-- 
Vaishali
