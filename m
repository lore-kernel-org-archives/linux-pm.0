From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
Date: Thu, 30 Jan 2014 18:28:52 +0100
Message-ID: <52EA8BD4.6020803@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org> <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org> <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr> <52E9C946.50704@linux.vnet.ibm.com> <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr> <52EA5720.8010000@linaro.org> <alpine.LFD.2.11.1401301056180.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1401301056180.1652@knanqh.ubzr>
Sender: linux-sh-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 01/30/2014 05:07 PM, Nicolas Pitre wrote:
> On Thu, 30 Jan 2014, Daniel Lezcano wrote:
>
>> On 01/30/2014 06:28 AM, Nicolas Pitre wrote:
>>> On Thu, 30 Jan 2014, Preeti U Murthy wrote:
>>>
>>>> Hi Nicolas,
>>>>
>>>> On 01/30/2014 02:01 AM, Nicolas Pitre wrote:
>>>>> On Wed, 29 Jan 2014, Nicolas Pitre wrote:
>>>>>
>>>>>> In order to integrate cpuidle with the scheduler, we must have a
>>>>>> better
>>>>>> proximity in the core code with what cpuidle is doing and not de=
legate
>>>>>> such interaction to arch code.
>>>>>>
>>>>>> Architectures implementing arch_cpu_idle() should simply enter
>>>>>> a cheap idle mode in the absence of a proper cpuidle driver.
>>>>>>
>>>>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>>>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>
>>>>> As mentioned in my reply to Olof's comment on patch #5/6, here's =
a new
>>>>> version of this patch adding the safety local_irq_enable() to the=
 core
>>>>> code.
>>>>>
>>>>> ----- >8
>>>>>
>>>>> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>>>>> Subject: idle: move the cpuidle entry point to the generic idle l=
oop
>>>>>
>>>>> In order to integrate cpuidle with the scheduler, we must have a =
better
>>>>> proximity in the core code with what cpuidle is doing and not del=
egate
>>>>> such interaction to arch code.
>>>>>
>>>>> Architectures implementing arch_cpu_idle() should simply enter
>>>>> a cheap idle mode in the absence of a proper cpuidle driver.
>>>>>
>>>>> In both cases i.e. whether it is a cpuidle driver or the default
>>>>> arch_cpu_idle(), the calling convention expects IRQs to be disabl=
ed
>>>>> on entry and enabled on exit. There is a warning in place already=
 but
>>>>> let's add a forced IRQ enable here as well.  This will allow for
>>>>> removing the forced IRQ enable some implementations do locally an=
d
>>>>
>>>> Why would this patch allow for removing the forced IRQ enable that=
 are
>>>> being done on some archs in arch_cpu_idle()? Isn't this patch expe=
cting
>>>> the default arch_cpu_idle() to have re-enabled the interrupts afte=
r
>>>> exiting from the default idle state? Its supposed to only catch fa=
ulty
>>>> cpuidle drivers that haven't enabled IRQs on exit from idle state =
but
>>>> are expected to have done so, isn't it?
>>>
>>> Exact.  However x86 currently does this:
>>>
>>>   if (cpuidle_idle_call())
>>>           x86_idle();
>>>   else
>>>           local_irq_enable();
>>>
>>> So whenever cpuidle_idle_call() is successful then IRQs are
>>> unconditionally enabled whether or not the underlying cpuidle drive=
r has
>>> properly done it or not.  And the reason is that some of the x86 cp=
uidle
>>> do fail to enable IRQs before returning.
>>>
>>> So the idea is to get rid of this unconditional IRQ enabling and le=
t the
>>> core issue a warning instead (as well as enabling IRQs to allow the
>>> system to run).
>>
>> But what I don't get with your comment is the local_irq_enable is do=
ne from
>> the cpuidle common framework in 'cpuidle_enter_state' it is not done=
 from the
>> arch specific backend cpuidle driver.
>
> Oh well... This certainly means we'll have to clean this mess as some
> drivers do it on their own while some others don't.  Some drivers als=
o
> loop on !need_resched() while some others simply return on the first
> interrupt.

Ok, I think the mess is coming from 'default_idle' which does not=20
re-enable the local_irq but used from different places like=20
amd_e400_idle and apm_cpu_idle.

void default_idle(void)
{
         trace_cpu_idle_rcuidle(1, smp_processor_id());
         safe_halt();
         trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
}

Considering the system configured without cpuidle because this one=20
*always* enable the local irq, we have the different cases:

x86_idle =3D default_idle();
=3D=3D> local_irq_enable is missing

x86_idle =3D amd_e400_idle();
=3D=3D> it calls local_irq_disable(); but in the idle loop context wher=
e the=20
local irqs are already disabled.
=3D=3D> if amd_e400_c1e_detected is true, the local_irq are enabled
=3D=3D> otherwise no
=3D=3D> default_idle is called from there and does not enable local_irq=
s


>> So the code above could be:
>>
>> 	if (cpuidle_idle_call())
>> 		x86_idle();
>>
>> without the else section, this local_irq_enable is pointless. Or may=
 be I
>> missed something ?
>
> A later patch removes it anyway.  But if it is really necessary to
> enable interrupts then the core will do it but with a warning now.

This WARN should disappear. It was there because it was up to the=20
backend cpuidle driver to enable the irq. But in the meantime, that was=
=20
consolidated into a single place in the cpuidle framework so no need to=
=20
try to catch errors.

What about (based on this patchset).

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 4505e2a..2d60cbb 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -299,6 +299,7 @@ void arch_cpu_idle_dead(void)
  void arch_cpu_idle(void)
  {
         x86_idle();
+       local_irq_enable();
  }

  /*



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

