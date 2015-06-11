From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for
 cpu domain
Date: Thu, 11 Jun 2015 08:42:01 -0600
Message-ID: <20150611144201.GB1103@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <5574121F.2000806@samsung.com>
 <20150610165742.GB4497@linaro.org>
 <5578D5F6.8000000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35655 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbbFKOmB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 10:42:01 -0400
Received: by pacyx8 with SMTP id yx8so5072136pac.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 07:42:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5578D5F6.8000000@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 11 2015 at 18:27 -0600, Krzysztof Kozlowski wrote:
>On 11.06.2015 01:57, Lina Iyer wrote:
>> On Sun, Jun 07 2015 at 03:43 -0600, Krzysztof Kozlowski wrote:
>>> W dniu 05.06.2015 o 07:29, Lina Iyer pisze:
>>>> Generally cpus are grouped under a power domain in a SoC. When all cpus
>>>> in the domain are in their power off state,
>>>
>>> What do you exactly mean here by "CPU in power off state"? How does it
>>> map to kernel understanding of CPU device (hotplug? cpuidle?)?
>>>
>> Both cpuidle and hotplug could end with with core being powered down at
>> the platform driver or at PSCI (on V8). It does not matter which of
>> these two frameworks resulted in the cpu being powered off. But, if all
>> cpus in the domain are powered off, then the domain could be powered off
>> as well. This is the premise of this change. It is probably easier to
>> power off the domain when the cores in that domain/cluster have been
>> hotplugged off. It saves power to turn off the domain at that time, but
>> more power savings can be achieved if the domain could also be powered
>> off during cpuidle. Hotplug is not a common occurance, while cpuidle is.
>
>OK, it answers my questions, thanks.
>
>>
>>>> the cpu domain can also be
>>>> powered off. Genpd provides the framework for defining cpus as devices
>>>> that are part of a cpu domain.
>>>
>>> The problem which is solved looks to me like the same problem which
>>> coupled cpuidle tried to solve: a certain deep sleep mode (e.g. power
>>> off) can be entered when whole cluster is idle or other CPUs in cluster
>>> are powered off completely.
>>>
>>> It seems a little like duplicating the effort around coupled cpuidle.
>>>
>> I see where are you are going with this, but genpd solution is not
>> exactly a duplicate of the solution.
>>
>> Couple state is used to put the cpus in a deeper sleep state, which
>> could also result in powering off the domain. Coupled cpuidle is a
>> cpuidle mechanism for choosing a deeper sleep mode on certain hardware
>> that can only enter such a mode when all cpus cooperate.
>>
>> This patch attempts to describe the backend of a cpu domain. CPUs are
>> responsible for individual cpuidle states, cpus do enter their
>> recommended deepest idle state at the time of no activity. A cpu-domain
>> could be comprised of cpus, and other devices like GIC, busses etc, that
>> all need to idle before the domain can be powered off. This patch does
>> not dictate which idle state any those devices should enter, or
>> coordinate the idle states between devices. But, if cpus, choose to
>> power down, then this patch recognizes that and reduces the reference
>> usage count on the domain. Only when all devices in the domain remove
>> their usage count, will the domain be powered off.
>
>It would be nice to see the usage of this patch in cpuidle driver or
>platform code but I think I get the idea.
>
Ok, my next spin, will include the platform driver changes for the QCOM
SoC that I tested this on.


>Actually I like the approach.
>I am thinking how to utilize it to replace coupled cpuidle for our case.
>In our case we use coupled cpuidle because the SoC can be put in low
>power mode only if non-boot CPUs are powered down.
>
>However in our case:
>1. Some other devices (buses, clocks) also should be idle. This would
>perfectly match with this patch and with runtime PM.
>
>2. Some non-boot idle CPU could power itself down but it cannot wake up.
>Only the alive CPU can wake others. This probably means that we cannot
>provide a cpuidle driver which will power off unused cores and then, if
>boot CPU is idle, disable the CPU power domain by entering to low power
>mode.
>
>Anyway, as I said, I like the approach.
>
It was Kevin's idea, that I implemented.

Thanks,
Lina
>
>> There are two things this patch provides -
>>
>> i. A generic way to initialize a genpd specifically for cpus. (The
>> platform specifies the relation between a cpu and its domain in the DT
>> and provides the memory for the genpd structure)
>>
>> ii. On behalf of a platform, we track when the cpus power up and down
>> and use runtime_get and runtime_put on the genpd.
>>
>> Unlike coupled cpuidle, individual cpu idle state is not manipulated.
>> Coupled cpuidle does not care if the domain is powered off, it is used
>> to allow a certain C-state for the cpu, based on the idleness of other
>> cpus in that cluster. The focus of the series is powering down the
>> domain when the devices (cpus included) are powered off. You could see
>> this patch as a cpu-pm and runtime-pm interface layer.
>>
>> Hope that helps.
>>
>> Thanks,
>> Lina
>>
>
>Best regards,
>Krzysztof
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
