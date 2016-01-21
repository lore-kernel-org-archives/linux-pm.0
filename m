From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 15:19:29 +0100
Message-ID: <56A0E8F1.7010409@linaro.org>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <20160120190718.GS6357@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1601202050050.3575@nanos> <56A0A9E3.2070306@linaro.org>
 <alpine.DEB.2.11.1601211128240.3873@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601211128240.3873@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/21/2016 02:52 PM, Thomas Gleixner wrote:
> On Thu, 21 Jan 2016, Daniel Lezcano wrote:
>> On 01/20/2016 08:57 PM, Thomas Gleixner wrote:
>>> That and we don't want to call it for each handler which returned h=
andled.
>>> The
>>> called code would do two samples in a row for the same interrupt in=
 case of
>>> two shared handlers which get raised at the same time. Not very lik=
ely, but
>>> possible.
>>
>> Actually, the handle passes dev_id in order to let the irqtimings to=
 sort out
>> a shared interrupt and prevent double sampling. In other words, for =
shared
>> interrupts, statistics should be per t-uple(irq , dev_id) but that i=
s
>> something I did not implemented ATM.
>
> So my comment about double sampling applies.
>
>> IMO, the handler is at the right place. The prediction code does not=
 take care
>> of the shared interrupts yet.
>>
>> I tried to find a platform with shared interrupts in the ones I have=
 available
>> around me but I did not find any. Are the shared interrupts somethin=
g used
>> nowadays or coming from legacy hardware ? What is the priority to ha=
ndle the
>> shared interrupts in the prediction code ?
>
> And why would that thing care about shared interruts at all? It's a l=
egacy
> burden and I really don't see a reason why that new thing which is ta=
rgeted on
> modern hardware should deal with them. Just treat them as a single in=
terrupt
> for now and be done with it.

I just sent an email about how handling them :)

If the shared interrupts are only related to old hardware, these ones=20
shouldn't have cpuidle, hence there is no need to enable the irq=20
timings. So you are right in this case and we can keep the feature simp=
le.

On a other hand, Peter sent three examples of /proc/interrupts with=20
shared interrupts. I don't know how old are the platforms and what are=20
they, but it seems the shared irq are still used.

At this point I have two contradictory information.

=46or the best of my knowledge, I am inclined to agree with you.

Peter can you give your opinion ?

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
