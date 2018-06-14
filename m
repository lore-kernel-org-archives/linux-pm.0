From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Thu, 14 Jun 2018 11:47:31 +0100
Message-ID: <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 13/06/18 19:13, Taniya Das wrote:
> Hello Sudeep,
> 
> Thanks for review comments.
> 
> On 6/13/2018 4:56 PM, Sudeep Holla wrote:
>>
>>

[...]

>> You are bit inconsistent on the wordings. Some places you refer this as
>> hardware engine. If so, please drop all references to firmware/FW. If
>> it's firmware then update accordingly.
>>
> 
> It is a hardware engine which has a firmware to take care of the
> managing the frequency request from OS. That is reason to refer it as a
> firmware.
> 

Yes I did guess that initially, but I failed to understand when
different bindings were posted to deal with devfreq and cpufreq with the
same firmware. Ideally if it's the firmware you are talking to, place
all these under /firmware node and align all those with single binding.

Is there anything else that this firmware deals with ? If so all those
need to be put in one place.

>>> +Properties:
>>> +- compatible
>>> +    Usage:        required
>>> +    Value type:    <string>
>>> +    Definition:    must be "qcom,cpufreq-fw".
>>> +
>>> +* Property qcom,freq-domain
>>> +Devices supporting freq-domain must set their "qcom,freq-domain"
>>> property with
>>> +phandle to a freq_domain_table in their DT node.
>>> +
>>> +* Frequency Domain Table Node
>>> +
>>> +This describes the frequency domain belonging to a device.
>>> +This node can have following properties:
>>> +
>>> +- reg
>>> +    Usage:        required
>>> +    Value type:    <prop-encoded-array>
>>> +    Definition:    Addresses and sizes for the memory of the perf
>>> +            , lut and enable bases.
>>> +            perf - indicates the base address for the desired
>>> +            performance state to be set.
>>> +            lut - indicates the look up table base address for the
>>> +            cpufreq    driver to read frequencies.
>>> +            enable - indicates the enable register for firmware.
>>
>>
>> You still didn't answer my earlier question.
>>
>> OS might touch one or 2 registers in lots of IP blocks. I am not sure
>> why those are any different from these. Are you trying to align with any
>> other bindings or specification. Are you trying to make this binding
>> generic here ? I understand if it was trying to generalize the firmware
>> interface, but you also state it's a hardware engine. So I fail to see
>> the need for such specificity here. Why not define the whole IP block
>> and the driver knows where to access these specific ones as they are
>> specific to this hardware block. In that way if you decide to add more
>> data, it's extensible easily without the need for patching DT.
>>
> 
> Sorry Sudeep I missed replying to your earlier query.
> The High level OS(HLOS) would require to access only these specific
> registers from this IP block and just mapping the whole block(huge
> region) is unnecessary from the OS point of View. As of now it is a
> generic binding for all using this IP block to manage frequency
> requests. The OS would only have to know the frequencies supported i.e
> to read the lookup table registers and put across the OS request using
> the performance state register.
> 

I am not sure if you need to defining bindings to save OSPM IO mapping.
In-fact you may be adding more mapping unnecessarily. The mappings are
page aligned and spiting the registers and mapping them individually may
result in more mappings.

I just need to know the rational for such specific choice of registers.
I assume it's aligned to some other standard specifications like CPPC
though not identical.

>> Eg. Suppose you need some information on power curve for EAS energy
>> model, I really hate to update DT for that or even do a mix with DT just
>> because f/w is no longer modifiable.
>>
> 
> For now we are safe.
> 

What do you mean by that ? It should be easily extensible is what I am
trying to say. You can add more info and alter the information in the
driver with compatibles if you keep the register info as minimum as
possible. For now, you have enable, set and lut registers. What if you
want to provide power numbers ?

-- 
Regards,
Sudeep
