From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
Date: Sun, 17 Jun 2018 12:03:31 +0300
Message-ID: <CAHLCerNQ8Zy8xTbn3h6t7FvuB6Nvq1F14M8=UfnmChUBLKOvSw@mail.gmail.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org> <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org> <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org> <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 15, 2018 at 8:40 PM, Taniya Das <tdas@codeaurora.org> wrote:
>
>
> On 6/15/2018 5:29 PM, Amit Kucheria wrote:
>>
>> On Thu, Jun 14, 2018 at 9:24 PM, Taniya Das <tdas@codeaurora.org> wrote:
>>
>>>>> Sorry Sudeep I missed replying to your earlier query.
>>>>> The High level OS(HLOS) would require to access only these specific
>>>>> registers from this IP block and just mapping the whole block(huge
>>>>> region) is unnecessary from the OS point of View. As of now it is a
>>>>> generic binding for all using this IP block to manage frequency
>>>>> requests. The OS would only have to know the frequencies supported i.e
>>>>> to read the lookup table registers and put across the OS request using
>>>>> the performance state register.
>>>>>
>>>>
>>>> I am not sure if you need to defining bindings to save OSPM IO mapping.
>>>> In-fact you may be adding more mapping unnecessarily. The mappings are
>>>> page aligned and spiting the registers and mapping them individually may
>>>> result in more mappings.
>>>>
>>>> I just need to know the rational for such specific choice of registers.
>>>> I assume it's aligned to some other standard specifications like CPPC
>>>> though not identical.
>>>>
>>>
>>> I am not sure of the query but there is no other register that the OS is
>>> required to use other than the ones defined here.
>>>
>>>>>> Eg. Suppose you need some information on power curve for EAS energy
>>>>>> model, I really hate to update DT for that or even do a mix with DT
>>>>>> just
>>>>>> because f/w is no longer modifiable.
>>>>>>
>>>>>
>>>>> For now we are safe.
>>>>>
>>>>
>>>> What do you mean by that ?
>>>
>>>
>>>
>>> I meant here was currently there is no such known case where the f/w is
>>> no
>>> longer modifiable and we need to extend device tree bindings.
>>>
>>>> It should be easily extensible is what I am
>>>> trying to say. You can add more info and alter the information in the
>>>> driver with compatibles if you keep the register info as minimum as
>>>> possible. For now, you have enable, set and lut registers. What if you
>>>> want to provide power numbers ?
>>>>
>>>
>>> Yes I do understand the intent of mapping the whole register space, but
>>> as
>>> per the HW specs these 3 registers would be the only ones required for
>>> now.
>>> I do not think this hardware engine has any information on the power
>>> numbers.
>>
>>
>> "For now" - I think this is exactly the point that Sudeep is trying to
>> make.
>>
>> A future version of the HW engine, or more likely, a firmware
>> revision, will make more functionality available. Say, this needs
>> access to another register or two. This will require changing the DT
>> bindings. Instead, if you map the entire address space, you can just
>> add offsets to the new registers.
>>
>> So in this case, I think you should define the following addresses
>> (size 0x1400) for the two frequency domains
>>
>> 0x17d43000, 0x1400 (power cluster)
>> 0x17d45800, 0x1400 (perf cluster)
>>
>> And in the driver simply add offsets as follows:
>>
>> #define ENABLE_OFFSET               0x0
>> #define LUT_OFFSET                      0x110
>> #define PERF_DESIRED_OFFSET 0x920
>>
>
> The offsets could vary across versions of this IP and that is the reason to
> provide them through the DT and not define any such offsets.

If that is a known fact internally, you should already introduce
versioning information in the DT. e.g qcom,cpufreq-fw-v1. This will
give you the ability to deal with IP versions across SoC families.

We're currently trying to do the same thing for the TSENS IP.

Regards,
Amit
