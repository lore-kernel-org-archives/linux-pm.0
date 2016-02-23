From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 23 Feb 2016 10:49:20 +0100
Message-ID: <56CC2B20.6080706@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
 <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1602161137400.13632@knanqh.ubzr>
 <CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
 <CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
 <56C59C32.1000903@linaro.org>
 <CAJZ5v0icpNoW3SFxvsj5bSo9MnH3cvthece1bMVJRHm7i8HhAw@mail.gmail.com>
 <56C72E31.9010707@linaro.org>
 <CAJZ5v0g8p9ERmmHWO_Aysgk2cZprOr7DjU39GA478NrNQvx8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35895 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcBWJtY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 04:49:24 -0500
Received: by mail-wm0-f47.google.com with SMTP id g62so212947255wme.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2016 01:49:23 -0800 (PST)
In-Reply-To: <CAJZ5v0g8p9ERmmHWO_Aysgk2cZprOr7DjU39GA478NrNQvx8ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@kernel.org>


Hi Rafael,

Added Ingo.

On 02/20/2016 12:43 AM, Rafael J. Wysocki wrote:
> On Fri, Feb 19, 2016 at 4:01 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 02/18/2016 07:57 PM, Rafael J. Wysocki wrote:
>>>
>>> On Thu, Feb 18, 2016 at 11:25 AM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 02/17/2016 11:21 PM, Rafael J. Wysocki wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Well, I'm likely overlooking something, but how is this going to=
 be
>>>>>> hooked up to the code in idle.c?
>>>>>
>>>>>
>>>>>
>>>>> My somewhat educated guess is that sched_idle() in your patch is
>>>>> intended to replace cpuidle_idle_call(), right?
>>>>
>>>>
>>>>
>>>> Well, no. I was planning to first have it to use a different code =
path as
>>>> experimental code in order to focus improving the accuracy of the
>>>> prediction
>>>> and then merge or replace cpuidle_idle_call() with sched_idle().
>>>
>>>
>>> In that case, what about making it a proper cpuidle governor that
>>> people can test and play with in a usual way?  Then it may potentia=
lly
>>> benefit everybody and not just your experimental setup and you may =
get
>>> coverage on systems you have no access to normally.
>>>
>>> There is some boilerplate code to add for this purpose, but that's =
not
>>> that bad IMO.
>>
>>
>> Hi Rafael,
>>
>> sorry for the delay in the responses.
>>
>> Actually, adding a new governor is precisely what I would like to av=
oid
>> because the objective is the scheduler acts as the governor.
>
> But why, really?
>
> Well, first of all I'm not sure what "the scheduler acts as the
> governor" means.  For the lack of a better explanation I'll refer to
> the message at https://lkml.org/lkml/2016/1/12/530 that you pointed m=
e
> at.

=46or better explanation let's refer to Ingo's email:

http://lwn.net/Articles/552889/

Ingo said:

"Note that I still disagree with the whole design notion of having an "=
idle
back-end" (and a 'cpufreq back end') separate from scheduler power savi=
ng
policy, and none of the patch-sets offered so far solve this fundamenta=
l
design problem. [...]"

"[...] so the scheduler is in an _ideal_ position to do a judgement cal=
l=20
about the near future and estimate how deep an idle state a CPU core=20
should enter into and what frequency it should run at."

The patches I sent are supposed to provide the base brick to solve 'thi=
s=20
fundamental design problem' by giving a couple of functions:

  - when is the next event ?
  - sleep X us with Y latency.

The component responsible of choosing X and Y will be the scheduler=20
based on its knowledge of 'the near future' coming from 'when is the=20
next event ?'

Moving the code I submitted into a governor has little sense with the=20
goal described above because the sched_next_event will be called from=20
the scheduler code directly. Today the integration is not obvious.

There is a branch in the cpuidle loop below but this is just for testin=
g=20
purpose at the moment and not part as a submitted patch.


> Your code in there does something like:
>
> if (sched_idle_enabled()) {
>          int latency =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>          s64 duration =3D sched_idle_next_wakeup();
>          sched_idle(duration, latency);
> } else {
>          cpuidle_idle_call();
> }
>
> which is quite questionable to be honest as it adds an extra branch t=
o
> the idle loop for no real benefit.

That is not the part of the submitted patchset. It is an example based=20
on an embryonic code to show how to use the API.

How those API are integrated with the scheduler will be submitted in a=20
separate patchset.

> Now, what really is the difference between "governor" and "predictor"=
?
>   I don't quite see it except that the former is expected to provide =
a
> specific interface.

The predictor is a standalone component giving the answer to the=20
question 'when is the next event ?'.

The governor uses the next event information from the prediction to tak=
e=20
a decision (governor =3D=3D scheduler here).

If the code I am proposing is buried in the cpuidle framework inside a=20
governor I don't see how the scheduler can become the ideal place to do=
=20
a decision.

> The way the idle loop works now (and I'm not sure if you can really
> change it) is that when you get into it, you're idle no matter what
> and you simply need to choose an idle state for the CPU to go into.
> Some code needs to select that state, regardless of what name you wan=
t
> to give to that code.
>
> In the current setup, which I really don't think is unreasonable, thi=
s
> is done by cpuidle_select() that simply invokes the governor's
> ->select() callback and that's it.  That callback may very well be
> part of the scheduler and registered from there if you want that, but
> why do you want to change the whole mechanism?  What's wrong with it
> now?

There is nothing wrong. We lived with it for years and that satisfied=20
everyone.

My point is I am sticking to how Ingo and Peter envision the integratio=
n=20
work. It is clearly stated in Ingo's mail, he disagree on having the=20
notion of 'idle backend'.

The couple of patches here are to be used by the scheduler directly.

> Further, if you look at your sched_idle(), it looks almost like
> cpuidle_idle_call() with a few really minor differences (apart from
> the fact that it doesn't cover suspend-to-idle which it will have to
> do eventually) that really look arbitrary and the "selection" if () i=
n
> it simply plays the role of the invocation of ->select().  So how is
> it different really?

The question is not if there is duplicate code or not. Factoring code i=
s=20
easy but factoring code with a moving target is much more difficult.

The moving target is the cpuidle code itself. I have been consolidating=
=20
the code several times and the effort got ruined several times by the=20
changes.

It is much more easier to introduce the experimental code make it evolv=
e=20
wisely and then consolidate with the existing code.

And it does even more sense to branch it if the feature is by design th=
e=20
exact opposite of the current design (idle based statistics vs irq=20
events) even if there is common code.

>> Here, it is the 'predictor' and the API to enter an idle state confo=
rming the idle duration
>> and the latency constraint.
>
> Isn't that just a simple rearrangement of the code?  The latency stil=
l
> comes from PM QoS and the duration is computed by your new code
> instead of that being done by ->select() itself, but why actually
> ->select() cannot call sched_idle_next_wakeup() to get the duration
> value it needs?  Why do those values need to be passed to a
> cpuidle_idle_call() replacement as arguments?  Is there any particula=
r
> technical reason for doing that?

Yes. The select returns an idle state index. Even if, at some points, w=
e=20
may need to know what is the idle state fitting a set of timing=20
constraints, the scheduler is interested in how long the cpu will be=20
idle in order to take a decision.

One example when everything is integrated:

The topology gives the information CPU2 and CPU3 are cluster1.

1. CPU3 enters idle, the next wakeup event is stored for this cpu
2. CPU2 enters idle and looks when it should wake up
3. CPU2 looks when CPU3 wakes up
4. CPU2 takes the time intersection between CPU2/CPU3 in order to have=20
the time the cluster is idle
5. CPU2 takes the decision if cluster power down is possible

With the current design it is not possible to do that.

> And why that name, sched_idle_next_wakeup()?  Does that function
> really have anything to do with the scheduler now?
>
>> Concerning the testing, it is quite easy to switch from idle_sched t=
o 'menu'
>> via on sched_debug or whatever option we want to add.
>>
>>>
>>> So I'm still unsure why you want to replace cpuidle_idle_call() wit=
h
>>> sched_idle().  Is there anything wrong with it that it needs to be
>>> replaced?
>>
>>
>> I don't want to replace cpuidle_idle_call() with sched_idle(). How w=
e
>> integrate the API is something I would like to discuss with another =
patchset
>> focused in this integration only.
>>
>> For reference: https://lkml.org/lkml/2016/1/12/530
>
> Please answer my questions above.  If you need to post a patchset for
> this purpose, please do that.

=2E..

> I have to say that I was looking forward to the IRQ timings based
> duration prediction, but the way you want to use it now is seriously
> disappointing.

This comment is a bit patronizing but I can understand you were=20
expecting more.

I will let Peter and Ingo give their opinions and I will follow the=20
consensus.

Thanks for the review.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

