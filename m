From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 10:53:50 +0100
Message-ID: <56A0AAAE.3060609@linaro.org>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <20160120192805.GT6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160120192805.GT6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/20/2016 08:28 PM, Peter Zijlstra wrote:
> On Wed, Jan 20, 2016 at 05:00:32PM +0100, Daniel Lezcano wrote:
>> +++ b/kernel/irq/handle.c
>> @@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_d=
esc *desc)
>>   			/* Fall through to add to randomness */
>>   		case IRQ_HANDLED:
>>   			flags |=3D action->flags;
>> +			handle_irqtiming(irq, action->dev_id);
>>   			break;
>
> This also looks completely busted for shared interrupts.

Hi Peter,

As explained in an answer to Thomas, in case of shared interrupts, it i=
s=20
up to the prediction code to handle a tuple (irq, dev_id). The handler=20
itself is at the right place IMO.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
