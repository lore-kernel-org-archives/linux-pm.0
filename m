From: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Mon, 10 Feb 2014 11:20:37 +0000
Message-ID: <52F8B605.6020108@arm.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com> <1391786342-11812-3-git-send-email-thomas.ab@samsung.com> <52F50698.4060305@arm.com> <52F509BD.70903@arm.com> <CAGo_u6raZY0sKdDn4d92SKpi=eqUpf23vW8K_bEi-v62V2jdPA@mail.gmail.com> <52F51888.5010608@arm.com> <CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com> <52F51FCD.5000009@arm.com> <CAGo_u6quxExJOyY8mvCw5sDSuz=_j0YqJ6FJW+FAdaxUeqzN9Q@mail.gmail.com> <CAJuA9aj-LsdBiS2msOVmNRSe6mNj9QJsys9KjHZAk=9hrZOLzA@mail.gmail.com> <20140210085305.641e6de5@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140210085305.641e6de5@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>
Cc: Sudeep.Holla@arm.com, Nishanth Menon <nm@ti.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "t.figa@samsung.com" <t.figa@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 10/02/14 07:53, Lukasz Majewski wrote:
> Hi Thomas, Sudeep,
> 
>> On Sat, Feb 8, 2014 at 1:11 AM, Nishanth Menon <nm@ti.com> wrote:
>>> On Fri, Feb 7, 2014 at 12:02 PM, Sudeep Holla
>>> <Sudeep.Holla@arm.com> wrote:
>>>> On 07/02/14 17:37, Nishanth Menon wrote:
>>>>> On Fri, Feb 7, 2014 at 11:31 AM, Sudeep Holla
>>>>> <Sudeep.Holla@arm.com> wrote:
>>>>
>>>> [...]
>>>>
>>>>>> Yes I think its counter-intuitive as it's visible to the
>>>>>> userspace(list of frequencies and the boost parameters are
>>>>>> exposed through sysfs)
>>>>>
>>>>> That will be a different problem -> as currently every single
>>>>> frequency in the cpufreq list has ability to be marked as boost
>>>>> frequency - if userspace does not maintain that, then, IMHO, fix
>>>>> the userspace :D
>>>>>
>>>>
>>>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies
>>>> gives the list of frequencies based on the state of the boost
>>>> feature at anytime.
>>>>
>>>> Intuitively the list without boost shouldn't have any frequency
>>>> above the range when it's enabled :), that's what I was referring
>>>> to. So I am not talking about any issue with user-space
>>>> maintenance.
>>> Fair enough - but i still think it has nothing to do with dt binding
>>> itself -> and i think the discussion we've had should be good for
>>> the binding provided in this patch.. I hope.. if documentation
>>> needs a bit of better explanation to prevent a repeat of the same
>>> discussion at a later point of time, now might be a good time to
>>> add it in.
>>
Nishanth, though I am not convinced that it should be list, since you have a
valid point that this should not prevent in having this feature, I am fine with
the list.

>> The term boost and over-clocking have been described in the bindings
>> document as being the same. Since the term over-clocking refers to
>> running a CPU beyond normal operating frequencies, I tend to agree
>> with Sudeep that it is not intuitive if a normal operating frequency
>> is greater than a boost mode frequency.
>>
>> Otherwise, when userspace does "echo 1 >
>> /sys/devices/system/cpu/cpufreq/boost", what is it supposed to mean. I
>> think the original intent of boost mode patches was to allow CPU to
>> operate at frequencies greater than the normal operating frequencies.
>>
>> Lukasz, how would you want this to be handled?
> 
> Please consider an example:
> 
> normal-freqs: 1400000, 1200000, 1000000, 800000, 600000, 400000, 200000
> [1]
> boost-freqs: 1700000, 1600000, 1500000. [2]
> 
> All those freqs shall be represented as OPPs freq and voltage tuple.
> 
> Best would be to specify all the boost-freqs as:
> boost-freqs = <1700000 1600000 1500000> to be prepared for future
> quirks or problems (or special cases which might show up latter).
> If anybody can foresee any potential threads - like platform on which
> boost freqs are 1700000 and 1500000, but not 1600000, then please share
> this information.
> 
If that's the case then why should it be included in the list of OPPs.
I know Nishanth had a valid point in other thread previously(like including
SoC.dtsi having OPPs in platform files), but that's different problem.

> However, I think that it would be also acceptable to specify only:
> boost-freq = <1500000> and mark all freqs greater or equal to it as
> CPUFREQ_BOOST_FREQ.
> 
> If there aren't any potential problems, then I think the second option
> would be a good solution (we would have only one BOOST attribute stored
> at CPUs DTS node).
> 

Yes I prefer this to keep it simple and as per the definition of overclocking
or turbo boost in hardware terms if possible.

Just another thought, not sure how much this is true for real platforms, sharing
it anyway. IIUC these boost frequencies have certain constraints like thermal
and can't be sustained all the processors for long time.

So does it make sense to specify normal max frequency instead of boost-frequency
which by definition would be: "The maximum frequency that all processors are can
sustain simultaneously without any thermal constraints".
Ignore this if this is not the definition of boost on real platforms.


Regards,
Sudeep
