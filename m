From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Wed, 26 Jul 2017 16:41:23 +0200
Message-ID: <CAHKzcEMYVZu9NvjGiXMOt7G+4bop4ik6W7UynfQiQyTCr-aT1w@mail.gmail.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
 <276e68a1-edfe-961b-e387-7855f409557b@arm.com> <CAHKzcEMDRE5_dA11f9C19FHaMNcTFfj8=tEbOnMG92TtfyUz9w@mail.gmail.com>
 <592bc7b8-615d-5d80-f328-eabdfe6c3828@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37966 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdGZOmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 10:42:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id r123so10883485wmb.5
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 07:42:04 -0700 (PDT)
In-Reply-To: <592bc7b8-615d-5d80-f328-eabdfe6c3828@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 26 July 2017 at 16:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 26/07/17 14:54, Waldemar Rymarkiewicz wrote:
>> On 26 July 2017 at 15:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
>>>> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
>>>> index 57eec1c..e83bc15 100644
>>>> --- a/drivers/base/power/opp/of.c
>>>> +++ b/drivers/base/power/opp/of.c
>>>> +     struct device_node *np, *tmp_np, *cpu_np;
>>>>       int cpu, ret = 0;
>>>>
>>>>       /* Get OPP descriptor node */
>>>> @@ -593,19 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>>>               if (cpu == cpu_dev->id)
>>>>                       continue;
>>>>
>>>> -             tcpu_dev = get_cpu_device(cpu);
>>>> -             if (!tcpu_dev) {
>>>> -                     dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
>>>> +             cpu_np = of_get_cpu_node(cpu, NULL);
>>>
>>> Does this mean you get cpu_np != NULL even for cpu1/3 ?
>>
>> cpu_np exists for all logical cpus defined in DT.  System boots with
>> all logical CPUs, but platform code (mips) reconfigures that later on.
>>
>
> Fine, that's what I assumed but can't understand how is this case any
> different from normal hotplug ?
>
> CPUs won't be unregistered on hotplug path and hence I can't figure out
> why get_cpu_device would fail if all the CPUs were registered on boot.
> Just trying to understand the scenario and how it differs from normal
> hotplug case.

Frankly, I did not analyse this so much, but I just saw that, in my
case, mips reconfigures CPUs before topology_init() is called. This
function registers cpus that are set in cpu_present_mask. Therefore I
cannot find "struct device" for all *possible* CPUs.
See [1]

>
>>> Can we make use of of_cpu_device_node_get instead above ? We don't want
>>> keep parsing the device tree every time as the pointers are stashed in
>>> device struct.
>>
>> This is exactly what I want to change, not to use 'device struct'
>> because for cpu1/3 I don't have these structs.
>>
> Understood, but I am just trying to avoid that. I still want to use
> of_cpu_device_node_get as I recently posted a patch[1] to deal with such
> case in that function.

Well, I see I do exactly what you try to avoid with your patch :)
I agree this makes really sense so I can use your
of_cpu_device_node_get once it's in the tree.

-               tcpu_dev = get_cpu_device(cpu);
-               if (!tcpu_dev) {
-                       dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
+               cpu_np = of_cpu_device_node_get(cpu);
+               if (!cpu_np) {
+                       dev_err(cpu_dev, "%s: failed to get cpu%d node\n",


[1] http://elixir.free-electrons.com/linux/latest/source/arch/mips/kernel/topology.c#L19

/Waldek
