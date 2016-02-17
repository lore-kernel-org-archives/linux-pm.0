From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle period
Date: Thu, 18 Feb 2016 00:21:59 +0100
Message-ID: <CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
	<1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
	<alpine.LFD.2.20.1602161137400.13632@knanqh.ubzr>
	<CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36580 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965013AbcBQXWB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 18:22:01 -0500
In-Reply-To: <CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, Feb 18, 2016 at 12:09 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Feb 16, 2016 at 5:44 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Tue, 16 Feb 2016, Daniel Lezcano wrote:
>>
>>> Many IRQs are quiet most of the time, or they tend to come in bursts of
>>> fairly equal time intervals within each burst. It is therefore possible
>>> to detect those IRQs with stable intervals and guestimate when the next
>>> IRQ event is most likely to happen.
>>>
>>> Examples of such IRQs may include audio related IRQs where the FIFO size
>>> and/or DMA descriptor size with the sample rate create stable intervals,
>>> block devices during large data transfers, etc.  Even network streaming
>>> of multimedia content creates patterns of periodic network interface IRQs
>>> in some cases.
>>>
>>> This patch adds code to compute the mean interval and variance for each IRQ
>>> over a window of time intervals between IRQ events. Those statistics can
>>> be used to assist cpuidle in selecting the most appropriate sleep state
>>> by predicting the most likely time for the next interrupt.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> The math in next_irq_event() is correct even though I think it could be
>> done more simply.  But that can be optimized at a later time.
>>
>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>
> Well, I'm likely overlooking something, but how is this going to be
> hooked up to the code in idle.c?

My somewhat educated guess is that sched_idle() in your patch is
intended to replace cpuidle_idle_call(), right?

If so, why do you want to replace it?

And assuming that you have a good enough reason to do that, you need
to ensure that suspend-to-idle will work anyway.

Thanks,
Rafael
