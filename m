From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] tick: fix tick_broadcast_pending_mask not cleared
Date: Fri, 21 Jun 2013 11:15:37 +0200
Message-ID: <51C419B9.10001@linaro.org>
References: <1371485735-31249-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:41980 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758442Ab3FUJPb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2013 05:15:31 -0400
Received: by mail-bk0-f53.google.com with SMTP id e11so3267942bkh.12
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2013 02:15:29 -0700 (PDT)
In-Reply-To: <1371485735-31249-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de
Cc: josephl@nvidia.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patche@linaro.org, linaro-kernel@lists.linaro.org


Hi Thomas,

any news on this patch ?


On 06/17/2013 06:15 PM, Daniel Lezcano wrote:
> The recent modification in the cpuidle framework consolidated the tim=
er
> broadcast code across the different drivers by setting a new flag in =
the idle
> state. It tells the cpuidle core code to enter/exit to the broadcast =
mode for
> the cpu when entering a deep idle state. The broadcast timer enter/ex=
it is no
> longer handled by the back-end driver.
>=20
> This change made the local interrupt to be enabled *before* calling
> CLOCK_EVENT_NOTIFY_EXIT. bad or not (see below) ?
>=20
> On a tegra114, a four cores system, when the flag has been introduced=
 in the
> driver, the following warning appeared:
>=20
> [   25.629559] WARNING: CPU: 2 PID: 0 at
> kernel/time/tick-broadcast.c:578 tick_broadcast_oneshot_control
> +0x1a4/0x1d0()
> [   25.629565] Modules linked in:
> [   25.629574] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
> 3.10.0-rc3-next-20130529+ #15
> [   25.629601] [<c00148f4>] (unwind_backtrace+0x0/0xf8) from
> [<c0011040>] (show_stack+0x10/0x14)
> [   25.629616] [<c0011040>] (show_stack+0x10/0x14) from [<c0504248>]
> (dump_stack+0x80/0xc4)
> [   25.629633] [<c0504248>] (dump_stack+0x80/0xc4) from [<c00231ac>]
> (warn_slowpath_common+0x64/0x88)
> [   25.629646] [<c00231ac>] (warn_slowpath_common+0x64/0x88) from
> [<c00231ec>] (warn_slowpath_null+0x1c/0x24)
> [   25.629657] [<c00231ec>] (warn_slowpath_null+0x1c/0x24) from
> [<c00667f8>] (tick_broadcast_oneshot_control+0x1a4/0x1d0)
> [   25.629670] [<c00667f8>] (tick_broadcast_oneshot_control+0x1a4/0x1=
d0)
> from [<c0065cd0>] (tick_notify+0x240/0x40c)
> [   25.629685] [<c0065cd0>] (tick_notify+0x240/0x40c) from [<c0044724=
>]
> (notifier_call_chain+0x44/0x84)
> [   25.629699] [<c0044724>] (notifier_call_chain+0x44/0x84) from
> [<c0044828>] (raw_notifier_call_chain+0x18/0x20)
> [   25.629712] [<c0044828>] (raw_notifier_call_chain+0x18/0x20) from
> [<c00650cc>] (clockevents_notify+0x28/0x170)
> [   25.629726] [<c00650cc>] (clockevents_notify+0x28/0x170) from
> [<c033f1f0>] (cpuidle_idle_call+0x11c/0x168)
> [   25.629739] [<c033f1f0>] (cpuidle_idle_call+0x11c/0x168) from
> [<c000ea94>] (arch_cpu_idle+0x8/0x38)
> [   25.629755] [<c000ea94>] (arch_cpu_idle+0x8/0x38) from [<c005ea80>=
]
> (cpu_startup_entry+0x60/0x134)
> [   25.629767] [<c005ea80>] (cpu_startup_entry+0x60/0x134) from
> [<804fe9a4>] (0x804fe9a4)
> [   25.629772] ---[ end trace 5484e77e2531bccc ]---
>=20
> I don't have the hardware, so I wasn't able to reproduce the warning =
but after
> looking a while in the code, I deduced the following:
>=20
>  1. the CPU2 enters a deep idle state and sets the broadcast timer
>  2. the timer expires, the tick_handle_oneshot_broadcast function is =
called,
>     setting the tick_broadcast_pending_mask and waking up the idle cp=
u CPU2
>  3. the CPU2 exits idle and invokes tick_broadcast_oneshot_control wi=
th
>     CLOCK_EVENT_NOTIFY_EXIT with the following code:
>     [...]
>     if (dev->next_event.tv64 =3D=3D KTIME_MAX)
>             goto out;
>=20
>     if (cpumask_test_and_clear_cpu(cpu,
>                                  tick_broadcast_pending_mask))
>             goto out;
>     [...]
>=20
>  4. if there is no next event planned for CPU2, we fulfil the first c=
ondition and
>     we jump to the 'out' section without clearing the tick_broadcast_=
pending_mask
>=20
>  5. CPU2 goes to deep idle again and calls tick_broadcast_oneshot_con=
trol with
>     CLOCK_NOTIFY_EVENT_ENTER but with the tick_broadcast_pending_mask=
 set for
>     CPU2, leading to the WARNING.
>=20
> Above, it is mentionned the change moved the CLOCK_EVENT_NOTIFY_EXIT =
after the
> local interrupt were enabled. If it is before, this warning does not =
occur. My
> hypothesis is the code path described before does not happen because =
when a
> broadcast timer expires, dev->next_event.tv64 is always different fro=
m KTIME_MAX
> because the timer handler did not set the value yet (local interrupt =
are still
> disabled).
>=20
> I don't see anywhere in the code, a clockevents_notify(ENTER/EXIT) bl=
ock must be
> done with the local interrupt disabled in between, furthermore the fu=
nction uses
> 'raw_spin_lock_irqsave' which make me think, we don't care about that=
=2E
>=20
> Invert the conditions and make the tick broadcast code immune from th=
e local
> interrupts context.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Joseph Lo <josephl@nvidia.com>
> ---
>  kernel/time/tick-broadcast.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcas=
t.c
> index d067c01..58d88e8 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -610,8 +610,6 @@ void tick_broadcast_oneshot_control(unsigned long=
 reason)
>  	} else {
>  		if (cpumask_test_and_clear_cpu(cpu, tick_broadcast_oneshot_mask)) =
{
>  			clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT);
> -			if (dev->next_event.tv64 =3D=3D KTIME_MAX)
> -				goto out;
>  			/*
>  			 * The cpu which was handling the broadcast
>  			 * timer marked this cpu in the broadcast
> @@ -625,6 +623,8 @@ void tick_broadcast_oneshot_control(unsigned long=
 reason)
>  				       tick_broadcast_pending_mask))
>  				goto out;
> =20
> +			if (dev->next_event.tv64 =3D=3D KTIME_MAX)
> +				goto out;
>  			/*
>  			 * If the pending bit is not set, then we are
>  			 * either the CPU handling the broadcast
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

