From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Mon, 20 Jun 2016 18:57:21 +0100
Message-ID: <57682E81.20304@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
 <1466099274.20208.65.camel@linaro.org> <5762E8F1.1040401@arm.com>
 <1466151552.2841.10.camel@linaro.org> <m2inx3bvgy.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m2inx3bvgy.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org



On 20/06/16 18:50, Kevin Hilman wrote:
> "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
>
>> On Thu, 2016-06-16 at 18:59 +0100, Sudeep Holla wrote:
>>>
>>> On 16/06/16 18:47, Jon Medhurst (Tixy) wrote:
>>>> On Thu, 2016-06-16 at 11:38 +0100, Sudeep Holla wrote:
>>>> [...]
>>>>> +enum scpi_power_domain_state {
>>>>> +	SCPI_PD_STATE_ON = 0,
>>>>> +	SCPI_PD_STATE_OFF = 3,
>>>>> +};
>>>>
>>>> The SCPI doc defines the meaning of these numbers (0 and 3) in the 'Juno
>>>> specifics' chapter. So does these values need to come from device-tree
>>>> to allow for other hardware or SCP implementations?
>>>>
>>>
>>> Ah unfortunately true :(. I had not noticed that. But I would like to
>>> check if this can be made as part of the standard protocol. Adding such
>>> details to DT seems overkill and defeat of the whole purpose of the
>>> standard protocol.
>>
>> Well. it seems to me the 'standard protocol' is whatever the current
>> implementation of ARM's closed source SCP firmware is. It also seems to
>> me that people are making things up as they go along, without a clue as
>> to how to make things generic, robust and future proof. Basically,
>> Status Normal ARM Fucked Up.
>
> Fully agree here.  Just because ARM calls it a "standard" does not make
> it so.  As we've already seen[1], vendors are using initial/older/whatever
> versions of SCPI, so pushing the Juno version as standard just becuase
> it's in ARM's closed firmware is not the right way forward either.
>

I am not disagreeing on that. There's an on going effort to make it as
standard as PSCI. But that's still work in progress. We need to deal
with the existing variety of SCPI until then. No argument on that.

The only argument I had on the other thread is not to make the changes
too flexible that enabled the vendors to make up their own deviation of
SCPI even for their future platforms. All I am asking is to keep is less
flexible just to support existing platforms out there and not to help
the vendors to deviate further.

-- 
Regards,
Sudeep
