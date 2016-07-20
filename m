From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin
 array
Date: Wed, 20 Jul 2016 19:06:58 +0800
Message-ID: <20160720110658.GA5943@sharon>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com>
 <alpine.DEB.2.11.1607191031260.3596@nanos>
 <578DEDBB.9030602@intel.com>
 <alpine.DEB.2.11.1607191234200.3596@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16711 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbcGTK7S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Jul 2016 06:59:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1607191234200.3596@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Thomas,
On Tue, Jul 19, 2016 at 12:40:14PM +0200, Thomas Gleixner wrote:
> On Tue, 19 Jul 2016, Chen Yu wrote:
> > On 2016=E5=B9=B407=E6=9C=8819=E6=97=A5 16:36, Thomas Gleixner wrote=
:
> > > On Tue, 19 Jul 2016, Chen Yu wrote:
> > > > Further investigation shows that, the problem is caused by sett=
ing
> > > > /sys/power/pm_trace to 1 before the 1st hibernation, since once
> > > > pm_trace is enabled, the rtc becomes an unmeaningful value afte=
r resumed,
> > >
> > > So why is the RTC value useless if pm_trace is enabled? I really =
have a hard
> > > time to understand why pm_trace would affect the sleep time reado=
ut from
> > > RTC.
> >
> > After pm_trace is enabled, during system suspend/hibernate, the has=
h name of
> > each devices will be written to rtc, so the rtc value depends on wh=
at we
> > write in last suspend round, thus pm_trace can be used for diagnose=
 which
> > device failed to suspend(eg, the suspending on this device hang the=
 system,
> > we reboot the system , and check rtc hash value).
> >=20
> > In our case, after first hibernate/resume round, we found our curre=
nt system
> > time is at 2117, so syscore_resume -> timekeeping_resume :
> > __timekeeping_inject_sleeptime(tk, &ts_delta) would inject a quite =
large
> > delta : 2117 - 2017 year, thus the sleep_time_bin is overflow.
>=20
> While the range check is certainly correct and a good thing to have i=
t's wrong
> in the first place to call __timekeeping_inject_sleeptime() in case t=
hat
> pm_trace is enabled simply because that "hash" time value will also w=
reckage
> timekeeping. Your patch is just curing the symptom in the debug code =
but not
> fixing the root cause.
>=20
OK. I've modified the patch.
In case I break any other stuff :p, could you help check
if this patch is in the right direction, thanks:

1.  There are two places would invoke __timekeeping_inject_sleeptime(),
    they are timekeeping_resume and rtc_resume, so we need to deal with
    them respctively.

2.  for rtc_resume, if the pm_trace has once been enabled,
    we bypass the injection of sleep time.

3. for timekeeping_resume,
     Currently we either use nonstop clock source, or use persistent
     clock to get the sleep time. As pm_trace breaks systems who use rt=
c
     as a persistent clock, x86 is affected. So we add a
     check for x86 that, if the pm_trace has been enabled, we can not
     trust the persistent clock delta read from rtc, thus bypass
     the injection of sleep time in this case.

4. Why we checked the history of pm_trace: once pm_trace
   has been enabled, the delta of rtc would not be reliable anymore.
   For example, if we only check current pm_trace, we might still get
   memory overwrite:

   4.1 echo 1 > /sys/power/pm_trace
   4.2 hibernate/resume (rtc is broken, do not add delta from rtc becau=
se pm_trace is 1)
   4.3 echo 0 > /sys/power/pm_trace
   4.4 hibernate/resume (rtc is still broken, but add delta from rtc be=
cause pm_trace is 0)

   so we have to check if pm_trace has once been enabled, if it is, we =
will not add
   any delta from tsc until system reboots.

Thanks,
Yu

Index: linux/kernel/time/timekeeping.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/kernel/time/timekeeping.c
+++ linux/kernel/time/timekeeping.c
@@ -1448,6 +1448,11 @@ void __weak read_boot_clock64(struct tim
 	ts->tv_nsec =3D 0;
 }
=20
+bool __weak persistent_clock_is_usable(void)
+{
+	return true;
+}
+
 /* Flag for if timekeeping_resume() has injected sleeptime */
 static bool sleeptime_injected;
=20
@@ -1609,6 +1614,7 @@ void timekeeping_resume(void)
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
 	cycle_t cycle_now, cycle_delta;
+	bool persist_clock_usable =3D true;
=20
 	sleeptime_injected =3D false;
 	read_persistent_clock64(&ts_new);
@@ -1660,9 +1666,11 @@ void timekeeping_resume(void)
 	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0=
) {
 		ts_delta =3D timespec64_sub(ts_new, timekeeping_suspend_time);
 		sleeptime_injected =3D true;
+		if (!persistent_clock_is_usable())
+			persist_clock_usable =3D false;
 	}
=20
-	if (sleeptime_injected)
+	if (sleeptime_injected && persist_clock_usable)
 		__timekeeping_inject_sleeptime(tk, &ts_delta);
=20
 	/* Re-base the last cycle value */
Index: linux/arch/x86/kernel/rtc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/x86/kernel/rtc.c
+++ linux/arch/x86/kernel/rtc.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/pnp.h>
 #include <linux/of.h>
+#include <linux/pm-trace.h>
=20
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -147,6 +148,10 @@ void read_persistent_clock(struct timesp
 	x86_platform.get_wallclock(ts);
 }
=20
+bool persistent_clock_is_usable(void)
+{
+	return !pm_trace_once_enabled();
+}
=20
 static struct resource rtc_resources[] =3D {
 	[0] =3D {
Index: linux/drivers/rtc/class.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/rtc/class.c
+++ linux/drivers/rtc/class.c
@@ -20,6 +20,7 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/pm-trace.h>
=20
 #include "rtc-core.h"
=20
@@ -138,7 +139,7 @@ static int rtc_resume(struct device *dev
 	sleep_time =3D timespec64_sub(sleep_time,
 			timespec64_sub(new_system, old_system));
=20
-	if (sleep_time.tv_sec >=3D 0)
+	if ((sleep_time.tv_sec >=3D 0) && (!pm_trace_once_enabled()) )
 		timekeeping_inject_sleeptime64(&sleep_time);
 	rtc_hctosys_ret =3D 0;
 	return 0;
Index: linux/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/kernel/power/main.c
+++ linux/kernel/power/main.c
@@ -532,6 +532,7 @@ power_attr(wake_unlock);
=20
 #ifdef CONFIG_PM_TRACE
 int pm_trace_enabled;
+bool pm_trace_been_enabled;
=20
 static ssize_t pm_trace_show(struct kobject *kobj, struct kobj_attribu=
te *attr,
 			     char *buf)
@@ -548,6 +549,7 @@ pm_trace_store(struct kobject *kobj, str
 	if (sscanf(buf, "%d", &val) =3D=3D 1) {
 		pm_trace_enabled =3D !!val;
 		if (pm_trace_enabled) {
+			pm_trace_been_enabled =3D true;
 			pr_warn("PM: Enabling pm_trace changes system date and time during =
resume.\n"
 				"PM: Correct system time has to be restored manually after resume.=
\n");
 		}
Index: linux/include/linux/pm-trace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/linux/pm-trace.h
+++ linux/include/linux/pm-trace.h
@@ -6,12 +6,18 @@
 #include <linux/types.h>
=20
 extern int pm_trace_enabled;
+extern bool pm_trace_been_enabled;
=20
 static inline int pm_trace_is_enabled(void)
 {
        return pm_trace_enabled;
 }
=20
+static inline bool pm_trace_once_enabled(void)
+{
+       return pm_trace_been_enabled;
+}
+
 struct device;
 extern void set_trace_device(struct device *);
 extern void generate_pm_trace(const void *tracedata, unsigned int user=
);
@@ -25,6 +31,7 @@ extern int show_trace_dev_match(char *bu
 #else
=20
 static inline int pm_trace_is_enabled(void) { return 0; }
+static inline bool pm_trace_once_enabled(void) { return false; }
=20
 #define TRACE_DEVICE(dev) do { } while (0)
 #define TRACE_RESUME(dev) do { } while (0)
