From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [3/3] 2.6.23-rc6: known regressions v2
Date: Mon, 17 Sep 2007 21:44:43 +0200
Message-ID: <200709172144.43761.arekm__11562.715660739$1190058418$gmane$org@maven.pl>
References: <46EB3EF8.6040103@googlemail.com> <46EB4374.50104@googlemail.com>
	<200709152020.33179.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709152020.33179.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Thomas Voegtle <tv@lio96.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 15 of September 2007, Rafael J. Wysocki wrote:
> On Saturday, 15 September 2007 04:29, Michal Piotrowski wrote:

> > Subject         : resume from ram much slower
> > References      : http://lkml.org/lkml/2007/8/10/275
> > Last known good : 2.6.23-rc1 ?
> > Submitter       : Arkadiusz Miskiewicz <arekm@maven.pl>
> > Caused-By       : ?
> > Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
> > Status          : problem is being debugged
>
> Unresolved, bisection might be helpful.

Took 16 hours of bisecting and playing with stuff.

It looks like the problematic patch is 18de5bc4c1f1f1fa5e14f354a7603bd6e9=
d4e3b6.
bisection was hard and I'm 95% sure that this is the problematic patch.
I'm currently using 2.6.23-rc6 with this reverted and so far resume works=
 as it should.


commit 18de5bc4c1f1f1fa5e14f354a7603bd6e9d4e3b6
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Sat Jul 21 04:37:34 2007 -0700

    clockevents: fix resume logic
   =20
    We need to make sure, that the clockevent devices are resumed, before
    the tick is resumed. The current resume logic does not guarantee this.
   =20
    Add CLOCK_EVT_MODE_RESUME and call the set mode functions of the cloc=
k
    event devices before resuming the tick / oneshot functionality.
   =20
    Fixup the existing users.
   =20
    Thanks to Nigel Cunningham for tracking down a long standing thinko,
    which affected the jinxed VAIO.
   =20
    [akpm@linux-foundation.org: xen build fix]
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: john stultz <johnstul@us.ibm.com>
    Cc: Rusty Russell <rusty@rustcorp.com.au>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 4d8425d..e96a3dc 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -285,6 +285,8 @@ static void davinci_set_mode(enum clock_event_mode mo=
de,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		t->opts =3D TIMER_OPTS_DISABLED;
 		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
 }
=20
diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 010f6fa..d86d124 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -159,6 +159,7 @@ static void imx_set_mode(enum clock_event_mode mode, =
struct clock_event_device *
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
 		/* Left event sources disabled, no more interrupts appears */
 		break;
 	}
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.=
c
index 8112f72..23e7fba 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -459,6 +459,8 @@ static void ixp4xx_set_mode(enum clock_event_mode mod=
e,
 	default:
 		osrt =3D opts =3D 0;
 		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
=20
 	*IXP4XX_OSRT1 =3D osrt | opts;
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 3705d20..237651e 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -156,6 +156,7 @@ static void omap_mpu_set_mode(enum clock_event_mode m=
ode,
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
 		break;
 	}
 }
diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.=
c
index 2feceec..b0af014 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -156,6 +156,8 @@ static void omap_32k_timer_set_mode(enum clock_event_=
mode mode,
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		omap_32k_timer_stop();
 		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
 }
=20
diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
index 67824f3..610f44b 100644
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -263,6 +263,9 @@ static void lapic_timer_setup(enum clock_event_mode m=
ode,
 		v |=3D (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
 		apic_write_around(APIC_LVTT, v);
 		break;
+	case CLOCK_EVT_MODE_RESUME:
+		/* Nothing to do here */
+		break;
 	}
=20
 	local_irq_restore(flags);
diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
index 17d7345..cfbf792 100644
--- a/arch/i386/kernel/hpet.c
+++ b/arch/i386/kernel/hpet.c
@@ -187,6 +187,10 @@ static void hpet_set_mode(enum clock_event_mode mode=
,
 		cfg &=3D ~HPET_TN_ENABLE;
 		hpet_writel(cfg, HPET_T0_CFG);
 		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		hpet_enable_int();
+		break;
 	}
 }
=20
@@ -217,6 +221,7 @@ static struct clocksource clocksource_hpet =3D {
 	.mask		=3D HPET_MASK,
 	.shift		=3D HPET_SHIFT,
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.resume		=3D hpet_start_counter,
 };
=20
 /*
@@ -291,7 +296,6 @@ int __init hpet_enable(void)
=20
 	clocksource_register(&clocksource_hpet);
=20
-
 	if (id & HPET_ID_LEGSUP) {
 		hpet_enable_int();
 		hpet_reserve_platform_timers(id);
@@ -524,68 +528,3 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id=
)
 	return IRQ_HANDLED;
 }
 #endif
-
-
-/*
- * Suspend/resume part
- */
-
-#ifdef CONFIG_PM
-
-static int hpet_suspend(struct sys_device *sys_device, pm_message_t stat=
e)
-{
-	unsigned long cfg =3D hpet_readl(HPET_CFG);
-
-	cfg &=3D ~(HPET_CFG_ENABLE|HPET_CFG_LEGACY);
-	hpet_writel(cfg, HPET_CFG);
-
-	return 0;
-}
-
-static int hpet_resume(struct sys_device *sys_device)
-{
-	unsigned int id;
-
-	hpet_start_counter();
-
-	id =3D hpet_readl(HPET_ID);
-
-	if (id & HPET_ID_LEGSUP)
-		hpet_enable_int();
-
-	return 0;
-}
-
-static struct sysdev_class hpet_class =3D {
-	set_kset_name("hpet"),
-	.suspend	=3D hpet_suspend,
-	.resume		=3D hpet_resume,
-};
-
-static struct sys_device hpet_device =3D {
-	.id		=3D 0,
-	.cls		=3D &hpet_class,
-};
-
-
-static __init int hpet_register_sysfs(void)
-{
-	int err;
-
-	if (!is_hpet_capable())
-		return 0;
-
-	err =3D sysdev_class_register(&hpet_class);
-
-	if (!err) {
-		err =3D sysdev_register(&hpet_device);
-		if (err)
-			sysdev_class_unregister(&hpet_class);
-	}
-
-	return err;
-}
-
-device_initcall(hpet_register_sysfs);
-
-#endif
diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
index f8a3c40..931eabe 100644
--- a/arch/i386/kernel/i8253.c
+++ b/arch/i386/kernel/i8253.c
@@ -3,11 +3,11 @@
  *
  */
 #include <linux/clockchips.h>
-#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
-#include <linux/sysdev.h>
 #include <linux/module.h>
-#include <linux/init.h>
+#include <linux/spinlock.h>
=20
 #include <asm/smp.h>
 #include <asm/delay.h>
@@ -41,26 +41,24 @@ static void init_pit_timer(enum clock_event_mode mode=
,
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* binary, mode 2, LSB/MSB, ch 0 */
 		outb_p(0x34, PIT_MODE);
-		udelay(10);
 		outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
-		udelay(10);
 		outb(LATCH >> 8 , PIT_CH0);	/* MSB */
 		break;
=20
-	/*
-	 * Avoid unnecessary state transitions, as it confuses
-	 * Geode / Cyrix based boxen.
-	 */
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		if (evt->mode =3D=3D CLOCK_EVT_MODE_UNUSED)
-			break;
 	case CLOCK_EVT_MODE_UNUSED:
-		if (evt->mode =3D=3D CLOCK_EVT_MODE_SHUTDOWN)
-			break;
+		outb_p(0x30, PIT_MODE);
+		outb_p(0, PIT_CH0);	/* LSB */
+		outb_p(0, PIT_CH0);	/* MSB */
+		break;
+
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* One shot setup */
 		outb_p(0x38, PIT_MODE);
-		udelay(10);
+		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		/* Nothing to do here */
 		break;
 	}
 	spin_unlock_irqrestore(&i8253_lock, flags);
diff --git a/arch/i386/kernel/vmiclock.c b/arch/i386/kernel/vmiclock.c
index f9b845f..d23077c 100644
--- a/arch/i386/kernel/vmiclock.c
+++ b/arch/i386/kernel/vmiclock.c
@@ -142,6 +142,7 @@ static void vmi_timer_set_mode(enum clock_event_mode =
mode,
=20
 	switch (mode) {
 	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_RESUME:
 		break;
 	case CLOCK_EVT_MODE_PERIODIC:
 		cycles_per_hz =3D vmi_timer_ops.get_cycle_frequency();
diff --git a/arch/i386/xen/time.c b/arch/i386/xen/time.c
index 51fdabf..dfd6db6 100644
--- a/arch/i386/xen/time.c
+++ b/arch/i386/xen/time.c
@@ -412,6 +412,7 @@ static void xen_timerop_set_mode(enum clock_event_mod=
e mode,
 		break;
=20
 	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_RESUME:
 		break;
=20
 	case CLOCK_EVT_MODE_UNUSED:
@@ -474,6 +475,8 @@ static void xen_vcpuop_set_mode(enum clock_event_mode=
 mode,
 		    HYPERVISOR_vcpu_op(VCPUOP_stop_periodic_timer, cpu, NULL))
 			BUG();
 		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
 }
=20
diff --git a/arch/sh/kernel/timers/timer-tmu.c b/arch/sh/kernel/timers/ti=
mer-tmu.c
index 097ebd4..7aca37d 100644
--- a/arch/sh/kernel/timers/timer-tmu.c
+++ b/arch/sh/kernel/timers/timer-tmu.c
@@ -80,6 +80,7 @@ static void tmu_set_mode(enum clock_event_mode mode,
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
 		break;
 	}
 }
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index e340eb4..87c10a7 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -931,6 +931,7 @@ static void sparc64_timer_setup(enum clock_event_mode=
 mode,
 {
 	switch (mode) {
 	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_RESUME:
 		break;
=20
 	case CLOCK_EVT_MODE_SHUTDOWN:
diff --git a/drivers/lguest/lguest.c b/drivers/lguest/lguest.c
index 434fea1..18dade0 100644
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -398,6 +398,8 @@ static void lguest_clockevent_set_mode(enum clock_eve=
nt_mode mode,
 		break;
 	case CLOCK_EVT_MODE_PERIODIC:
 		BUG();
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
 }
=20
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 8d7a390..e0bd46e 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -23,6 +23,7 @@ enum clock_event_mode {
 	CLOCK_EVT_MODE_SHUTDOWN,
 	CLOCK_EVT_MODE_PERIODIC,
 	CLOCK_EVT_MODE_ONESHOT,
+	CLOCK_EVT_MODE_RESUME,
 };
=20
 /* Clock event notification values */
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 8001d37..8339af2 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -49,7 +49,7 @@ cpumask_t *tick_get_broadcast_mask(void)
  */
 static void tick_broadcast_start_periodic(struct clock_event_device *bc)
 {
-	if (bc && bc->mode =3D=3D CLOCK_EVT_MODE_SHUTDOWN)
+	if (bc)
 		tick_setup_periodic(bc, 1);
 }
=20
@@ -299,7 +299,7 @@ void tick_suspend_broadcast(void)
 	spin_lock_irqsave(&tick_broadcast_lock, flags);
=20
 	bc =3D tick_broadcast_device.evtdev;
-	if (bc && tick_broadcast_device.mode =3D=3D TICKDEV_MODE_PERIODIC)
+	if (bc)
 		clockevents_set_mode(bc, CLOCK_EVT_MODE_SHUTDOWN);
=20
 	spin_unlock_irqrestore(&tick_broadcast_lock, flags);
@@ -316,6 +316,8 @@ int tick_resume_broadcast(void)
 	bc =3D tick_broadcast_device.evtdev;
=20
 	if (bc) {
+		clockevents_set_mode(bc, CLOCK_EVT_MODE_RESUME);
+
 		switch (tick_broadcast_device.mode) {
 		case TICKDEV_MODE_PERIODIC:
 			if(!cpus_empty(tick_broadcast_mask))
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a96ec9a..77a21ab 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -318,12 +318,17 @@ static void tick_resume(void)
 {
 	struct tick_device *td =3D &__get_cpu_var(tick_cpu_device);
 	unsigned long flags;
+	int broadcast =3D tick_resume_broadcast();
=20
 	spin_lock_irqsave(&tick_device_lock, flags);
-	if (td->mode =3D=3D TICKDEV_MODE_PERIODIC)
-		tick_setup_periodic(td->evtdev, 0);
-	else
-		tick_resume_oneshot();
+	clockevents_set_mode(td->evtdev, CLOCK_EVT_MODE_RESUME);
+
+	if (!broadcast) {
+		if (td->mode =3D=3D TICKDEV_MODE_PERIODIC)
+			tick_setup_periodic(td->evtdev, 0);
+		else
+			tick_resume_oneshot();
+	}
 	spin_unlock_irqrestore(&tick_device_lock, flags);
 }
=20
@@ -360,8 +365,7 @@ static int tick_notify(struct notifier_block *nb, uns=
igned long reason,
 		break;
=20
 	case CLOCK_EVT_NOTIFY_RESUME:
-		if (!tick_resume_broadcast())
-			tick_resume();
+		tick_resume();
 		break;
=20
 	default:


>
> Greetings,
> Rafael



--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
