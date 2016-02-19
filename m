From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Fri, 19 Feb 2016 15:01:05 +0000
Message-ID: <56C72E31.9010707@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
 <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1602161137400.13632@knanqh.ubzr>
 <CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
 <CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
 <56C59C32.1000903@linaro.org>
 <CAJZ5v0icpNoW3SFxvsj5bSo9MnH3cvthece1bMVJRHm7i8HhAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34971 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427662AbcBSPBK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 10:01:10 -0500
Received: by mail-oi0-f44.google.com with SMTP id x21so13564677oix.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2016 07:01:09 -0800 (PST)
In-Reply-To: <CAJZ5v0icpNoW3SFxvsj5bSo9MnH3cvthece1bMVJRHm7i8HhAw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 02/18/2016 07:57 PM, Rafael J. Wysocki wrote:
> On Thu, Feb 18, 2016 at 11:25 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 02/17/2016 11:21 PM, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>>>>
>>>>
>>>> Well, I'm likely overlooking something, but how is this going to b=
e
>>>> hooked up to the code in idle.c?
>>>
>>>
>>> My somewhat educated guess is that sched_idle() in your patch is
>>> intended to replace cpuidle_idle_call(), right?
>>
>>
>> Well, no. I was planning to first have it to use a different code pa=
th as
>> experimental code in order to focus improving the accuracy of the pr=
ediction
>> and then merge or replace cpuidle_idle_call() with sched_idle().
>
> In that case, what about making it a proper cpuidle governor that
> people can test and play with in a usual way?  Then it may potentiall=
y
> benefit everybody and not just your experimental setup and you may ge=
t
> coverage on systems you have no access to normally.
>
> There is some boilerplate code to add for this purpose, but that's no=
t
> that bad IMO.

Hi Rafael,

sorry for the delay in the responses.

Actually, adding a new governor is precisely what I would like to avoid=
=20
because the objective is the scheduler acts as the governor. Here, it i=
s=20
the 'predictor' and the API to enter an idle state conforming the idle=20
duration and the latency constraint.

Concerning the testing, it is quite easy to switch from idle_sched to=20
'menu' via on sched_debug or whatever option we want to add.

>
> So I'm still unsure why you want to replace cpuidle_idle_call() with
> sched_idle().  Is there anything wrong with it that it needs to be
> replaced?

I don't want to replace cpuidle_idle_call() with sched_idle(). How we=20
integrate the API is something I would like to discuss with another=20
patchset focused in this integration only.

=46or reference: https://lkml.org/lkml/2016/1/12/530

-- Daniel





--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

