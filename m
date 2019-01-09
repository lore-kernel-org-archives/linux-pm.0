From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
Date: Wed, 9 Jan 2019 11:04:32 +0530
Message-ID: <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
 <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
 <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
 <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 1/7/2019 9:47 PM, Raju P L S S S N wrote:
> 
> 
> On 1/4/2019 2:49 AM, Stephen Boyd wrote:
>> Quoting Raju P L S S S N (2019-01-03 04:22:58)
>>>
>>> On 12/29/2018 3:08 AM, Stephen Boyd wrote:
>>>> Quoting Raju P L S S S N (2018-12-26 01:44:43)
>>>>>
>>>>> There are two RSC devices in SoC one for application processor 
>>>>> subsystem
>>>>> & other display subsystem. Both RSC contain registers for PDC timers
>>>>> (one for each subsystem).
>>>>
>>>> When is the timer programmed on the display subsystem's RSC? It's hard
>>>> to give advice without all the information.
>>>
>>> For display subsystem RSC, hardware sleep solver takes care of timer
>>> programming for wakeup when the subsystem goes to Power collapse.
>>
>> So the display subsystem doesn't need to program their PDC in their RSC
>> from software?
> Yes.
> 
>>
>>>>
>>>> I would think that it would make sense for the application processor's
>>>> RSC timer to be programmed from the broadcast timer mechanism in the
>>>> kernel so that timers during idle work and suspend turns off the timer
>>>> appropriately with a shutdown hook. I guess the PDC can't tell you the
>>>> time though? It looks like a shadow (and limited) version of the ARM
>>>> architected MMIO timer that we already program for the broadcast timer
>>>> mechanism. Is that because even the MMIO timer can't wakeup the system
>>>> in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
>>>> always be used as the system wide broadcast mechanism because we 
>>>> need to
>>>> augment it with the PDC timer to get the actual wakeup.
>>>>
>>>
>>> Yes. this is correct.
>>>
>>>> Maybe we should be adding hooks into the broadcast timer mechanism to
>>>> program this wakeup event hardware in addition to the ARM MMIO 
>>>> timer. Or
>>>> we should stop using the ARM MMIO timer on these systems and read the
>>>> system register based physical time in the RSC timer driver and 
>>>> register
>>>> this 64-bit PDC register as the broadcast timer. So the time reading
>>>> would be through sysreg and the wakeup programming would be done by
>>>> writing the PDC timer. The assumption would be that we have access to
>>>> the physical time registers (which sounds like the assumption we 
>>>> have to
>>>> make).
>>>
>>> There are no physical timer registers available in RSC for this purpose.
>>>
>>>>
>>>> Do we get an interrupt somewhere from the RSC hardware when the timer
>>>> fires? Or does that just cause a system wakeup event without any 
>>>> pending
>>>> irq and then another irq (like the ARM architected timer) just happens
>>>> to be pending around the same time? If we get an interrupt somehow then
>>>> I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
>>>> timer approach.
>>>
>>> There is no interrupt for PDC timeout. It just causes system wakeup
>>> without a pending irq. ARM MMIO is necessary for irq.
>>
>> Does that system wakeup cause the CPUs to be enabled? So the sysreg
>> based timer in the CPU would start working? Or does it only make the
>> system come out of a deep enough idle state to make an always on domain
>> work that only contains the MMIO based ARM architected timer?
> 
> It only makes the system come out of deep sleep state for MMIO timer to 
> function.
> 
>>
>> I'd hope that each RSC's PDC timer wakes up the owner of the RSC so that
>> we can use the sysreg based timers and ignore the MMIO based timers
>> here. This isn't a very important distinction to make though, so if you
>> have to use the MMIO timers then it just means some extra DT things need
>> to be done to relate the MMIO timers with the RSC that has the timer
>> that needs to be programmed too.
> 
>>
>> Either way we would need a way to either hook the ARM architected timer
>> driver in the kernel, or reimplement the bit of code needed to implement
>> the clockevent based on the ARM architected timer that programs the ARM
>> timer and the PDC timer together.
>>
> 
> Could you please provide some more details on the implementation?

Hi Stephen,

Regardless of implementation options about application processor 
subsytem PDC timer, I think there is a need to differentiate the fact 
that for application processor subsystem PDC timer programming is done 
by SW but not for display processor subsystem as HW sleep solver takes 
care of PDC timer during sleep entry/exit. How about having a dt 
property like qcom,pdc-timer-mode = "solver"/"sw" ? The current patch 
introduced client based model using regmap to achieve this 
differentiation between these two subsystems. By using the dt property, 
once rpmh-src driver instance for application subsystem can have PDC 
timer programing implemented. Let me know if there is another way.

For implementation of PDC timer, I see the following based on above 
discussion -
1. Take the existing cpu_pm_notify approach and move the current series 
approach of programing PDC timer registers to RSC driver. This wouldn't 
involve any changes in clock_event_framework/broadcast framework.

2. Add api hooks (like reading the next wake up programmed) to ARM 
architecture timer driver so that the value is copied to PDC timer using 
the api with in RSC driver based on cpu_pm_notifications.

3. Changes in clockevent to program both ARM mem timer & PDC timer 
together. Could you please share some more details on this?


Please let me know if the first approach is ok.

Thanks,
Raju.

> 
> 
>>>
>>>>
>>>> How the RSC is used in general by other devices, like display, is not
>>>> clear to me. We don't have a "wakeup event" framework in the kernel 
>>>> that
>>>> device drivers like the display driver can grab a reference to and
>>>> program some system wide wakeup for. That sounds like something new 
>>>> that
>>>> could be handled entirely in the display driver with direct register
>>>> writes, or it could be some qcom specific API/framework that eventually
>>>> calls down into the same RSC driver that knows what offsets to write
>>>> into in the display RSC's register space, or it could be an entirely
>>>> generic framework like clk or regulator frameworks that could be 
>>>> used by
>>>> anything. BTW, are we using the display RSC yet?
>>>>
>>>
>>> Only display subsystem RSC is programmed along with CPU RSC in Linux.
>>> display RSC instance is not present in upstream but it is present in
>>> downstream and used for resource communication purpose only.
>>
>>  From the comment above it sounds like the display RSC handles the wakeup
>> programming in hardware? So there isn't a need to add a 'wakeup event'
>> framework or anything like that. Please correct me if I'm wrong.
> 
> Yes. There is no need for any framework. From RSC driver point of view 
> there is a need to differentiate apps_rsc vs display_rsc as SW programs 
> PDC timer only in apps_rsc case. How about having a dt property to 
> capture this?
> 
> Thanks,
> Raju
