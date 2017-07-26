From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Wed, 26 Jul 2017 15:08:45 +0100
Message-ID: <592bc7b8-615d-5d80-f328-eabdfe6c3828@arm.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
 <276e68a1-edfe-961b-e387-7855f409557b@arm.com>
 <CAHKzcEMDRE5_dA11f9C19FHaMNcTFfj8=tEbOnMG92TtfyUz9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdGZOIs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 10:08:48 -0400
In-Reply-To: <CAHKzcEMDRE5_dA11f9C19FHaMNcTFfj8=tEbOnMG92TtfyUz9w@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 26/07/17 14:54, Waldemar Rymarkiewicz wrote:
> On 26 July 2017 at 15:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 26/07/17 13:11, Waldemar Rymarkiewicz wrote:
>>> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
>>> exist. This can happen on platforms where not all possible CPUs are
>>> available at start up ie. hotplugged out. Cpu device is not registered in
>>> the system so we are not able to check struct device to set the sharing
>>> CPUs bitmask properly.
>>>
>>> Example (real use case):
>>> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
>>> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
>>> due to the fact there is no struct device for cpu1 (remains offline at
>>> bootup).
>>>
>>
>> Interesting, will cpu1/3 ever hotplugged in to Linux ?
> 
> Yes, but it's specific to the platform.
> 
> Consider a system which has short-term real time requirements. We can
> put some CPUs offline for Linux and give them  for another RTOS or
> bare metal code to execute.
> 
> The concept is described well here
> http://wiki.prplfoundation.org/w/images/d/df/MIPS_OS_Remote_Processor_Driver_Whitepaper_1.0.9.pdf
> 

Indeed, I got to this paper when I saw this patch and was checking on
VPE/TC on MIPS :)

>> Just wondering if we can change the logical cpu assignment.
>> Please note, I am not against this patch, just got curious on logical
>> cpu numbering.
>>
>>> To solve the bug, stop using device struct to check device_node. Instead
>>> get cpu device_node directly from device tree with of_get_cpu_node().
>>>
>>> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>>> ---
>>>  drivers/base/power/opp/of.c | 29 +++++++++++++++++------------
>>>  1 file changed, 17 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
>>> index 57eec1c..e83bc15 100644
>>> --- a/drivers/base/power/opp/of.c
>>> +++ b/drivers/base/power/opp/of.c
>>> +     struct device_node *np, *tmp_np, *cpu_np;
>>>       int cpu, ret = 0;
>>>
>>>       /* Get OPP descriptor node */
>>> @@ -593,19 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>>               if (cpu == cpu_dev->id)
>>>                       continue;
>>>
>>> -             tcpu_dev = get_cpu_device(cpu);
>>> -             if (!tcpu_dev) {
>>> -                     dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
>>> +             cpu_np = of_get_cpu_node(cpu, NULL);
>>
>> Does this mean you get cpu_np != NULL even for cpu1/3 ?
> 
> cpu_np exists for all logical cpus defined in DT.  System boots with
> all logical CPUs, but platform code (mips) reconfigures that later on.
> 

Fine, that's what I assumed but can't understand how is this case any
different from normal hotplug ?

CPUs won't be unregistered on hotplug path and hence I can't figure out
why get_cpu_device would fail if all the CPUs were registered on boot.
Just trying to understand the scenario and how it differs from normal
hotplug case.

>> If yes, is that  OK to set the mask here ?
> 
> We do so, but before we need to check if this cpu_np shares the opp phandle.
> 
>>
>> Can we make use of of_cpu_device_node_get instead above ? We don't want
>> keep parsing the device tree every time as the pointers are stashed in
>> device struct.
> 
> This is exactly what I want to change, not to use 'device struct'
> because for cpu1/3 I don't have these structs.
> 

Understood, but I am just trying to avoid that. I still want to use
of_cpu_device_node_get as I recently posted a patch[1] to deal with such
case in that function.

[1] https://patchwork.kernel.org/patch/9859453/
-- 
Regards,
Sudeep
