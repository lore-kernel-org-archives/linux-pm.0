From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Wed, 26 Jul 2017 16:20:48 +0100
Message-ID: <2bbd7e46-881d-7ece-b299-48d9c146da47@arm.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
 <276e68a1-edfe-961b-e387-7855f409557b@arm.com>
 <CAHKzcEMDRE5_dA11f9C19FHaMNcTFfj8=tEbOnMG92TtfyUz9w@mail.gmail.com>
 <592bc7b8-615d-5d80-f328-eabdfe6c3828@arm.com>
 <CAHKzcEMYVZu9NvjGiXMOt7G+4bop4ik6W7UynfQiQyTCr-aT1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34342 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750893AbdGZPUv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 11:20:51 -0400
In-Reply-To: <CAHKzcEMYVZu9NvjGiXMOt7G+4bop4ik6W7UynfQiQyTCr-aT1w@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 26/07/17 15:41, Waldemar Rymarkiewicz wrote:
> On 26 July 2017 at 16:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 26/07/17 14:54, Waldemar Rymarkiewicz wrote:
>>> On 26 July 2017 at 15:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>>>>> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
>>>>> index 57eec1c..e83bc15 100644
>>>>> --- a/drivers/base/power/opp/of.c
>>>>> +++ b/drivers/base/power/opp/of.c
>>>>> +     struct device_node *np, *tmp_np, *cpu_np;
>>>>>       int cpu, ret = 0;
>>>>>
>>>>>       /* Get OPP descriptor node */
>>>>> @@ -593,19 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>>>>               if (cpu == cpu_dev->id)
>>>>>                       continue;
>>>>>
>>>>> -             tcpu_dev = get_cpu_device(cpu);
>>>>> -             if (!tcpu_dev) {
>>>>> -                     dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
>>>>> +             cpu_np = of_get_cpu_node(cpu, NULL);
>>>>
>>>> Does this mean you get cpu_np != NULL even for cpu1/3 ?
>>>
>>> cpu_np exists for all logical cpus defined in DT.  System boots with
>>> all logical CPUs, but platform code (mips) reconfigures that later on.
>>>
>>
>> Fine, that's what I assumed but can't understand how is this case any
>> different from normal hotplug ?
>>
>> CPUs won't be unregistered on hotplug path and hence I can't figure out
>> why get_cpu_device would fail if all the CPUs were registered on boot.
>> Just trying to understand the scenario and how it differs from normal
>> hotplug case.
> 
> Frankly, I did not analyse this so much, but I just saw that, in my
> case, mips reconfigures CPUs before topology_init() is called. This
> function registers cpus that are set in cpu_present_mask. Therefore I
> cannot find "struct device" for all *possible* CPUs.
> See [1]

Which means it's never marked present in the boot ?
Looks like it's removed quite early even before CPU's are registered.
So I am not sure if they are ever used on Linux, in which case it's
better to fix the logical numbering itself.

Anyways we need to use of_cpu_device_node_get once my patch is in the tree.

-- 
Regards,
Sudeep
