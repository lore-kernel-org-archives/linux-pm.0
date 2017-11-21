From: Lukasz Luba <llu.ker.dev@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue, 21 Nov 2017 18:03:23 +0100
Message-ID: <5A145C5B.5060800@gmail.com>
References: <cover.1510735482.git.viresh.kumar@linaro.org> <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com> <20171116152058.GR3257@vireshk-i7> <2810372.fJ2vMN0cWO@aspire.rjw.lan> <20171116234422.GA6141@localhost.localdomain> <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com> <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com> <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org> <5A144CB3.50806@gmail.com> <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On 21/11/17 17:08, Vincent Guittot wrote:
> Hi Lukasz
>
> On 21 November 2017 at 16:56, Lukasz Luba <llu.ker.dev@gmail.com> wrote:
>> On 21/11/17 14:06, Daniel Lezcano wrote:
>>>
>>> On 21/11/2017 12:30, Ionela Voinescu wrote:
>>>
>>> [ ... ]
>>>
>>>> A DT model would be easy to support with the current code but it would
>>>> be very inaccurate.
>>>
>>>
>>> Why ?
>>>
>>> [ ... ]
>>>
>> Hi all,
>>
>> The DT solution won't fly, the reason can be found below.
>>
>> I agree with Ionela and Punit that the Juno board is not
>> the best platform to test the static power impact on IPA.
>> In some other platforms the static power can be 50% or more
>> of the total power, so it cannot be neglected.
>>
>> These are the issues.
>> The static power equation is complicated, here is one known to me.
>> The leakage function is exponentially influenced by current circuit
>> supply voltage, body-bias and some constants K_{4,5}.
>>
>> P_{leak} = L_{g}*V_{dd}*K_{3}*e^{K_{4}*V_{dd}}*e^{K_{5}*V_{bs}}+|
>> V_{bs}|*I_{Ju}
>
> You forgot one main contributor of static leakage: the temperature

Yes, so basically, the relation between temperature and the power
is exponential. The power doubles every 20deg.
You can find this model for static power for Mali GPU:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/stabilize-8743.60.B-chromeos-4.4/drivers/gpu/arm/midgard/backend/gpu/mali_kbase_power_model_simple.c#37

There is a polynomial which approximates it for gpu (starting from
line 56).

>
>>
>> It can also vary depending on technology (CMOS, FinFET, etc).
>>
>> It would be really hard to approximate by i.e. a polynomial
>> function with inputs from DT. One size does not fit all.
>
> But can't we linearized around the target temp ? that were we want to
> be accurate

I would also add: 'around the target temp' and starting at least from
IPA enable trip point (so i.e. from 55degC to 75degC + margin)
I would have to simulate it and see some results to see error values.
Of course it would be better that having no static power at all,
but the vendors would have create a tool which calculates the factors
and put them to DT.

Regards,
Lukasz
