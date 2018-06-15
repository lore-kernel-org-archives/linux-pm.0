From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Fri, 15 Jun 2018 18:42:48 +0100
Message-ID: <7f3ee013-bd12-7411-f90d-ed0fa1418ac3@arm.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <a01f2528-f696-3819-73eb-e321d2256b85@arm.com>
 <c456625c-e61c-b07e-b355-478813d9a182@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c456625c-e61c-b07e-b355-478813d9a182@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 15/06/18 18:31, Taniya Das wrote:
> 
> 
> On 6/15/2018 6:53 PM, Sudeep Holla wrote:
>>

[...]

>>>
>>>> It should be easily extensible is what I am
>>>> trying to say. You can add more info and alter the information in the
>>>> driver with compatibles if you keep the register info as minimum as
>>>> possible. For now, you have enable, set and lut registers. What if you
>>>> want to provide power numbers ?
>>>>
>>>
>>> Yes I do understand the intent of mapping the whole register space, but
>>> as per the HW specs these 3 registers would be the only ones required
>>> for now. I do not think this hardware engine has any information on the
>>> power numbers.
>>>
>>
>> That's fine. So on this platform DT, will you list only the registers
>> touched by the OS for all the IP ? I am sure that will not be the case.
>>
> 
> Yes, registers list those would be touched by OS only.
> 

You are still missing the point.
Look at other IP blocks like pinmux/gpio/...(choose your pick).

E.g. Lets say gpio controller driver touches only status set and get
registers in a port, will you list then individually in the DT for 'n'
ports on the platform ?

-- 
Regards,
Sudeep
