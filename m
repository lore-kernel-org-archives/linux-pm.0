From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Mon, 8 May 2017 14:57:55 +0100
Message-ID: <c2651a3c-befd-9288-37ce-2c60afb7a0e2@arm.com>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
 <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
 <20170428204803.plu467okibtxga4d@rob-hp-laptop>
 <a307c76d-72c3-eb84-e7d4-d5e47e2af727@arm.com>
 <20170508071350.GH17010@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdEHN6A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 May 2017 09:58:00 -0400
In-Reply-To: <20170508071350.GH17010@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org



On 08/05/17 08:13, Viresh Kumar wrote:
> On 03-05-17, 12:29, Sudeep Holla wrote:
>>
>>
>> On 28/04/17 21:48, Rob Herring wrote:
>>> On Wed, Apr 26, 2017 at 04:27:05PM +0530, Viresh Kumar wrote:
>>>> Power-domains need to express their active states in DT and the devices
>>>> within the power-domain need to express their dependency on those active
>>>> states. The power-domains can use the OPP tables without any
>>>> modifications to the bindings.
>>>>
>>>> Add a new property "power-domain-opp", which will contain phandle to the
>>>> OPP node of the parent power domain. This is required for devices which
>>>> have dependency on the configured active state of the power domain for
>>>> their working.
>>>>
>>>> For some platforms the actual frequency and voltages of the power
>>>> domains are managed by the firmware and are so hidden from the high
>>>> level operating system. The "opp-hz" property is relaxed a bit to
>>>> contain indexes instead of actual frequency values to support such
>>>> platforms.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/opp/opp.txt | 74 ++++++++++++++++++++++++++-
>>>>  1 file changed, 73 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>>> index 63725498bd20..6e30cae2a936 100644
>>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>>> @@ -77,7 +77,10 @@ This defines voltage-current-frequency combinations along with other related
>>>>  properties.
>>>>  
>>>>  Required properties:
>>>> -- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
>>>> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. In some
>>>> +  cases the exact frequency in Hz may be hidden from the OS by the firmware and
>>>> +  this field may contain values that represent the frequency in a firmware
>>>> +  dependent way, for example an index of an array in the firmware.
>>>
>>> Not really sure OPP binding makes sense here. What about all the other 
>>> properties. We expose voltage, but not freq?
>>>
>>
>> I completely agree with that and I have been pushing this to be
>> represented as just regulators[0]. Mark B seem to dislike that
>> idea [1]
> 
> Just as an update, Rajendra confirmed (offline) that for some of the
> implementations, the microcontroller handles both frequency and
> voltages of a device. So it isn't just a regulator anymore and as me
> and Kevin were saying, we need a complete OPP here.
> 

Yes, I followed the thread and figured that out. But Rajendra also
raised "What if the microcontroller firmware maps the performance-index
to voltage but expects linux to scale the frequency? There is no way to
specify a performance-index *and* a frequency for a OPP now I guess? So
this needs to be addressd now IIUC.

So as Kevin pointed out, we need to experiment and look at all
possibilities before finalizing the bindings. Better to have examples
for all these and describe how bindings are be used including how to
distinguish between these use-case from the bindings if it's not implicit.

-- 
Regards,
Sudeep
