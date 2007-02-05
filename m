From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 05/10] powermac: generic time suspend/resume code
Date: Mon, 05 Feb 2007 19:30:32 +0100
Message-ID: <20070205185836.869369000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=time-resume.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch removes the time suspend/restore code that was done through
a PMU notifier in arch/platforms/powermac/time.c.

Instead, we introduce arch/powerpc/sysdev/timer.c which creates a sys
device and handles time of day suspend/resume through that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Tested on powermac with suspend-to-disk and powerbook with
suspend-to-{ram,disk}, please apply to -mm.

--- mb-wireless.orig/arch/powerpc/platforms/powermac/time.c	2007-02-05 14:2=
4:06.474526864 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/time.c	2007-02-05 14:24:37.=
624526864 +0100
@@ -297,49 +297,11 @@ int __init via_calibrate_decr(void)
 }
 #endif
 =

-#ifdef CONFIG_PM
-/*
- * Reset the time after a sleep.
- */
-static int
-time_sleep_notify(struct pmu_sleep_notifier *self, int when)
-{
-	static unsigned long time_diff;
-	unsigned long flags;
-	unsigned long seq;
-	struct timespec tv;
-
-	switch (when) {
-	case PBOOK_SLEEP_NOW:
-		do {
-			seq =3D read_seqbegin_irqsave(&xtime_lock, flags);
-			time_diff =3D xtime.tv_sec - pmac_get_boot_time();
-		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-		break;
-	case PBOOK_WAKE:
-		tv.tv_sec =3D pmac_get_boot_time() + time_diff;
-		tv.tv_nsec =3D 0;
-		do_settimeofday(&tv);
-		break;
-	}
-	return PBOOK_SLEEP_OK;
-}
-
-static struct pmu_sleep_notifier time_sleep_notifier =3D {
-	time_sleep_notify, SLEEP_LEVEL_MISC,
-};
-#endif /* CONFIG_PM */
-
 /*
  * Query the OF and get the decr frequency.
  */
 void __init pmac_calibrate_decr(void)
 {
-#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
-	/* XXX why here? */
-	pmu_register_sleep_notifier(&time_sleep_notifier);
-#endif
-
 	generic_calibrate_decr();
 =

 #ifdef CONFIG_PPC32
--- mb-wireless.orig/arch/powerpc/Kconfig	2007-02-05 14:24:06.484526864 +01=
00
+++ mb-wireless/arch/powerpc/Kconfig	2007-02-05 14:24:37.624526864 +0100
@@ -11,6 +11,11 @@ config PPC64
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
 =

+config PPC_PM_NEEDS_RTC_LIB
+	bool
+	select RTC_LIB
+	default y if PM
+
 config PPC32
 	bool
 	default y if !PPC64
--- mb-wireless.orig/arch/powerpc/sysdev/Makefile	2007-02-05 14:24:06.51452=
6864 +0100
+++ mb-wireless/arch/powerpc/sysdev/Makefile	2007-02-05 14:24:37.624526864 =
+0100
@@ -13,6 +13,8 @@ obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+=3D tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+=3D qe_lib/
 obj-$(CONFIG_MTD)		+=3D rom.o
+# contains only the suspend handler for time
+obj-$(CONFIG_PM)		+=3D timer.o
 =

 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+=3D i8259.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/sysdev/timer.c	2007-02-05 14:24:37.624526864 +=
0100
@@ -0,0 +1,70 @@
+/*
+ * Common code to keep time when machine suspends.
+ *
+ * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <linux/time.h>
+#include <asm/rtc.h>
+
+static unsigned long suspend_rtc_time;
+
+/*
+ * Reset the time after a sleep.
+ */
+static int timer_resume(struct sys_device *dev)
+{
+	struct timeval tv;
+	struct timespec ts;
+	struct rtc_time cur_rtc_tm;
+	unsigned long cur_rtc_time, diff;
+
+	/* get current RTC time and convert to seconds */
+	get_rtc_time(&cur_rtc_tm);
+	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);
+
+	diff =3D cur_rtc_time - suspend_rtc_time;
+
+	/* adjust time of day by seconds that elapsed while
+	 * we were suspended */
+	do_gettimeofday(&tv);
+	ts.tv_sec =3D tv.tv_sec + diff;
+	ts.tv_nsec =3D tv.tv_usec * NSEC_PER_USEC;
+	do_settimeofday(&ts);
+
+	return 0;
+}
+
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct rtc_time suspend_rtc_tm;
+	WARN_ON(!ppc_md.get_rtc_time);
+
+	get_rtc_time(&suspend_rtc_tm);
+	rtc_tm_to_time(&suspend_rtc_tm, &suspend_rtc_time);
+
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass =3D {
+	.resume =3D timer_resume,
+	.suspend =3D timer_suspend,
+	set_kset_name("timer"),
+};
+
+static struct sys_device device_timer =3D {
+	.id =3D 0,
+	.cls =3D &timer_sysclass,
+};
+
+static int time_init_device(void)
+{
+	int error =3D sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error =3D sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(time_init_device);

--
