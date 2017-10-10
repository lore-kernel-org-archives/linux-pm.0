From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Tue, 10 Oct 2017 18:51:31 +0200
Message-ID: <313949ce-e0d6-da66-7809-a963f704f75f@linaro.org>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
 <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:47813 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdJJQve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 12:51:34 -0400
Received: by mail-wm0-f42.google.com with SMTP id t69so7002930wmt.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 09:51:34 -0700 (PDT)
In-Reply-To: <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Schneider <valentin.schneider@arm.com>, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>

On 29/09/2017 13:07, Valentin Schneider wrote:
> Hi,
> 
> 
> On 09/28/2017 06:13 AM, Daniel Lezcano wrote:
>> At this moment, we have both the interrupt setup and the polling
>> enabled. The
>> interrupt does nothing more than forcing an update while the
>> temperature is
>> polled every second.
>>
>> We can do much better than that, threshold is set to 65C in the DT and
>> the
>> passive cooling device enters in the dance when 75C is reached. We
>> need to
>> sample the temperature at 65C in order to let the IPA gather enough
>> values for
>> the PID computation.
> Sample collection is a valid point, but passive cooling should become
> active as soon
> as 65C is reached (at least that's the case with IPA). Furthermore,
> IPA's PID controller
> is reset when the temperature drops below the first trip-point
> (threshold) - as such,
> I believe the PID's behavior should be the same now as it with polling.
> 
> I think the main selling point of interrupt-based updates is a faster
> reaction time.
> On the HiKey960, we can go from below the threshold temperature to over
> the control temperature
> in less than a second (default polling rate is 1s). In this situation,
> IPA's PID starts accumulating error
> while already overshooting, which isn't optimal. On top of that, the
> passive cooling reacts
> too slowly.
>>   If the SoC is running at a temperature below 65C, we will
>> be constantly polling for nothing.
>>
>> This patch disables the sensor when the temperature is below 65C and
>> enables it
>> when passing the threshold. It results the thermal sensor driver will
>> have no
>> activity most of the time.
>>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Cc: Leo Yang <leo.yan@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> I've tested this on HiKey960 (Android 4.9 + upstream patches to apply
> your thermal/drivers/hisi series + Kevin's hi3600 support).
> I ran a video workload, and noticed I get several interrupts while
> passive cooling is already in effect
> (I might move part of this discussion to Kevin's posting, but I think
> it's still relevant to be here):
> 
> [  118.107357] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
> [  119.182531] hisi_thermal fff30000.tsensor: THERMAL ALARM: 76235 > 65000
> [  119.361964] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
> [  119.907865] hisi_thermal fff30000.tsensor: THERMAL ALARM: 75620 > 65000
> [  119.959076] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70700 > 65000


Ok, so apparently there are multiple alarms level in the driver for the
hikey960 [1]. So I prefer to drop this patch for now and take the
hikey960 thermal support first and we can sort out the issue later.

For my information, can you show me the DT snippet you have for the
thermal zones?

  -- Daniel

[1] https://patchwork.kernel.org/patch/9965743/


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
