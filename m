From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Don't use cpu removed during cpufreq_driver_unregister
Date: Fri, 4 Jan 2013 10:49:10 +0530
Message-ID: <CAKohpo=Z=nA2Mr23ior8c0Qmt75+bOVLvZwNdc7OXq-+rH1dWQ@mail.gmail.com>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
	<1fe21314c2e17585e22c546e2cac12544f8f9733.1355636864.git.viresh.kumar@linaro.org>
	<50E594F2.4000800@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:50217 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3ADFTL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jan 2013 00:19:11 -0500
Received: by mail-oa0-f45.google.com with SMTP id i18so14899250oag.32
        for <linux-pm@vger.kernel.org>; Thu, 03 Jan 2013 21:19:11 -0800 (PST)
In-Reply-To: <50E594F2.4000800@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, rafael.j.wysocki@intel.com, linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org

On 3 January 2013 19:55, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> I took a quick look at the problem you described above, and the cpufreq code..
> If we cannot avoid calling cpufreq_add_dev() from cpufreq_remove_dev(), then I can't
> think of anything better than what your patch does.

Good :)

> BTW, off-topic, while going through that path, I think I found a memory leak
> in __cpufreq_remove_dev():
>
>         if (unlikely(cpumask_weight(data->cpus) > 1)) {
>                 for_each_cpu(j, data->cpus) {
>                         if (j == cpu)
>                                 continue;
>                         per_cpu(cpufreq_cpu_data, j) = NULL;
>                 }
>         }
>
> We are assigning NULL without freeing that memory.

Not really. All cpus in affected_cpus (data->cpus), share the same
policy structure.
We have already taken backup of cpufreq_cpu_data for the first cpu in "data" and
are freeing it here:

	kfree(data);
