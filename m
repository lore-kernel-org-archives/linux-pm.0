From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle: Kernel panics with AMD Opteron 6300 entering C2 - clock
 related
Date: Thu, 18 Jun 2015 11:22:05 +0200
Message-ID: <55828DBD.5000109@linaro.org>
References: <55814696.1050803@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33991 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbbFRJWD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 05:22:03 -0400
Received: by wicnd19 with SMTP id nd19so16452031wic.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 02:22:02 -0700 (PDT)
In-Reply-To: <55814696.1050803@profitbricks.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Parschauer <sebastian.riemer@profitbricks.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On 06/17/2015 12:06 PM, Sebastian Parschauer wrote:
> Hi cpuidle maintainers,
>
> we notice kernel panics with CPUs from the AMD Opteron 6300 series an=
d
> kernel 3.12 when entering C2. In that C-state the clock is shut down =
but
> the flag CPUIDLE_FLAG_TIMER_STOP isn't set. We use the TSC clock sour=
ce
> for performance as our servers host KVM VMs. During the panics
> interrupts are enabled again and the timer interrupt corrupts the
> instruction pointer and/or the stack pointer.
>
> Would it help to set the flag CPUIDLE_FLAG_TIMER_STOP for C2?
> Or how to fix this?

Did you try the flag ? Does it fix it ?

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Additional debug info:
>
> BUG: unable to handle kernel NULL pointer dereference at           (n=
ull)
> IP: [<          (null)>]           (null)
> ...
> Call trace:
> [<ffffffff815af9b5>] cpuidle_idle_call+0xc5/0x150
> [<ffffffff8100b529>] arch_cpu_idle+0x9/0x20
> [<ffffffff81092e6f>] cpu_startup_entry+0xaf/0x240
> [<ffffffff8102df4b>] start_secondary+0x1db/0x240
>
> The CPUs provide three C-states:
> 0: POLL
> 1: C1
> 2: C2
>
> C2 information from the crash dump:
>
>> {
>>        name =3D "C2\000\000\000\000\000\000\000\000\000\000\000\000\=
000",
>>        desc =3D "ACPI IOPORT 0x815\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000",
>>        flags =3D 1,
>>        exit_latency =3D 100,
>>        power_usage =3D 0,
>>        target_residency =3D 200,
>>        disabled =3D false,
>>        enter =3D 0xffffffffa00ab026 <acpi_idle_enter_simple>,
>>        enter_dead =3D 0xffffffffa00aa39c <acpi_idle_play_dead>
>> }
>
> Assembly level analysis:
>
>> RDX: 0000000225c17d03
>
> So EDX is 00000002 and that's the entered state C2.
>
>> RDI: ffffffff81c15540
>> ..
>> crash> info symbol 0xffffffff81c15540
>> clocksource_tsc in section .data
>>
>> crash> disassemble cpuidle_enter_state
>> ...
>>     0xffffffff815af5fc <+60>:    callq  0xffffffff8109b360 <ktime_ge=
t>
>>     0xffffffff815af601 <+65>:    sti
>>     0xffffffff815af602 <+66>:    sub    %r13,%rax <- here rdi still =
points to clocksource_tsc
>>     0xffffffff815af605 <+69>:    mov    %rax,%rdi <- rdi is overwrit=
ten by the ktime_get return address


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

