From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 3/5] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Tue, 12 Aug 2014 14:21:53 +0530
Message-ID: <CAKohpokZjAu5E1=m8LRMb=Z87qV1pdLbwZd7gc-462EuJRU4pg@mail.gmail.com>
References: <1406250448-470-1-git-send-email-skannan@codeaurora.org>
	<1406250448-470-4-git-send-email-skannan@codeaurora.org>
	<CAKohpom-+At=YjEkZH-mn8OP1ATDBzuLw7mTPaUnG+1qvJ8FTA@mail.gmail.com>
	<53E93FF1.1010809@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:54983 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaHLIvx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Aug 2014 04:51:53 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so6913230oac.8
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2014 01:51:53 -0700 (PDT)
In-Reply-To: <53E93FF1.1010809@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 12 August 2014 03:43, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 08/07/2014 03:48 AM, Viresh Kumar wrote:

>>> @@ -1369,24 +1354,15 @@ static int __cpufreq_remove_dev_prepare(struct
>>> device *dev,
>>>                  }
>>>          }
>>>
>>> -       if (!cpufreq_driver->setpolicy)
>>> -               strncpy(per_cpu(cpufreq_cpu_governor, cpu),
>>> -                       policy->governor->name, CPUFREQ_NAME_LEN);
>>> -
>>
>>
>> Why? Probably I did mention this earlier as well?
>
>
> This code is saving the governor name here to restore it when the policy is
> created again after suspend/resume or hotplug of all CPUs. Since we no
> longer throw away the policy struct, there's no point in doing this.
>
> I should remove this per cpu variable though. Will do it in v5.

Hmm, makes sense. So probably keep this code in this patch and get rid
of all uses of 'cpufreq_cpu_governor' in a separate patch.

>>> +       if (cpus > 1) {
>>> +               if (cpu == policy->cpu) {
>>> +                       new_cpu = cpumask_any_but(policy->cpus, cpu);
>>> +                       if (new_cpu >= 0)
>>
>>
>> Can this ever be false?
>
>
> If this is the last CPU going down.

Can that be true? Its present in (cpus > 1) block :)

>>>   static int cpufreq_remove_dev(struct device *dev, struct
>>> subsys_interface *sif)
>>>   {
>>>          unsigned int cpu = dev->id;
>>> -       int ret;
>>> -
>>> -       if (cpu_is_offline(cpu))
>>> -               return 0;
>>> +       int ret = 0;
>>>
>>> -       ret = __cpufreq_remove_dev_prepare(dev, sif);
>>> +       if (cpu_online(cpu))
>>> +               ret = __cpufreq_remove_dev_prepare(dev, sif);
>>
>>
>> Why do you need a change here?
>
>
> Since we no longer do remove_dev_finish during hotplug, we can't just short
> circuit the entire function. We have to finish the remove when the CPU is
> hot-removed or when the cpufreq driver is unregistered.

I think this is tricky and we must have a clear comment here..
I missed this on my initial reviews..
