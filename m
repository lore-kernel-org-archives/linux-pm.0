From: David Brownell <david-b@pacbell.net>
Subject: [patch 6/6] rtc suspend()/resume() restores system clock
Date: Wed, 21 Feb 2007 19:50:21 -0800
Message-ID: <200702211950.22422.david-b@pacbell.net>
References: <200702211929.17203.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702211929.17203.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

RTC class suspend/resume support, re-initializing the system clock on resume
from the clock used to initialize it at boot time.

 - Inlining the same code used by ARM, which saves and restores the
   delta between a selected RTC and the current system wall-clock time.

 - Removes calls to that ARM code from AT91, OMAP, and S3C RTCs.

This goes on top of the patch series removing "struct class_device" usage
from the RTC framework.  That makes class suspend()/resume() work.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 drivers/rtc/Kconfig          |   24 +++++++++----
 drivers/rtc/class.c          |   74 ++++++++++++++++++++++++++++++++++++++=
+++++
 drivers/rtc/rtc-at91rm9200.c |   30 -----------------
 drivers/rtc/rtc-omap.c       |   17 ---------
 drivers/rtc/rtc-s3c.c        |   22 ------------
 5 files changed, 91 insertions(+), 76 deletions(-)

Index: at91/drivers/rtc/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/rtc/Kconfig	2007-02-21 18:47:38.000000000 -0800
+++ at91/drivers/rtc/Kconfig	2007-02-21 18:47:41.000000000 -0800
@@ -21,21 +21,31 @@ config RTC_CLASS
 	  will be called rtc-class.
 =

 config RTC_HCTOSYS
-	bool "Set system time from RTC on startup"
+	bool "Set system time from RTC on startup and resume"
 	depends on RTC_CLASS =3D y
 	default y
 	help
-	  If you say yes here, the system time will be set using
-	  the value read from the specified RTC device. This is useful
-	  in order to avoid unnecessary fsck runs.
+	  If you say yes here, the system time (wall clock) will be set using
+	  the value read from a specified RTC device. This is useful to avoid
+	  unnecessary fsck runs at boot time, and to network better.
 =

 config RTC_HCTOSYS_DEVICE
-	string "The RTC to read the time from"
+	string "RTC used to set the system time"
 	depends on RTC_HCTOSYS =3D y
 	default "rtc0"
 	help
-	  The RTC device that will be used as the source for
-	  the system time, usually rtc0.
+	  The RTC device that will be used to (re)initialize the system
+	  clock, usually rtc0.  Initialization is done when the system
+	  starts up, and when it resumes from a low power state.
+	  =

+	  This clock should be battery-backed, so that it reads the correct
+	  time when the system boots from a power-off state.  Otherwise, your
+	  system will need an external clock source (like an NTP server).
+
+	  If the clock you specify here is not battery backed, it may still
+	  be useful to reinitialize system time when resuming from system =

+	  sleep states.  Do not specify an RTC here unless it stays powered
+	  during all this system's supported sleep states.
 =

 config RTC_DEBUG
 	bool "RTC debug support"
Index: at91/drivers/rtc/class.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/rtc/class.c	2007-02-21 18:47:39.000000000 -0800
+++ at91/drivers/rtc/class.c	2007-02-21 18:47:41.000000000 -0800
@@ -32,6 +32,78 @@ static void rtc_device_release(struct de
 	kfree(rtc);
 }
 =

+#if defined(CONFIG_PM) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
+
+/*
+ * On suspend(), measure the delta between one RTC and the
+ * system's wall clock; restore it on resume().
+ */
+
+static struct timespec	delta;
+static time_t		oldtime;
+
+static int rtc_suspend(struct device *dev, pm_message_t mesg)
+{
+	struct rtc_device	*rtc =3D to_rtc_device(dev);
+	struct rtc_time		tm;
+
+	if (strncmp(rtc->dev.bus_id,
+				CONFIG_RTC_HCTOSYS_DEVICE,
+				BUS_ID_SIZE) !=3D 0)
+		return 0;
+
+	rtc_read_time(rtc, &tm);
+	rtc_tm_to_time(&tm, &oldtime);
+
+	/* RTC precision is 1 second; adjust delta for avg 1/2 sec err */
+	set_normalized_timespec(&delta,
+				xtime.tv_sec - oldtime,
+				xtime.tv_nsec - (NSEC_PER_SEC >> 1));
+
+	return 0;
+}
+
+static int rtc_resume(struct device *dev)
+{
+	struct rtc_device	*rtc =3D to_rtc_device(dev);
+	struct rtc_time		tm;
+	time_t			newtime;
+	struct timespec		time;
+
+	if (strncmp(rtc->dev.bus_id,
+				CONFIG_RTC_HCTOSYS_DEVICE,
+				BUS_ID_SIZE) !=3D 0)
+		return 0;
+
+	rtc_read_time(rtc, &tm);
+	if (rtc_valid_tm(&tm) !=3D 0) {
+		pr_debug("%s:  bogus resume time\n", rtc->dev.bus_id);
+		return 0;
+	}
+	rtc_tm_to_time(&tm, &newtime);
+	if (newtime <=3D oldtime) {
+		if (newtime < oldtime)
+			pr_debug("%s:  time travel!\n", rtc->dev.bus_id);
+		return 0;
+	}
+
+	/* restore wall clock using delta against this RTC;
+	 * adjust again for avg 1/2 second RTC sampling error
+	 */
+	set_normalized_timespec(&time,
+				newtime + delta.tv_sec,
+				(NSEC_PER_SEC >> 1) + delta.tv_nsec);
+	do_settimeofday(&time);
+
+	return 0;
+}
+
+#else
+#define rtc_suspend	NULL
+#define rtc_resume	NULL
+#endif
+
+
 /**
  * rtc_device_register - register w/ RTC class
  * @dev: the device to register
@@ -138,6 +210,8 @@ static int __init rtc_init(void)
 		printk(KERN_ERR "%s: couldn't create class\n", __FILE__);
 		return PTR_ERR(rtc_class);
 	}
+	rtc_class->suspend =3D rtc_suspend;
+	rtc_class->resume =3D rtc_resume;
 	rtc_dev_init();
 	rtc_sysfs_init(rtc_class);
 	return 0;
Index: at91/drivers/rtc/rtc-at91rm9200.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/rtc/rtc-at91rm9200.c	2007-02-21 18:47:26.000000000 -0=
800
+++ at91/drivers/rtc/rtc-at91rm9200.c	2007-02-21 18:47:41.000000000 -0800
@@ -348,21 +348,10 @@ static int __exit at91_rtc_remove(struct
 =

 /* AT91RM9200 RTC Power management control */
 =

-static struct timespec at91_rtc_delta;
 static u32 at91_rtc_imr;
 =

 static int at91_rtc_suspend(struct platform_device *pdev, pm_message_t sta=
te)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec =3D 0;
-
-	/* calculate time delta for suspend */
-	at91_rtc_readtime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	save_time_delta(&at91_rtc_delta, &time);
-
 	/* this IRQ is shared with DBGU and other hardware which isn't
 	 * necessarily doing PM like we are...
 	 */
@@ -374,36 +363,17 @@ static int at91_rtc_suspend(struct platf
 		else
 			at91_sys_write(AT91_RTC_IDR, at91_rtc_imr);
 	}
-
-	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
-		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec);
-
 	return 0;
 }
 =

 static int at91_rtc_resume(struct platform_device *pdev)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec =3D 0;
-
-	at91_rtc_readtime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	restore_time_delta(&at91_rtc_delta, &time);
-
 	if (at91_rtc_imr) {
 		if (device_may_wakeup(&pdev->dev))
 			disable_irq_wake(AT91_ID_SYS);
 		else
 			at91_sys_write(AT91_RTC_IER, at91_rtc_imr);
 	}
-
-	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
-		1900 + tm.tm_year, tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec);
-
 	return 0;
 }
 #else
Index: at91/drivers/rtc/rtc-omap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/rtc/rtc-omap.c	2007-02-21 18:47:39.000000000 -0800
+++ at91/drivers/rtc/rtc-omap.c	2007-02-21 18:47:41.000000000 -0800
@@ -488,19 +488,10 @@ static int __devexit omap_rtc_remove(str
 =

 #ifdef CONFIG_PM
 =

-static struct timespec rtc_delta;
 static u8 irqstat;
 =

 static int omap_rtc_suspend(struct platform_device *pdev, pm_message_t sta=
te)
 {
-	struct rtc_time rtc_tm;
-	struct timespec time;
-
-	time.tv_nsec =3D 0;
-	omap_rtc_read_time(NULL, &rtc_tm);
-	rtc_tm_to_time(&rtc_tm, &time.tv_sec);
-
-	save_time_delta(&rtc_delta, &time);
 	irqstat =3D rtc_read(OMAP_RTC_INTERRUPTS_REG);
 =

 	/* FIXME the RTC alarm is not currently acting as a wakeup event
@@ -517,14 +508,6 @@ static int omap_rtc_suspend(struct platf
 =

 static int omap_rtc_resume(struct platform_device *pdev)
 {
-	struct rtc_time rtc_tm;
-	struct timespec time;
-
-	time.tv_nsec =3D 0;
-	omap_rtc_read_time(NULL, &rtc_tm);
-	rtc_tm_to_time(&rtc_tm, &time.tv_sec);
-
-	restore_time_delta(&rtc_delta, &time);
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(omap_rtc_alarm);
 	else
Index: at91/drivers/rtc/rtc-s3c.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/rtc/rtc-s3c.c	2007-02-21 18:47:26.000000000 -0800
+++ at91/drivers/rtc/rtc-s3c.c	2007-02-21 18:47:41.000000000 -0800
@@ -548,37 +548,15 @@ static int ticnt_save;
 =

 static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t stat=
e)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec =3D 0;
-
 	/* save TICNT for anyone using periodic interrupts */
-
 	ticnt_save =3D readb(s3c_rtc_base + S3C2410_TICNT);
-
-	/* calculate time delta for suspend */
-
-	s3c_rtc_gettime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	save_time_delta(&s3c_rtc_delta, &time);
 	s3c_rtc_enable(pdev, 0);
-
 	return 0;
 }
 =

 static int s3c_rtc_resume(struct platform_device *pdev)
 {
-	struct rtc_time tm;
-	struct timespec time;
-
-	time.tv_nsec =3D 0;
-
 	s3c_rtc_enable(pdev, 1);
-	s3c_rtc_gettime(&pdev->dev, &tm);
-	rtc_tm_to_time(&tm, &time.tv_sec);
-	restore_time_delta(&s3c_rtc_delta, &time);
-
 	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
 	return 0;
 }
