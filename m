From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Fri, 9 Sep 2016 13:37:50 +0800
Message-ID: <20160909053749.GA4564@sharon>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com>
 <4130556.MNmyvLDyHH@vostro.rjw.lan>
 <alpine.DEB.2.20.1609022119160.5647@nanos>
 <20160904153739.GA5400@sharon>
 <alpine.DEB.2.20.1609050941180.5647@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609050941180.5647@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "Zhang, Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Mon, Sep 05, 2016 at 01:54:20AM -0600, Thomas Gleixner wrote:
> On Sun, 4 Sep 2016, Chen Yu wrote:
> > Hi Thomas, Rafael,
> > On Fri, Sep 02, 2016 at 09:26:51PM +0200, Thomas Gleixner wrote:
> > > On Wed, 31 Aug 2016, Rafael J. Wysocki wrote:
> > > > On Monday, August 29, 2016 12:40:39 AM Chen Yu wrote:
> > > > > +
> > > > > +	/*
> > > > > +	 * Make rtc-based persistent clock unusable
> > > > > +	 * if pm_trace is enabled, only take effect
> > > > > +	 * for timekeeping_suspend/resume.
> > > > > +	 */
> > > > > +	if (pm_trace_is_enabled() &&
> > > > > +	    x86_platform.get_wallclock == mach_get_cmos_time) {
> > > > > +		ts->tv_sec = 0;
> > > > > +		ts->tv_nsec = 0;
> > > > > +	}
> > > > 
> > > > I'm not sure about this.  Looks hackish.
> > > 
> > > Indeed. Can't you just keep track that pm_trace fiddled with the cmos clock
> > > and then discard the value either in the core or in mach_get_cmos_time()
> > The previous version is more straightforward, since
> > it ignored the bogus rtc in core. Would you please take
> > a glance at it too, thanks:
> > https://patchwork.kernel.org/patch/9287347/
> 
> This is the same hackery just different:
> 
> > +bool persistent_clock_is_usable(void)
> > +{
> > +	/* Unusable if pm_trace is enabled. */
> > +	return !((x86_platform.get_wallclock == mach_get_cmos_time) &&
> > +	        pm_trace_is_enabled());
> > +}
> 
> I really have no idea why this is burried in x86 land. The pm_trace hackery
> issues mc146818_set_time() to fiddle with the RTC. So any implementation of
> this is affected.
OK, I've changed this patch according to this suggestion.

Previously I tried to deal with the case that x86 uses
RTC-CMOS as its presistent clock, not kvm_clock, nor
other get_wallclock, and this seems only be related to x86.
So this piece of code looks hackish.
> 
> So that very piece of pmtrace code should keep track of the wreckage it did
> to the RTC and provide the fact to the core timekeeping code which can then
> skip the update.
> 
OK. I've moved most of the logic into the pm_trace component,
Once the mc146818_set_time has modified the RTC by pm_trace,
related flags will be set which indicates the unusable of RTC.
And timekeeping system is able to query these flags to decide whether
it should inject the sleep time. (We tried to make this patch as
simple as possible, but it looks like we have to deal with persistent
clock for x86, which makes this patch a little more complicated).
Here's the trial version of it, any suggestion would be appreciated:



Index: linux/drivers/base/power/trace.c
===================================================================
--- linux.orig/drivers/base/power/trace.c
+++ linux/drivers/base/power/trace.c
@@ -75,6 +75,27 @@
 #define DEVSEED (7919)
 
 static unsigned int dev_hash_value;
+unsigned int timekeeping_tainted;
+
+/* Is the persistent clock effected by pm_trace? */
+int __weak arch_pm_trace_taint_pclock(void)
+{
+	return 0;
+}
+
+void pm_trace_untaint_timekeeping(void)
+{
+	timekeeping_tainted = 0;
+}
+
+void pm_trace_taint_timekeeping(void)
+{
+	if (pm_trace_is_enabled()) {
+		timekeeping_tainted |= TIMEKEEPING_RTC_TAINTED;
+		if (arch_pm_trace_taint_pclock())
+			timekeeping_tainted |= TIMEKEEPING_PERSISTENT_CLOCK_TAINTED;
+	}
+}
 
 static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
 {
@@ -104,6 +125,7 @@ static int set_magic_time(unsigned int u
 	time.tm_min = (n % 20) * 3;
 	n /= 20;
 	mc146818_set_time(&time);
+	pm_trace_taint_timekeeping();
 	return n ? -1 : 0;
 }
 
Index: linux/kernel/power/main.c
===================================================================
--- linux.orig/kernel/power/main.c
+++ linux/kernel/power/main.c
@@ -548,6 +548,7 @@ pm_trace_store(struct kobject *kobj, str
 	if (sscanf(buf, "%d", &val) == 1) {
 		pm_trace_enabled = !!val;
 		if (pm_trace_enabled) {
+			pm_trace_untaint_timekeeping();
 			pr_warn("PM: Enabling pm_trace changes system date and time during resume.\n"
 				"PM: Correct system time has to be restored manually after resume.\n");
 		}
Index: linux/include/linux/pm-trace.h
===================================================================
--- linux.orig/include/linux/pm-trace.h
+++ linux/include/linux/pm-trace.h
@@ -1,10 +1,14 @@
 #ifndef PM_TRACE_H
 #define PM_TRACE_H
 
+#define TIMEKEEPING_RTC_TAINTED 0x1
+#define TIMEKEEPING_PERSISTENT_CLOCK_TAINTED 0x2
+
 #ifdef CONFIG_PM_TRACE
 #include <asm/pm-trace.h>
 #include <linux/types.h>
 
+extern unsigned int timekeeping_tainted;
 extern int pm_trace_enabled;
 
 static inline int pm_trace_is_enabled(void)
@@ -12,10 +16,23 @@ static inline int pm_trace_is_enabled(vo
        return pm_trace_enabled;
 }
 
+static inline int pm_trace_rtc_is_tainted(void)
+{
+	return (timekeeping_tainted & TIMEKEEPING_RTC_TAINTED) ?
+		1 : 0;
+}
+
+static inline int pm_trace_pclock_is_tainted(void)
+{
+	return (timekeeping_tainted & TIMEKEEPING_PERSISTENT_CLOCK_TAINTED) ?
+		1 : 0;
+}
+
 struct device;
 extern void set_trace_device(struct device *);
 extern void generate_pm_trace(const void *tracedata, unsigned int user);
 extern int show_trace_dev_match(char *buf, size_t size);
+extern void pm_trace_untaint_timekeeping(void);
 
 #define TRACE_DEVICE(dev) do { \
 	if (pm_trace_enabled) \
@@ -25,6 +42,8 @@ extern int show_trace_dev_match(char *bu
 #else
 
 static inline int pm_trace_is_enabled(void) { return 0; }
+static inline int pm_trace_rtc_is_tainted(void) { return 0; }
+static inline int pm_trace_pclock_is_tainted(void) { return 0; }
 
 #define TRACE_DEVICE(dev) do { } while (0)
 #define TRACE_RESUME(dev) do { } while (0)
Index: linux/arch/x86/kernel/rtc.c
===================================================================
--- linux.orig/arch/x86/kernel/rtc.c
+++ linux/arch/x86/kernel/rtc.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/pnp.h>
 #include <linux/of.h>
+#include <linux/pm-trace.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -146,6 +147,10 @@ void read_persistent_clock(struct timesp
 	x86_platform.get_wallclock(ts);
 }
 
+int arch_pm_trace_taint_pclock(void)
+{
+	return (x86_platform.get_wallclock == mach_get_cmos_time);
+}
 
 static struct resource rtc_resources[] = {
 	[0] = {
Index: linux/kernel/time/timekeeping.c
===================================================================
--- linux.orig/kernel/time/timekeeping.c
+++ linux/kernel/time/timekeeping.c
@@ -23,6 +23,7 @@
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/compiler.h>
+#include <linux/pm-trace.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -1554,7 +1555,7 @@ static void __timekeeping_inject_sleepti
  */
 bool timekeeping_rtc_skipresume(void)
 {
-	return sleeptime_injected;
+	return sleeptime_injected || pm_trace_rtc_is_tainted();
 }
 
 /**
@@ -1664,7 +1665,7 @@ void timekeeping_resume(void)
 		sleeptime_injected = true;
 	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
 		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
-		sleeptime_injected = true;
+		sleeptime_injected = pm_trace_pclock_is_tainted() ? false : true;
 	}
 
 	if (sleeptime_injected)
