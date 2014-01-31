From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Fri, 31 Jan 2014 11:15:31 +0100
Message-ID: <52EB77C3.20704@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org>	<1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org>	<20140130153150.GD5002@laptop.programming.kicks-ass.net>	<52EA7D8A.6080604@linaro.org>	<20140130163501.GG5002@laptop.programming.kicks-ass.net>	<52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti Murthy <preeti.lkml@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: nicolas.pitre@linaro.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 01/31/2014 09:45 AM, Preeti Murthy wrote:
> Hi,
>
> On Thu, Jan 30, 2014 at 10:55 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 01/30/2014 05:35 PM, Peter Zijlstra wrote:
>>>
>>> On Thu, Jan 30, 2014 at 05:27:54PM +0100, Daniel Lezcano wrote:
>>>>
>>>> struct cpuidle_state *state =3D &drv->states[rq->index];
>>>>
>>>> And from the state, we have the following informations:
>>>>
>>>> struct cpuidle_state {
>>>>
>>>>          [ ... ]
>>>>
>>>>           unsigned int    exit_latency; /* in US */
>>>>           int             power_usage; /* in mW */
>>>>           unsigned int    target_residency; /* in US */
>>>>           bool            disabled; /* disabled on all CPUs */
>>>>
>>>>          [ ... ]
>>>> };
>>>
>>>
>>> Right, but can we say that a higher index will save more power and =
have
>>> a higher exit latency? Or is a driver free to have a random mapping=
 from
>>> idle_index to state?
>>
>>
>> If the driver does its own random mapping that will break the govern=
or
>> logic. So yes, the states are ordered, the higher the index is, the =
more you
>> save power and the higher the exit latency is.
>
> The above point holds true for only the ladder governor which sees th=
e idle
> states indexed in the increasing order of target_residency/exit_laten=
cy.

The cpuidle framework has been modified for both governor, see commit=20
8aef33a7.

The power field was initially used to do the selection, but no power=20
value was ever used to filled this field by any hardware. So the field=20
was arbitrarily filled with a decreasing value (-1, -2, -3 ...), and=20
used by the governor's select function. The patch above just removed=20
this field and the condition on power for 'select' assuming the idle=20
state are power ordered in the array.

> However this is not true as far as I can see in the menu governor. It
> acknowledges the dynamic ordering of idle states as can be seen in th=
e
> menu_select() function in the menu governor, where the idle state for=
 the
> CPU gets chosen.  You will notice that, even if it is found that the =
predicted
> idle time of the CPU is smaller than the target residency of an idle =
state,
> the governor continues to search for suitable idle states in the high=
er indexed
> states although it should have halted if the idle states' were ordere=
d according
> to their target residency.. The same holds for exit_latency.

I am not sure to get the point. Actually, this loop should be just=20
optimized to backward search the idle state like cpuidle_play_dead does=
=2E

There is also a patch proposed by Alex Shi about this loop.

[RFC PATCH] cpuidle: reduce unnecessary loop in c-state selection

http://comments.gmane.org/gmane.linux.power-management.general/42124

> Hence I think this patch would make sense only with additional inform=
ation
> like exit_latency or target_residency is present for the scheduler. T=
he idle
> state index alone will not be sufficient.

May be I misunderstood, but if you have the index, you can get the idle=
=20
state, hence the exit_latency and the target_residency, no ?

>>
>>> Also, we should probably create a pretty function to get that state=
,
>>> just like you did in patch 1.
>>
>>
>> Yes, right.
>>
>>
>>>> IIRC, Alex Shi sent a patchset to improve the choosing of the idle=
st cpu
>>>> and
>>>> the exit_latency was needed.
>>>
>>>
>>> Right. However if we have a 'natural' order in the state array the =
index
>>> itself might often be sufficient to find the least idle state, in t=
his
>>> specific case the absolute exit latency doesn't matter, all we want=
 is
>>> the lowest one.
>>
>>
>> Indeed. It could be simple as that. I feel we may need more informat=
ions in
>> the future but comparing the indexes could be a nice simple and effi=
cient
>> solution.
>>
>>
>>> Not dereferencing the state array saves hitting cold cachelines.
>>
>>
>> Yeah, always good to remind that. Should keep in mind for later.
>>
>> Thanks for your comments.
>>
>>    -- Daniel
>>
>>
>>
>>
>> --
>>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software=
 for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
