From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Mon, 18 Jan 2016 14:21:53 +0100
Message-ID: <569CE6F1.2090707@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601081631380.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601081631380.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
> On Wed, 6 Jan 2016, Daniel Lezcano wrote:

[ ... ]

>> +	/*
>> +	 * For all the irq already setup, assign the timing callback.
>> +	 * All interrupts with their desc NULL will be discarded.
>> +	 */
>> +	for_each_irq_desc(irq, desc)
>> +		sched_irq_timing_setup(irq, desc->action);
>
> No, no, no. This belongs into the core code register_irq_timings() fu=
nction
> which installs the handler into the irq descs with the proper protect=
ions and
> once it has done that enables the static key.
>
> The above is completely unprotected against interrupts being setup or=
 even
> freed concurrently.
>
> Aside of that, you call that setup function in setup_irq for each act=
ion() and
> here you call it only for the first one.

Hi Thomas,

I went through the different comments and almost finished the changes=20
but I think the 'register_ops' approach, which happens after some irq=20
were setup, introduces some useless complexity and because of the desc=20
lock section, the ops can't do memory allocation. Before going further,=
=20
I am wondering if declaring the irq_timings_ops statically (read withou=
t=20
'register_ops' - hence without a init time dependency) and calling the=20
init/free ops from alloc_desc/free_desc wouldn't be cleaner and simpler=
=2E

What do you think ?

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
