From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Wed, 26 Jul 2017 15:54:36 +0200
Message-ID: <CAHKzcEMDRE5_dA11f9C19FHaMNcTFfj8=tEbOnMG92TtfyUz9w@mail.gmail.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com> <276e68a1-edfe-961b-e387-7855f409557b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37999 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdGZNzS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 09:55:18 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so4942804wrd.5
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 06:55:17 -0700 (PDT)
In-Reply-To: <276e68a1-edfe-961b-e387-7855f409557b@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 26 July 2017 at 15:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 26/07/17 13:11, Waldemar Rymarkiewicz wrote:
>> We fail dev_pm_opp_of_get_sharing_cpus() when possible cpu device does not
>> exist. This can happen on platforms where not all possible CPUs are
>> available at start up ie. hotplugged out. Cpu device is not registered in
>> the system so we are not able to check struct device to set the sharing
>> CPUs bitmask properly.
>>
>> Example (real use case):
>> 2 physical MIPS cores, 4 VPE, cpu0/2 run Linux and cpu1/3 are not available
>> for Linux at boot up. cpufreq-dt driver + opp v2 fail to register opp_table
>> due to the fact there is no struct device for cpu1 (remains offline at
>> bootup).
>>
>
> Interesting, will cpu1/3 ever hotplugged in to Linux ?

Yes, but it's specific to the platform.

Consider a system which has short-term real time requirements. We can
put some CPUs offline for Linux and give them  for another RTOS or
bare metal code to execute.

The concept is described well here
http://wiki.prplfoundation.org/w/images/d/df/MIPS_OS_Remote_Processor_Driver_Whitepaper_1.0.9.pdf

> Just wondering if we can change the logical cpu assignment.
> Please note, I am not against this patch, just got curious on logical
> cpu numbering.
>
>> To solve the bug, stop using device struct to check device_node. Instead
>> get cpu device_node directly from device tree with of_get_cpu_node().
>>
>> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/base/power/opp/of.c | 29 +++++++++++++++++------------
>>  1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
>> index 57eec1c..e83bc15 100644
>> --- a/drivers/base/power/opp/of.c
>> +++ b/drivers/base/power/opp/of.c
>> +     struct device_node *np, *tmp_np, *cpu_np;
>>       int cpu, ret = 0;
>>
>>       /* Get OPP descriptor node */
>> @@ -593,19 +599,18 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>               if (cpu == cpu_dev->id)
>>                       continue;
>>
>> -             tcpu_dev = get_cpu_device(cpu);
>> -             if (!tcpu_dev) {
>> -                     dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
>> +             cpu_np = of_get_cpu_node(cpu, NULL);
>
> Does this mean you get cpu_np != NULL even for cpu1/3 ?

cpu_np exists for all logical cpus defined in DT.  System boots with
all logical CPUs, but platform code (mips) reconfigures that later on.

> If yes, is that  OK to set the mask here ?

We do so, but before we need to check if this cpu_np shares the opp phandle.

>
> Can we make use of of_cpu_device_node_get instead above ? We don't want
> keep parsing the device tree every time as the pointers are stashed in
> device struct.

This is exactly what I want to change, not to use 'device struct'
because for cpu1/3 I don't have these structs.

/Waldek
