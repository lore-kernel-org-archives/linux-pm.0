From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/5] thermal: add trace events to the power allocator governor
Date: Wed, 15 Mar 2017 09:56:39 +0530
Message-ID: <CAOh2x==TDQrs3iNX6ZkSBWv+HRS3BoJqoZuyWpwsXGT6pCrK-w@mail.gmail.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com> <1425316643-31991-3-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33629 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdCOE0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 00:26:41 -0400
In-Reply-To: <1425316643-31991-3-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <punit.agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

Hi Javi,

Sorry for picking up an old thread, but i had a question for you.

On Mon, Mar 2, 2015 at 10:47 PM, Javi Merino <javi.merino@arm.com> wrote:
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c

> @@ -588,12 +590,20 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>                                        u32 *power)
>  {
>         unsigned long freq;
> -       int cpu, ret;
> +       int i = 0, cpu, ret;
>         u32 static_power, dynamic_power, total_load = 0;
>         struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
> +       u32 *load_cpu = NULL;
>
>         freq = cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
>
> +       if (trace_thermal_power_cpu_get_power_enabled()) {

You allocated load_cpu if cpu_get_power trace is enabled.

> +               u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
> +
> +               load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> +                                       GFP_KERNEL);
> +       }
> +
>         for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
>                 u32 load;
>
> @@ -603,14 +613,29 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>                         load = 0;
>
>                 total_load += load;
> +               if (trace_thermal_power_cpu_limit_enabled() && load_cpu)

But you store values to it only if cpu_limit trace is also enabled,
otherwise it is all zeros.

Why?
