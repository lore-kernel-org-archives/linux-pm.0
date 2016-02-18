From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle period
Date: Thu, 18 Feb 2016 20:57:17 +0100
Message-ID: <CAJZ5v0icpNoW3SFxvsj5bSo9MnH3cvthece1bMVJRHm7i8HhAw@mail.gmail.com>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
	<1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
	<alpine.LFD.2.20.1602161137400.13632@knanqh.ubzr>
	<CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
	<CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
	<56C59C32.1000903@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33730 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946956AbcBRT5T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 14:57:19 -0500
In-Reply-To: <56C59C32.1000903@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, Feb 18, 2016 at 11:25 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 02/17/2016 11:21 PM, Rafael J. Wysocki wrote:
>
> [ ... ]
>
>>>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>>>
>>>
>>> Well, I'm likely overlooking something, but how is this going to be
>>> hooked up to the code in idle.c?
>>
>>
>> My somewhat educated guess is that sched_idle() in your patch is
>> intended to replace cpuidle_idle_call(), right?
>
>
> Well, no. I was planning to first have it to use a different code path as
> experimental code in order to focus improving the accuracy of the prediction
> and then merge or replace cpuidle_idle_call() with sched_idle().

In that case, what about making it a proper cpuidle governor that
people can test and play with in a usual way?  Then it may potentially
benefit everybody and not just your experimental setup and you may get
coverage on systems you have no access to normally.

There is some boilerplate code to add for this purpose, but that's not
that bad IMO.

>
>> If so, why do you want to replace it?
>>

So I'm still unsure why you want to replace cpuidle_idle_call() with
sched_idle().  Is there anything wrong with it that it needs to be
replaced?

Thanks,
Rafael
