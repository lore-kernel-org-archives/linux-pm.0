From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: Fix racing timers
Date: Wed, 27 Aug 2014 02:32:06 +0200
Message-ID: <19851825.qu8r5WDRRO@vostro.rjw.lan>
References: <1408568109-30297-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408568109-30297-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry for being somewhat slow to respond to this, but I'm not sure if t=
he
approach here is the right one.

On Wednesday, August 20, 2014 01:55:09 PM Soren Brinkmann wrote:
> On platforms that do not power off during suspend, successfully enter=
ing
> suspend races with timers.
>=20
> The race happening in a couple of location is:
>=20
>   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
>      ...
>   2. syscore_suspend()
>       -> timekeeping_suspend()
>        -> clockevents_notify(SUSPEND)
>         -> tick_suspend()   	(timers are turned off here)
>      ...
>   3. wfi            		(wait for wake-IRQ here)
>=20
> Between steps 1 and 2 the timers can still generate interrupts that a=
re
> not handled and stay pending until step 3. That pending IRQ causes an
> immediate - spurious - wake.

Well, the problem here is that the platform is not supposed to re-enabl=
e
interrupts after syscore_suspend().  Of course, some platforms do that,=
 because
they don't really support system sleep and try to emulate it with somet=
hing
along the lines of suspend-to-idle.

> The solution is to move the clockevents suspend/resume notification
> out of the syscore_suspend step and explictly call them at the approp=
riate
> time in the suspend/hibernation paths. I.e. timers are suspend _befor=
e_
> IRQs get disabled. And accordingly in the resume path.

While I don't see a particular reason why that would not work, modifyin=
g the
core to address platform-specific issues does not feel quite right. At =
least
the changelog is confusing as is, because this is a platform issue and =
not
a core issue being addressed.  Moreover, it could be argued that the pl=
atform
code enabling interrupts after syscore_suspend() should be responsible =
for
taking care of this, but that would probably lead to certain level of c=
ode
duplication between different platforms having the same problem, so I'm=
 not
really sure.

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> Hi,
>=20
> there was a little of an dicussion on the RFC for this patch, but tha=
t
> eventually ended (https://lkml.org/lkml/2014/7/21/493).
> In the meantime I found one small flaw that is fixed in this patch (c=
hangelog
> below).
> This resolves the issues I see on my Zynq (ARM) platform and I also p=
atched my
> Laptop's (x86_64) kernel with this where it looks good as well. Thoug=
h, in both
> cases only suspend is used. Any testing - especially of hibernation -=
 would
> be much appreciated.
>=20
> 	Thanks,
> 	S=C3=B6ren
>=20
> Changes since RFC:
>  - remove resume notification from syscore_resume path.
> ---
>  kernel/power/hibernate.c  | 9 +++++++++
>  kernel/power/suspend.c    | 5 +++++
>  kernel/time/timekeeping.c | 3 ---
>  3 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index a9dfa79b6bab..76f15644aec8 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -285,6 +285,8 @@ static int create_image(int platform_mode)
>  	if (error || hibernation_test(TEST_CPUS))
>  		goto Enable_cpus;
> =20
> +	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
> +
>  	local_irq_disable();
> =20
>  	error =3D syscore_suspend();
> @@ -316,6 +318,7 @@ static int create_image(int platform_mode)
>  	syscore_resume();
> =20
>   Enable_irqs:
> +	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
>  	local_irq_enable();
> =20
>   Enable_cpus:
> @@ -438,6 +441,8 @@ static int resume_target_kernel(bool platform_mod=
e)
>  	if (error)
>  		goto Enable_cpus;
> =20
> +	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
> +
>  	local_irq_disable();
> =20
>  	error =3D syscore_suspend();
> @@ -472,6 +477,7 @@ static int resume_target_kernel(bool platform_mod=
e)
>  	syscore_resume();
> =20
>   Enable_irqs:
> +	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
>  	local_irq_enable();
> =20
>   Enable_cpus:
> @@ -550,6 +556,8 @@ int hibernation_platform_enter(void)
>  	if (error)
>  		goto Platform_finish;
> =20
> +	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
> +
>  	local_irq_disable();
>  	syscore_suspend();
>  	if (pm_wakeup_pending()) {
> @@ -563,6 +571,7 @@ int hibernation_platform_enter(void)
> =20
>   Power_up:
>  	syscore_resume();
> +	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
>  	local_irq_enable();
>  	enable_nonboot_cpus();
> =20
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 6dadb25cb0d8..6bba2f907bcb 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -12,6 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> +#include <linux/clockchips.h>
>  #include <linux/console.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuidle.h>
> @@ -294,6 +295,8 @@ static int suspend_enter(suspend_state_t state, b=
ool *wakeup)
>  	if (error || suspend_test(TEST_CPUS))
>  		goto Enable_cpus;
> =20
> +	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
> +
>  	arch_suspend_disable_irqs();
>  	BUG_ON(!irqs_disabled());
> =20
> @@ -311,6 +314,8 @@ static int suspend_enter(suspend_state_t state, b=
ool *wakeup)
>  		syscore_resume();
>  	}
> =20
> +	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
> +
>  	arch_suspend_enable_irqs();
>  	BUG_ON(irqs_disabled());
> =20
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index fb4a9c2cf8d9..f13332185b07 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1188,8 +1188,6 @@ static void timekeeping_resume(void)
> =20
>  	touch_softlockup_watchdog();
> =20
> -	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
> -
>  	/* Resume hrtimers */
>  	hrtimers_resume();
>  }
> @@ -1242,7 +1240,6 @@ static int timekeeping_suspend(void)
>  	write_seqcount_end(&tk_core.seq);
>  	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
> =20
> -	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
>  	clocksource_suspend();
>  	clockevents_suspend();
> =20
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
