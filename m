From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
Date: Wed, 16 Jul 2014 14:45:21 -0700
Message-ID: <53C6F271.6070707@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org> <1405464473-3916-2-git-send-email-skannan@codeaurora.org> <CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com> <53C6DFAD.8030109@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42850 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaGPVp2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 17:45:28 -0400
In-Reply-To: <53C6DFAD.8030109@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 07/16/2014 01:25 PM, Saravana Kannan wrote:
> On 07/16/2014 01:24 AM, Viresh Kumar wrote:
>> On 16 July 2014 04:17, Saravana Kannan <skannan@codeaurora.org> wrote:
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>
>>> @@ -1110,9 +1092,10 @@ static int __cpufreq_add_dev(struct device
>>> *dev, struct subsys_interface *sif)
>>>
>>>   #ifdef CONFIG_SMP
>>>          /* check whether a different CPU already registered this
>>> -        * CPU because it is in the same boat. */
>>> +        * CPU because it is one of the related CPUs. */
>>>          policy = cpufreq_cpu_get(cpu);
>>> -       if (unlikely(policy)) {
>>> +       if (policy) {
>>> +               cpufreq_change_policy_cpus(policy, cpu, true);
>>
>> This is just a waste of time at boot as ... (see below)
>
> Why? Please explain.
>

Nevermind. Figured what you meant. I just need to improve the "if" check.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
