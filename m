From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: common: Introduce PM domains for CPUs/clusters
Date: Thu, 13 Aug 2015 17:01:47 -0500
Message-ID: <CAL_Jsq+-9vS4_KRQKAsQnHXBMfubkRtnWwuBHSrD166trmTVSw@mail.gmail.com>
References: <CAL_JsqLhHy5gO=usm1HLf8h6iz_5FguCDo-Qz2Km+XEwaCODUA@mail.gmail.com>
 <1439406024-41893-1-git-send-email-lina.iyer@linaro.org> <CAL_JsqLcSs79bnj4ELN0uiwJ6gxt46PghxvuGQ7prkq-4gLKhg@mail.gmail.com>
 <20150813201248.GB84868@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34523 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbbHMWCI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 18:02:08 -0400
Received: by ykdt205 with SMTP id t205so54002217ykd.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 15:02:07 -0700 (PDT)
In-Reply-To: <20150813201248.GB84868@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Thu, Aug 13, 2015 at 3:12 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Thu, Aug 13 2015 at 11:29 -0600, Rob Herring wrote:
>>
>> On Wed, Aug 12, 2015 at 2:00 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>
>>> Define and add Generic PM domains (genpd) for CPU clusters. Many new
>>> SoCs group CPUs as clusters. Clusters share common resources like GIC,
>>> power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
>>> idle, these shared resources may also be put in their idle state.
>>>
>>> The idle time between the last CPU entering idle and a CPU resuming
>>> execution is an opportunity for these shared resources to be powered
>>> down. Generic PM domain provides a framework for defining such power
>>> domains and attach devices to the domain. When the devices in the domain
>>> are idle at runtime, the domain would also be suspended and resumed
>>> before the first of the devices resume execution.
>>>
>>> We define a generic PM domain for each cluster and attach CPU devices in
>>> the cluster to that PM domain. The DT definitions for the SoC describe
>>> this relationship. Genpd callbacks for power_on and power_off can then
>>> be used to power up/down the shared resources for the domain.
>>>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> Changes since v1:
>>>
>>> - Function name changes and split out common code
>>> - Use cpu,pd for now. Removed references to ARM. Open to recommendations.
>>> - Still located in arch/arm/common/. May move to a more appropriate
>>> location.
>>> - Platform drivers can directly call of_init_cpu_domain() without using
>>>   compatibles.
>>> - Now maintains a list of CPU PM domains.
>>
>>
>> [...]
>>
>>> +static int __init of_pm_domain_attach_cpus(void)
>>> +{
>>> +       int cpuid, ret;
>>> +
>>> +       /* Find any CPU nodes with a phandle to this power domain */
>>> +       for_each_possible_cpu(cpuid) {
>>> +               struct device *cpu_dev;
>>> +               struct of_phandle_args pd_args;
>>> +
>>> +               cpu_dev = get_cpu_device(cpuid);
>>> +               if (!cpu_dev) {
>>> +                       pr_warn("%s: Unable to get device for CPU%d\n",
>>> +                                       __func__, cpuid);
>>> +                       return -ENODEV;
>>> +               }
>>> +
>>> +               /*
>>> +                * We are only interested in CPUs that can be attached to
>>> +                * PM domains that are cpu,pd compatible.
>>> +                */
>>
>>
>> Under what conditions would the power domain for a cpu not be cpu,pd
>> compatible?
>>
> Mostly never. But I dont want to assume and attach a CPU to its domain
> that I am not concerned with.

Which is why the power controller driver should tell you.

>> Why can't the driver handling the power domain register with gen_pd
>> and the cpu_pd as the driver is going to be aware of which domains are
>> for cpus.
>
> They could and like Renesas they would. They could have an intricate
> hierarchy of domains that they may want to deal with in their platform
> drivers. Platforms could define the CPU devices as IRQ-safe and attach
> it to their domains. Ensure the reference count of the online and
> running CPUs are correct and they are good to go. They also would attach
> the CPU devices to the domain and everything would work as they would
> here. Its just repeated code across platforms that we are trying to
> avoid.

I agree that we want to have core code doing all that setup, But that
has nothing to do with needing to have a DT property. The driver just
needs to tell you the list of cpu power domains and the associated
cpus they want the core to manage. Then it is up to you to do the rest
of the setup.

So I really don't think we need a DT binding here.

>> While there could be h/w such that all power domains within
>> a chip have a nice uniform programming model, I'd guess that is the
>> exception, not the rule. First, chips I have worked on were not that
>> way. CPU related and peripheral related domains are handled quite
>> differently.
>
> Agreed. These are very SoC specific components and would require
> platform specific programming. But most SoCs, would need to do many
> other things like suspending debuggers, reducing clocks, GIC save and
> restore, cluster state determination etc that are only getting more
> generalized. We have generalized ARM CPU idle, I see this as the
> platform for the next set of power saving in an SoC.
>
>> Second, often the actions on the CPU power domains don't
>> take effect until a WFI, so you end up with a different programming
>> sequence.
>>
> How so? The last core going down (in this case, when the domain is
> suspended the last core is the last device that does a _put() on the
> domain) would determine and perform the power domain's programming
> sequence, in the context of the last CPU. A sequence that would only be
> effected in hardware when the the CPU executes WFI. I dont see why it
> would be any different than how it is today.

I just mean that for a peripheral (e.g a SATA controller), you simply
quiesce the device and driver and shut off power. With a cpu or cpu
related component, you can't really shut it off until you stop
running. So cpu domains are special.

Rob
