From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Thu, 18 Feb 2016 10:25:54 +0000
Message-ID: <56C59C32.1000903@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
 <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1602161137400.13632@knanqh.ubzr>
 <CAJZ5v0h=BGTn5wFLBEusomSV9ny-CJM1ZA1XkFrJPjz01gzwDg@mail.gmail.com>
 <CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0id8+8oWLxDTJhewH3rKFvKPuAzMoOeg4xy2J097yCd9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 02/17/2016 11:21 PM, Rafael J. Wysocki wrote:

[ ... ]

>>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>>
>> Well, I'm likely overlooking something, but how is this going to be
>> hooked up to the code in idle.c?
>
> My somewhat educated guess is that sched_idle() in your patch is
> intended to replace cpuidle_idle_call(), right?

Well, no. I was planning to first have it to use a different code path=20
as experimental code in order to focus improving the accuracy of the=20
prediction and then merge or replace cpuidle_idle_call() with sched_idl=
e().

> If so, why do you want to replace it?
>
> And assuming that you have a good enough reason to do that, you need
> to ensure that suspend-to-idle will work anyway.

Yes, sure.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
