From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Tue, 29 Apr 2014 12:25:39 +0200
Message-ID: <535F7E23.7020104@linaro.org>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org> <20140428102819.GG27561@twins.programming.kicks-ass.net> <535E3673.8020606@linaro.org> <5275186.Hb1xxV4ZWO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:40907 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbaD2KZk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 06:25:40 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so162262wib.4
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2014 03:25:39 -0700 (PDT)
In-Reply-To: <5275186.Hb1xxV4ZWO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Amit Kucheria <amit.kucheria@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/29/2014 01:11 AM, Rafael J. Wysocki wrote:
> On Monday, April 28, 2014 01:07:31 PM Daniel Lezcano wrote:
>> On 04/28/2014 12:28 PM, Peter Zijlstra wrote:
>>> On Mon, Apr 28, 2014 at 12:09:20PM +0200, Daniel Lezcano wrote:
>>>> I agree a numerical value is not flexible. But it sounds weird to =
put a
>>>> scheduler option in the sysfs and maybe more options will follow.
>>>>
>>>> I am wondering if we shouldn't create a new cgroup for 'energy' an=
d put
>>>> everything in there. So we will have more flexibility for extensio=
n and we
>>>> will be able to create a group of tasks for performance and a grou=
p of tasks
>>>> for energy saving.
>>>>
>>>> Does it make sense ?
>>>
>>> The old knobs used to live here:
>>>
>>> -What:          /sys/devices/system/cpu/sched_mc_power_savings
>>> -               /sys/devices/system/cpu/sched_smt_power_savings
>>
>> Ah right.
>>
>>> Not entirely sure that's a fine place, but it has precedent.
>>
>> I share your doubts about the right place.
>>
>> I'm really wondering if the cgroup couldn't be a good solution:
>>
>> Amit pointed the conflict about the power vs performance with some
>> applications. We want to have for example a game to run fast perform=
ance
>> and some other application to save power.
>
> You can't save power.
>
> Power is the energy flow *rate*.  It's like speed, so how can you sav=
e it?
>
> If you talk about saving in this context, please always talk about en=
ergy as
> well, because that's what we want to save.

Hi Rafael,

yeah, I think there is an abuse when talking about 'power'. I thought I=
=20
took care of talking about energy but 'power' comes always in my mind. =
I=20
believe the confusion is coming from the meaning of 'power' in French=20
where one translation is 'energy'.

Anyway, thanks for the clarification, I will try to use the term=20
'energy' and 'power' conveniently next time.

> This means that positioning power against performance doesn't make an=
y sense
> whatsoever.  You could try to position energy efficiency (that is, th=
e relative
> cost of doing work in terms of energy) against performance, but even =
that is
> questionable, because, as I said in one of the previous messages, wha=
t is good
> for performance is often good for energy efficiency too (think about =
race to
> idle for example).
> In other words, you want to have a knob whose both ends may happen to=
 mean
> the same thing.  Wouldn't that be a little odd?

Yes, I share this point of view. I believe we won't care about adding=20
any knobs for this situation.

> In my opinion it would be much better to have a knob representing the=
 current
> relative value of energy to the user (which may depend on things like=
 whether
> or not the system is on battery etc) and meaning how far we need to g=
o with
> energy saving efforts.
>
> So if that knob is 0, we'll do things that are known-good for perform=
ance.
> If it is 1, we'll do some extra effort to save enery as well possibly=
 at
> a small expense of performance if that's necessary.  If it is 100, we=
'll do
> all we can to save as much energy as possible without caring about pe=
rformance
> at all.
>
> And it doesn't even have to be scheduler-specific, it very well may b=
e global.

That would be very nice but I don't see how we can quantify this energy=
=20
and handle that generically from the kernel for all the hardware.

I am pretty sure we will discover for some kind of hardware a specific=20
option will consume more power, argh ! energy I mean, than another=20
hardware because of the architecture.

 From my personal experience, when we are facing this kind of complexit=
y=20
and heuristic, it is the sign the userspace has some work to do.

What I am proposing is not in contradiction with your approach, it is=20
about exporting a lot of knobs to userspace, and the userspace decide=20
how to map what is '0' <--> '100' regarding these options. Nothing=20
prevent the different platform to set a default value for these options=
=2E

 From my POV, the cgroup could be a good solution for that for differen=
t=20
reasons. Especially one good reason is we can stick the energy policy=20
per task instead of the entire system.

Let's imagine the following scenario:

An user has a laptop running a mailer looking for the email every 5=20
minutes. The system switched to 'power'. The user wants to play a video=
=20
game but due to the 'power' policy, the game is not playable so it=20
forces the policy to 'performance'. All the tasks will use the=20
'performance' policy, thus consuming more energy.

If we do per task, the video game will use the 'performance' policy and=
=20
the other tasks on the system will use the 'power' policy. The userspac=
e=20
can take the decision to freeze the application running 'performance' i=
f=20
we reach a critical battery level.

The cgroup is a good framework to do that and gives a lot of flexibilit=
y=20
to userspace. I understood Peter does not like the cgroup but I did not=
=20
give up to convince him, the cgroup could be good solution :)

Looking forward, if the energy policy is tied with the task, in the=20
future we can normalize the energy consumption and stick to an 'energy=20
load' per task and reuse the load tracking for energy, do per task=20
energy accounting, nice per energy, etc ...

Going back to reality, concretely this sysctl patch did not reach a=20
consensus. So I will resend the two other patches, hoping the discussio=
n=20
will lead to an agreement.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

