From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle period
Date: Sat, 20 Feb 2016 00:43:36 +0100
Message-ID: <CAJZ5v0g8p9ERmmHWO_Aysgk2cZprOr7DjU39GA478NrNQvx8ng@mail.gmail.com>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
	<1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
	<alpine.LFD.2.20.1602161137400.13632@knanqh.ubzr>
	<CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
	<CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
	<56C59C32.1000903@linaro.org>
	<CAJZ5v0icpNoW3SFxvsj5bSo9MnH3cvthece1bMVJRHm7i8HhAw@mail.gmail.com>
	<56C72E31.9010707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35668 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427474AbcBSXnt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 18:43:49 -0500
In-Reply-To: <56C72E31.9010707@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Fri, Feb 19, 2016 at 4:01 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 02/18/2016 07:57 PM, Rafael J. Wysocki wrote:
>>
>> On Thu, Feb 18, 2016 at 11:25 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> On 02/17/2016 11:21 PM, Rafael J. Wysocki wrote:
>>>
>>> [ ... ]
>>>
>>>>>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>>>>>
>>>>>
>>>>>
>>>>> Well, I'm likely overlooking something, but how is this going to be
>>>>> hooked up to the code in idle.c?
>>>>
>>>>
>>>>
>>>> My somewhat educated guess is that sched_idle() in your patch is
>>>> intended to replace cpuidle_idle_call(), right?
>>>
>>>
>>>
>>> Well, no. I was planning to first have it to use a different code path as
>>> experimental code in order to focus improving the accuracy of the
>>> prediction
>>> and then merge or replace cpuidle_idle_call() with sched_idle().
>>
>>
>> In that case, what about making it a proper cpuidle governor that
>> people can test and play with in a usual way?  Then it may potentially
>> benefit everybody and not just your experimental setup and you may get
>> coverage on systems you have no access to normally.
>>
>> There is some boilerplate code to add for this purpose, but that's not
>> that bad IMO.
>
>
> Hi Rafael,
>
> sorry for the delay in the responses.
>
> Actually, adding a new governor is precisely what I would like to avoid
> because the objective is the scheduler acts as the governor.

But why, really?

Well, first of all I'm not sure what "the scheduler acts as the
governor" means.  For the lack of a better explanation I'll refer to
the message at https://lkml.org/lkml/2016/1/12/530 that you pointed me
at.

Your code in there does something like:

if (sched_idle_enabled()) {
        int latency = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
        s64 duration = sched_idle_next_wakeup();
        sched_idle(duration, latency);
} else {
        cpuidle_idle_call();
}

which is quite questionable to be honest as it adds an extra branch to
the idle loop for no real benefit.

Now, what really is the difference between "governor" and "predictor"?
 I don't quite see it except that the former is expected to provide a
specific interface.

The way the idle loop works now (and I'm not sure if you can really
change it) is that when you get into it, you're idle no matter what
and you simply need to choose an idle state for the CPU to go into.
Some code needs to select that state, regardless of what name you want
to give to that code.

In the current setup, which I really don't think is unreasonable, this
is done by cpuidle_select() that simply invokes the governor's
->select() callback and that's it.  That callback may very well be
part of the scheduler and registered from there if you want that, but
why do you want to change the whole mechanism?  What's wrong with it
now?

Further, if you look at your sched_idle(), it looks almost like
cpuidle_idle_call() with a few really minor differences (apart from
the fact that it doesn't cover suspend-to-idle which it will have to
do eventually) that really look arbitrary and the "selection" if () in
it simply plays the role of the invocation of ->select().  So how is
it different really?

> Here, it is the 'predictor' and the API to enter an idle state conforming the idle duration
> and the latency constraint.

Isn't that just a simple rearrangement of the code?  The latency still
comes from PM QoS and the duration is computed by your new code
instead of that being done by ->select() itself, but why actually
->select() cannot call sched_idle_next_wakeup() to get the duration
value it needs?  Why do those values need to be passed to a
cpuidle_idle_call() replacement as arguments?  Is there any particular
technical reason for doing that?

And why that name, sched_idle_next_wakeup()?  Does that function
really have anything to do with the scheduler now?

> Concerning the testing, it is quite easy to switch from idle_sched to 'menu'
> via on sched_debug or whatever option we want to add.
>
>>
>> So I'm still unsure why you want to replace cpuidle_idle_call() with
>> sched_idle().  Is there anything wrong with it that it needs to be
>> replaced?
>
>
> I don't want to replace cpuidle_idle_call() with sched_idle(). How we
> integrate the API is something I would like to discuss with another patchset
> focused in this integration only.
>
> For reference: https://lkml.org/lkml/2016/1/12/530

Please answer my questions above.  If you need to post a patchset for
this purpose, please do that.

I have to say that I was looking forward to the IRQ timings based
duration prediction, but the way you want to use it now is seriously
disappointing.

Thanks,
Rafael
