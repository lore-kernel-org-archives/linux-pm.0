From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/6] sched: idle: cpuidle: Check the latency req before
 idle
Date: Mon, 10 Nov 2014 16:12:47 +0100
Message-ID: <5460D5EF.2000805@linaro.org>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org> <1415370687-18688-3-git-send-email-daniel.lezcano@linaro.org> <20141110124111.GN3337@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:47993 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbaKJPM5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 10:12:57 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so10699859wid.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 07:12:56 -0800 (PST)
In-Reply-To: <20141110124111.GN3337@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 11/10/2014 01:41 PM, Peter Zijlstra wrote:
> On Fri, Nov 07, 2014 at 03:31:23PM +0100, Daniel Lezcano wrote:
>> @@ -216,19 +219,26 @@ static void cpu_idle_loop(void)
>>   			local_irq_disable();
>>   			arch_cpu_idle_enter();
>>
>> +			latency_req =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>> +
>>   			/*
>>   			 * In poll mode we reenable interrupts and spin.
>>   			 *
>> +			 * If the latency req is zero, we don't want to
>> +			 * enter any idle state and we jump to the poll
>> +			 * function directly
>> +			 *
>>   			 * Also if we detected in the wakeup from idle
>>   			 * path that the tick broadcast device expired
>>   			 * for us, we don't want to go deep idle as we
>>   			 * know that the IPI is going to arrive right
>>   			 * away
>>   			 */
>> -			if (cpu_idle_force_poll || tick_check_broadcast_expired())
>> +			if (!latency_req || cpu_idle_force_poll ||
>> +			    tick_check_broadcast_expired())
>>   				cpu_idle_poll();
>
> Is this why you wanted that weak poll function?

Not only there, it will be added in the next patchset in the=20
cpu_idle_call function.

> Should we not instead allow an arch to deal with !latency_req and onl=
y
> fall back to this polling if there is no actual way for it to impleme=
nt
> this better?

All this is to remove the poll idle state from the x86 cpuidle driver i=
n=20
order to remove the CPUIDLE_DRIVER_STATE_START (this one forces to writ=
e=20
always ugly code in the cpuidle framework).

This poll state introduces the CPUIDLE_DRIVER_STATE_START macro. If you=
=20
look at the different governors and the code, you can checkout what kin=
d=20
of tricks this macro introduces and how that makes the code ugly.

=46or the sake of what ? Just a small optimization in the menu governor=
=2E

I suppose that has been introduce and then evolved on a wrong basis. So=
=20
now we have to deal with that.

This patchset provides a first round of cleanup around the poll=20
function, the next patchset will move the 5us timer optimization from=20
the menu governor and the last patchset will remove the=20
CPUIDLE_DRIVER_STATE_START ugly macro.





--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

