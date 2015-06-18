From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle: Kernel panics with AMD Opteron 6300 entering C2 - clock
 related
Date: Thu, 18 Jun 2015 15:23:56 +0200
Message-ID: <5582C66C.1060301@linaro.org>
References: <55814696.1050803@profitbricks.com> <55828DBD.5000109@linaro.org> <5582A2DC.7060001@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37552 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbFRNXy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 09:23:54 -0400
Received: by wicgi11 with SMTP id gi11so13716550wic.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 06:23:52 -0700 (PDT)
In-Reply-To: <5582A2DC.7060001@profitbricks.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Parschauer <sebastian.riemer@profitbricks.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On 06/18/2015 12:52 PM, Sebastian Parschauer wrote:
> On 18.06.2015 11:22, Daniel Lezcano wrote:
>> On 06/17/2015 12:06 PM, Sebastian Parschauer wrote:
>>> Hi cpuidle maintainers,
>>>
>>> we notice kernel panics with CPUs from the AMD Opteron 6300 series =
and
>>> kernel 3.12 when entering C2. In that C-state the clock is shut dow=
n but
>>> the flag CPUIDLE_FLAG_TIMER_STOP isn't set. We use the TSC clock so=
urce
>>> for performance as our servers host KVM VMs. During the panics
>>> interrupts are enabled again and the timer interrupt corrupts the
>>> instruction pointer and/or the stack pointer.
>>>
>>> Would it help to set the flag CPUIDLE_FLAG_TIMER_STOP for C2?
>>> Or how to fix this?
>>
>> Did you try the flag ? Does it fix it ?
>
> Thanks for your reply. Unfortunately we can't roll out new kernels fa=
st
> (VMs have to be migrated). But we've disabled the C2 state via sysfs =
for
> all CPU cores and all servers and had one more kernel panic with the
> same call trace although C2 was (or should have been) disabled. We us=
e
> the menu governor and a v3.12.40 kernel.
>
> It's strange to me coming into the same code path with state index 2 =
as
> parameter again. I think I'll prepare a kernel with some debug messag=
es
> when transitioning from one state to another and deploy it to a test =
system.

It is weird you disabled the state index 2 and the system enters with=20
this index again.

Are you sure you disabled effectively for all cores on the system this=20
state ?

=46urthermore, if I am not wrong the C state on AMD differs a bit from =
the=20
C-state intel's semantic.

The firmware will put the cluster down if all core go to the C1 state, =
no ?

> Is there any better method to debug the cpuidle driver?

You can try by passing to the kernel command line:

processor.max_cstate=3D1

Note, that does not guarantee the firmware won't promote to a deeper=20
idle state.

If the kernel panics again, may be in the BIOS, there is an option to=20
set max idle states for the firmware.

> How do you guys test it?

On the x86 platform, most of the magic is in the firmware, so if there=20
is a bug there, hmm ... that will be hard to spot.

> Can we provide any missing additional information?
>
> Maybe something else corrupts the memory in an interrupt and the cpui=
dle
> driver is just the one noticing an unrelated problem.



>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Additional debug info:
>>>
>>> BUG: unable to handle kernel NULL pointer dereference at           =
(null)
>>> IP: [<          (null)>]           (null)
>>> ...
>>> Call trace:
>>> [<ffffffff815af9b5>] cpuidle_idle_call+0xc5/0x150
>>> [<ffffffff8100b529>] arch_cpu_idle+0x9/0x20
>>> [<ffffffff81092e6f>] cpu_startup_entry+0xaf/0x240
>>> [<ffffffff8102df4b>] start_secondary+0x1db/0x240
>>>
>>> The CPUs provide three C-states:
>>> 0: POLL
>>> 1: C1
>>> 2: C2
>>>
>>> C2 information from the crash dump:
>>>
>>>> {
>>>>         name =3D "C2\000\000\000\000\000\000\000\000\000\000\000\0=
00\000",
>>>>         desc =3D "ACPI IOPORT
>>>> 0x815\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
>>>>         flags =3D 1,
>>>>         exit_latency =3D 100,
>>>>         power_usage =3D 0,
>>>>         target_residency =3D 200,
>>>>         disabled =3D false,
>>>>         enter =3D 0xffffffffa00ab026 <acpi_idle_enter_simple>,
>>>>         enter_dead =3D 0xffffffffa00aa39c <acpi_idle_play_dead>
>>>> }
>>>
>>> Assembly level analysis:
>>>
>>>> RDX: 0000000225c17d03
>>>
>>> So EDX is 00000002 and that's the entered state C2.
>>>
>>>> RDI: ffffffff81c15540
>>>> ..
>>>> crash> info symbol 0xffffffff81c15540
>>>> clocksource_tsc in section .data
>>>>
>>>> crash> disassemble cpuidle_enter_state
>>>> ...
>>>>      0xffffffff815af5fc <+60>:    callq  0xffffffff8109b360 <ktime=
_get>
>>>>      0xffffffff815af601 <+65>:    sti
>>>>      0xffffffff815af602 <+66>:    sub    %r13,%rax <- here rdi sti=
ll
>>>> points to clocksource_tsc
>>>>      0xffffffff815af605 <+69>:    mov    %rax,%rdi <- rdi is
>>>> overwritten by the ktime_get return address
>>
>>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

