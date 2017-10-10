From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / OPP: use of_cpu_device_node_get() instead of of_get_cpu_node()
Date: Tue, 10 Oct 2017 19:13:44 +0200
Message-ID: <CAJZ5v0gTa-5ObrK2v9ZHeMiXTuOsDhxcqxyknUDzJ6t453__Hw@mail.gmail.com>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <20171010114543.GI4031@vireshk-i7> <cc282f1b-0b36-bf45-6a0b-5e017c3c44ea@arm.com>
 <72b6eba4-91b3-4786-6675-308f2adfd45d@arm.com> <CAJZ5v0ivRZmAOWRLM+da7PaHxF9Gjt7P4adj2sdG0-toJb_Jdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38053 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755436AbdJJRNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 13:13:45 -0400
Received: by mail-oi0-f68.google.com with SMTP id t134so9232635oih.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 10:13:45 -0700 (PDT)
In-Reply-To: <CAJZ5v0ivRZmAOWRLM+da7PaHxF9Gjt7P4adj2sdG0-toJb_Jdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Oct 10, 2017 at 7:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Oct 10, 2017 at 5:54 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 10/10/17 13:39, Sudeep Holla wrote:
>>>
>>>
>>> On 10/10/17 12:45, Viresh Kumar wrote:
>>>> On 10-10-17, 11:48, Sudeep Holla wrote:
>>>>> Commit 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
>>>>> moved away from using cpu_dev->of_node because of some limitations.
>>>>> However commit 7467c9d95989 ("of: return of_get_cpu_node from
>>>>> of_cpu_device_node_get if CPUs are not registered") added support to
>>>>> falls back to of_get_cpu_node if called if CPUs are not registered yet.
>>>>>
>>>>> This patch moves back to use of_cpu_device_node_get in
>>>>> dev_pm_opp_of_get_sharing_cpus to avoid scanning the device tree again.
>>>>> It also adds the missing of_node_put for the CPU device nodes.
>>>>>
>>>>> Cc: Viresh Kumar <vireshk@kernel.org>
>>>>> Cc: Nishanth Menon <nm@ti.com>
>>>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>>> Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
>>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>> ---
>>>>>  drivers/base/power/opp/of.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
>>>>> index 0b718886479b..3505193043fe 100644
>>>>> --- a/drivers/base/power/opp/of.c
>>>>> +++ b/drivers/base/power/opp/of.c
>>>>> @@ -603,13 +603,14 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>>>>>             if (cpu == cpu_dev->id)
>>>>>                     continue;
>>>>>
>>>>> -           cpu_np = of_get_cpu_node(cpu, NULL);
>>>>> +           cpu_np = of_cpu_device_node_get(cpu);
>>>>>             if (!cpu_np) {
>>>>>                     dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
>>>>>                             __func__, cpu);
>>>>>                     ret = -ENOENT;
>>>>>                     goto put_cpu_node;
>>>>>             }
>>>>> +           of_node_put(cpu_np);
>>>>>
>>>>>             /* Get OPP descriptor node */
>>>>>             tmp_np = _opp_of_get_opp_desc_node(cpu_np);
>>>>
>>>> This line is going to use cpu_np, how can we put cpu_np before this ?
>>>>
>>>
>>> We didn't take the reference before commit 762792913f8c as we were using
>>> cpu_dev->of_node directly. The above mentioned commit used
>>> of_get_cpu_node() which introduces the reference. So I assumed it
>>> shouldn't matter much and in order to keep the change simple, I did it
>>> before _opp_of_get_opp_desc_node. I can move just after
>>> _opp_of_get_opp_desc_node and before if check to avoid having both
>>> before failure goto and after the block.
>>>
>>> Let me know what is your preference ?
>>>
>>>> And you need to rebase this on pm/linux-next.
>>>>
>>>
>>> OK
>>>
>> I see the path has changed. I am not sure how you would consider this
>> patch ? as fix for v4.14(the refcount issue is introduced in v4.14)
>> or for v4.15
>>
>> I can split the patch if use of of_cpu_device_node_get is not a fix
>> material. Let me know.
>
> It will go into 4.15, no need to resend.

I mean no need to resend just because of the path change.

It looks like the patch itself needs to be modified, though.

Anyway, 4.15 material.
