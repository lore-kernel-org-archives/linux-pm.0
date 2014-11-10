From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/6] sched: idle: cpuidle: Check the latency req before
 idle
Date: Mon, 10 Nov 2014 18:19:02 +0100
Message-ID: <5460F386.1050109@linaro.org>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org> <1415370687-18688-3-git-send-email-daniel.lezcano@linaro.org> <20141110124111.GN3337@twins.programming.kicks-ass.net> <5460D5EF.2000805@linaro.org> <20141110152803.GX10501@worktop.programming.kicks-ass.net> <5460E0A5.9040508@linaro.org> <20141110161530.GB10501@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33381 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbaKJRYw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 12:24:52 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so9434537wgg.17
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 09:24:51 -0800 (PST)
In-Reply-To: <20141110161530.GB10501@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 11/10/2014 05:15 PM, Peter Zijlstra wrote:
> On Mon, Nov 10, 2014 at 04:58:29PM +0100, Daniel Lezcano wrote:
>>> I don't get it, I've clearly not stared at it long enough, but why =
is
>>> that STATE_START crap needed anywhere?
>>
>> Excellent question :)
>>
>> On x86, the config option ARCH_HAS_CPU_RELAX is set (x86 is the only=
 one).
>> That leads to the macro CPUIDLE_DRIVER_STATE_START equal 1.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tre=
e/include/linux/cpuidle.h#n221
>>
>> Then the acpi cpuidle driver and the intel_driver begin to fill the =
idle
>> state at index =3D=3D CPUIDLE_DRIVER_STATE_START, so leaving the 0th=
 idle state
>> empty.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tre=
e/drivers/idle/intel_idle.c#n848
>>
>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tre=
e/drivers/acpi/processor_idle.c#n953
>>
>> Then when the driver is registered and if ARCH_HAS_CPU_RELAX is set,=
 the
>> cpuidle framework insert the 0th with the poll state (reminder : onl=
y for
>> x86).
>
> Appears to me part of the problem is right there, the intel_idle and
> proessor_idle should register the poll state themselves. That
> immediately makes this weirdness go away.
>
> Registering states from two places is not something that's sane or
> desired I think.

I fully agree. I did a patchset in this direction but I realized the=20
poll state most of the cases was not used.

>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tre=
e/drivers/cpuidle/driver.c#n195
>>
>> If you look at the ladder governor (which I believe nobody is still =
using
>> it), or at the menu governor, all the indexes begin at
>> CPUIDLE_DRIVER_STATE_START, so all the code is preventing to use the=
 0th
>> state ... :)
>>
>> So why is needed the poll state ?
>>
>> 1. When the latency_req is 0 (it returns 0, so the poll state)
>
> Right, that makes sense.
>
>> 2. When the select's menu governor fails to find a state *and* if th=
e next
>> timer is before 5us
>
> That seems rather arbitrary.

Yeah, and I am wondering if this very particular optimization couldn't=20
be just removed. Is there still a benefit ?

> Why would it fail to find a state?

To do short: it could fail to find a state fulfilling the constraints=20
(some states could be disabled or the ).

>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tre=
e/drivers/cpuidle/driver.c#n195
>>
>> And when we investigate the same code but on the other archs, the
>> CPUIDLE_DRIVER_STATE_START dance makes things slightly different.
>>
>> So the conclusion is, we are inserting a state in the idle state arr=
ay but
>> we do everything to prevent to use it :)
>>
>> For me it appears logical to just kill this state from the x86 idle =
drivers
>> and move it in the idle_mainloop in case an idle state selection fai=
ls.
>
> But why, ppc has a latency_req=3D=3D0 state too, right?

Yes, this is why the arch_cpu_poll_idle, so ppc can override it with it=
s=20
optimized pooling loop (rep(); nop(); is x86).

> I agree that we should shoot STATE_START in the head, but I feel we
> should do it by fixing the state registration.

You can fix the state registration but that won't fix the STATE_START=20
usage in the governors.

> I really don't get why the governors should know about this though, i=
ts
> just another state, they should iterate all states and pick the best,
> given the power usage this state should really never be eligible unle=
ss
> we're QoS forced or whatnot.

The governors just don't use the poll state at all, except for a couple=
=20
of cases in menu.c defined above in the previous email. What is the=20
rational of adding a state in the cpuidle driver and do everything we=20
can to avoid using it ? From my POV, the poll state is a special state,=
=20
we should remove from the driver's idle states like the arch_cpu_idle()=
=20
is a specific idle state only used in idle.c (but which may overlap wit=
h=20
an idle state in different archs eg. cpu_do_idle() and the 0th idle sta=
te).


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

