From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/6] sched: idle: cpuidle: Check the latency req before
 idle
Date: Mon, 10 Nov 2014 16:58:29 +0100
Message-ID: <5460E0A5.9040508@linaro.org>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org> <1415370687-18688-3-git-send-email-daniel.lezcano@linaro.org> <20141110124111.GN3337@twins.programming.kicks-ass.net> <5460D5EF.2000805@linaro.org> <20141110152803.GX10501@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35889 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaKJP6d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 10:58:33 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so9233668wgh.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 07:58:32 -0800 (PST)
In-Reply-To: <20141110152803.GX10501@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 11/10/2014 04:28 PM, Peter Zijlstra wrote:
> On Mon, Nov 10, 2014 at 04:12:47PM +0100, Daniel Lezcano wrote:
>> All this is to remove the poll idle state from the x86 cpuidle drive=
r in
>> order to remove the CPUIDLE_DRIVER_STATE_START (this one forces to w=
rite
>> always ugly code in the cpuidle framework).
>>
>> This poll state introduces the CPUIDLE_DRIVER_STATE_START macro. If =
you look
>> at the different governors and the code, you can checkout what kind =
of
>> tricks this macro introduces and how that makes the code ugly.
>>
>> For the sake of what ? Just a small optimization in the menu governo=
r.
>>
>> I suppose that has been introduce and then evolved on a wrong basis.=
 So now
>> we have to deal with that.
>>
>> This patchset provides a first round of cleanup around the poll func=
tion,
>> the next patchset will move the 5us timer optimization from the menu
>> governor and the last patchset will remove the CPUIDLE_DRIVER_STATE_=
START
>> ugly macro.
>
> I don't get it, I've clearly not stared at it long enough, but why is
> that STATE_START crap needed anywhere?

Excellent question :)

On x86, the config option ARCH_HAS_CPU_RELAX is set (x86 is the only=20
one). That leads to the macro CPUIDLE_DRIVER_STATE_START equal 1.

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tree/i=
nclude/linux/cpuidle.h#n221

Then the acpi cpuidle driver and the intel_driver begin to fill the idl=
e=20
state at index =3D=3D CPUIDLE_DRIVER_STATE_START, so leaving the 0th id=
le=20
state empty.

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tree/d=
rivers/idle/intel_idle.c#n848

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tree/d=
rivers/acpi/processor_idle.c#n953

Then when the driver is registered and if ARCH_HAS_CPU_RELAX is set, th=
e=20
cpuidle framework insert the 0th with the poll state (reminder : only=20
for x86).

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tree/d=
rivers/cpuidle/driver.c#n195

If you look at the ladder governor (which I believe nobody is still=20
using it), or at the menu governor, all the indexes begin at=20
CPUIDLE_DRIVER_STATE_START, so all the code is preventing to use the 0t=
h=20
state ... :)

So why is needed the poll state ?

1. When the latency_req is 0 (it returns 0, so the poll state)

2. When the select's menu governor fails to find a state *and* if the=20
next timer is before 5us

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/tree/d=
rivers/cpuidle/driver.c#n195

And when we investigate the same code but on the other archs, the=20
CPUIDLE_DRIVER_STATE_START dance makes things slightly different.

So the conclusion is, we are inserting a state in the idle state array=20
but we do everything to prevent to use it :)

=46or me it appears logical to just kill this state from the x86 idle=20
drivers and move it in the idle_mainloop in case an idle state selectio=
n=20
fails.



> To me it appears 'natural' to have a latency_req=3D=3D0 state, why do=
es it
> need so much special casing?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

