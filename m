From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
Date: Thu, 30 Jan 2014 14:44:00 +0100
Message-ID: <52EA5720.8010000@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org> <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org> <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr> <52E9C946.50704@linux.vnet.ibm.com> <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr>
Sender: linux-sh-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 01/30/2014 06:28 AM, Nicolas Pitre wrote:
> On Thu, 30 Jan 2014, Preeti U Murthy wrote:
>
>> Hi Nicolas,
>>
>> On 01/30/2014 02:01 AM, Nicolas Pitre wrote:
>>> On Wed, 29 Jan 2014, Nicolas Pitre wrote:
>>>
>>>> In order to integrate cpuidle with the scheduler, we must have a b=
etter
>>>> proximity in the core code with what cpuidle is doing and not dele=
gate
>>>> such interaction to arch code.
>>>>
>>>> Architectures implementing arch_cpu_idle() should simply enter
>>>> a cheap idle mode in the absence of a proper cpuidle driver.
>>>>
>>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> As mentioned in my reply to Olof's comment on patch #5/6, here's a =
new
>>> version of this patch adding the safety local_irq_enable() to the c=
ore
>>> code.
>>>
>>> ----- >8
>>>
>>> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>>> Subject: idle: move the cpuidle entry point to the generic idle loo=
p
>>>
>>> In order to integrate cpuidle with the scheduler, we must have a be=
tter
>>> proximity in the core code with what cpuidle is doing and not deleg=
ate
>>> such interaction to arch code.
>>>
>>> Architectures implementing arch_cpu_idle() should simply enter
>>> a cheap idle mode in the absence of a proper cpuidle driver.
>>>
>>> In both cases i.e. whether it is a cpuidle driver or the default
>>> arch_cpu_idle(), the calling convention expects IRQs to be disabled
>>> on entry and enabled on exit. There is a warning in place already b=
ut
>>> let's add a forced IRQ enable here as well.  This will allow for
>>> removing the forced IRQ enable some implementations do locally and
>>
>> Why would this patch allow for removing the forced IRQ enable that a=
re
>> being done on some archs in arch_cpu_idle()? Isn't this patch expect=
ing
>> the default arch_cpu_idle() to have re-enabled the interrupts after
>> exiting from the default idle state? Its supposed to only catch faul=
ty
>> cpuidle drivers that haven't enabled IRQs on exit from idle state bu=
t
>> are expected to have done so, isn't it?
>
> Exact.  However x86 currently does this:
>
> 	if (cpuidle_idle_call())
> 	        x86_idle();
> 	else
> 	        local_irq_enable();
>
> So whenever cpuidle_idle_call() is successful then IRQs are
> unconditionally enabled whether or not the underlying cpuidle driver =
has
> properly done it or not.  And the reason is that some of the x86 cpui=
dle
> do fail to enable IRQs before returning.
>
> So the idea is to get rid of this unconditional IRQ enabling and let =
the
> core issue a warning instead (as well as enabling IRQs to allow the
> system to run).

But what I don't get with your comment is the local_irq_enable is done=20
from the cpuidle common framework in 'cpuidle_enter_state' it is not=20
done from the arch specific backend cpuidle driver.

So the code above could be:

	if (cpuidle_idle_call())
		x86_idle();

without the else section, this local_irq_enable is pointless. Or may be=
=20
I missed something ?


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

