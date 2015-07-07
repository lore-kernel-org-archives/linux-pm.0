From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] acpi-cpufreq.c: fix a memory leak in
 acpi_cpufreq_cpu_exit
Date: Tue, 7 Jul 2015 14:23:42 +0530
Message-ID: <20150707085342.GF14598@linux>
References: <559A2073.1000301@intel.com>
 <20150707065449.GD14598@linux>
 <559B8537.5010309@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33828 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbGGIxu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 04:53:50 -0400
Received: by pabvl15 with SMTP id vl15so109981472pab.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 01:53:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559B8537.5010309@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On 07-07-15, 15:52, Pan Xinhui wrote:
> I have latest codes.
> codes in cpufreq.c are below.
> 1436     down_write(&policy->rwsem);
> 1437     cpumask_clear_cpu(cpu, policy->cpus);
> 1438 
> 1439     if (policy_is_inactive(policy)) {
> 1440         if (has_target())
> 1441             strncpy(policy->last_governor, policy->governor->name,
> 1442                 CPUFREQ_NAME_LEN);
> 1443     } else if (cpu == policy->cpu) {
> 1444         /* Nominate new CPU */
> 1445         policy->cpu = cpumask_any(policy->cpus);
> 1446     }
> 1447     up_write(&policy->rwsem);

Sigh. Too bad. So what has changed is that the sysfs directory is
allocated to policy->cpu during init and never changed. But
policy->cpu can surely change.

Sorry for that.

> back to my previous patch, you suggest me to use policy->driver_data to *store* data and don't need use per_cpu anymore.
> codes in acpi-cpufreq.c are below.
>  365 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  366 {
>  367     struct acpi_cpufreq_data *data = per_cpu(acfreq_data, cpu);
>  368     unsigned int freq;
>  369     unsigned int cached_freq;
>  
> we get *data* through per_cpu for now, as the parameter is cpu only.
> If we store *data* in policy->driver_data, we need call
> struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu) to get policy.
> We do a full codes review, and find there should be deadlock if we doing so.

Why?

> But as cpufreq code offers
> 238 /* Only for cpufreq core internal use */
> 239 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> 
> I have a small question,if we can use *cpufreq_cpu_get_raw* in ->get callback, which is already lock hold,
> But the comment(line 238) is... hmm.

That is more internal to the core. Better don't use it.

> thanks for your kind reply. any advices or comments are welcome.

Anyway, your patch is far from complete. You have just fixed a single
place where per-cpu data is accessed with policy->cpu. What about rest
of the code? Like target() :)

--
viresh
