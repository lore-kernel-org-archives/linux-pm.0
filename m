From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Fri, 9 Sep 2016 16:33:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609091551110.5679@nanos>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com> <4130556.MNmyvLDyHH@vostro.rjw.lan> <alpine.DEB.2.20.1609022119160.5647@nanos> <20160904153739.GA5400@sharon> <alpine.DEB.2.20.1609050941180.5647@nanos> <20160909053749.GA4564@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcIIOgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 10:36:39 -0400
In-Reply-To: <20160909053749.GA4564@sharon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "Zhang, Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org

On Fri, 9 Sep 2016, Chen Yu wrote:
> > I really have no idea why this is burried in x86 land. The pm_trace hackery
> > issues mc146818_set_time() to fiddle with the RTC. So any implementation of
> > this is affected.
> OK, I've changed this patch according to this suggestion.

No you did not! You still have that silly x86 hackery in place.
 
> OK. I've moved most of the logic into the pm_trace component,
> Once the mc146818_set_time has modified the RTC by pm_trace,
> related flags will be set which indicates the unusable of RTC.
> And timekeeping system is able to query these flags to decide whether
> it should inject the sleep time. (We tried to make this patch as
> simple as possible, but it looks like we have to deal with persistent
> clock for x86, which makes this patch a little more complicated).
> Here's the trial version of it, any suggestion would be appreciated:

It's overengineered and horrible.
 
> +unsigned int timekeeping_tainted;

It does not taint timekeeping. It just wreckages the RTC.

> +void pm_trace_taint_timekeeping(void)
> +{
> +	if (pm_trace_is_enabled()) {
> +		timekeeping_tainted |= TIMEKEEPING_RTC_TAINTED;
> +		if (arch_pm_trace_taint_pclock())
> +			timekeeping_tainted |= TIMEKEEPING_PERSISTENT_CLOCK_TAINTED;
> +	}

Why would you need all these flags?

> +static inline int pm_trace_rtc_is_tainted(void)
> +{
> +	return (timekeeping_tainted & TIMEKEEPING_RTC_TAINTED) ?
> +		1 : 0;

ever heard about bool?

> +}
> +

> +extern void pm_trace_untaint_timekeeping(void);

And how exactly do you untaint it? Just by clearing the flags. That makes
the RTC time magically correct again?

> +int arch_pm_trace_taint_pclock(void)
> +{
> +	return (x86_platform.get_wallclock == mach_get_cmos_time);
> +}

Groan. I told you to do it in the mc14xxx related places. There are not
that many in the kernel

Here is a completely uncompiled/untested patch which should address the
issue in a halfways clean way.

Thanks,

	tglx

--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -64,6 +64,15 @@ void mach_get_cmos_time(struct timespec
 	unsigned int status, year, mon, day, hour, min, sec, century = 0;
 	unsigned long flags;
 
+	/*
+	 * If pm trace abused the RTC as storage set the timespec to 0
+	 * which tells the caller that this RTC value is bogus.
+	 */
+	if (!pm_trace_rtc_valid()) {
+		now->tv_sec = now->tv_nsec = 0;
+		return;
+	}
+
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	/*
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -74,6 +74,7 @@
 
 #define DEVSEED (7919)
 
+bool pm_trace_rtc_abused __read_mostly;
 static unsigned int dev_hash_value;
 
 static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
@@ -104,6 +105,7 @@ static int set_magic_time(unsigned int u
 	time.tm_min = (n % 20) * 3;
 	n /= 20;
 	mc146818_set_time(&time);
+	pm_trace_rtc_abused = true;
 	return n ? -1 : 0;
 }
 
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -189,6 +189,13 @@ static inline void cmos_write_bank2(unsi
 
 static int cmos_read_time(struct device *dev, struct rtc_time *t)
 {
+	/*
+	 * If pmtrace abused the RTC for storage tell the caller that it is
+	 * unusable.
+	 */
+	if (!pm_trace_rtc_valid())
+		return -EIO;
+
 	/* REVISIT:  if the clock has a "century" register, use
 	 * that instead of the heuristic in mc146818_get_time().
 	 * That'll make Y3K compatility (year > 2070) easy!
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -16,6 +16,7 @@
 #include <asm/mc146818rtc.h>		/* register access macros */
 #include <linux/bcd.h>
 #include <linux/delay.h>
+#include <linux/pm-trace.h>
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>		/* spinlock_t */
--- a/include/linux/pm-trace.h
+++ b/include/linux/pm-trace.h
@@ -6,6 +6,12 @@
 #include <linux/types.h>
 
 extern int pm_trace_enabled;
+extern bool pm_trace_rtc_abused;
+
+static inline bool pm_trace_rtc_valid(void)
+{
+	return !pm_trace_rtc_abused;
+}
 
 static inline int pm_trace_is_enabled(void)
 {
@@ -24,6 +30,7 @@ extern int show_trace_dev_match(char *bu
 
 #else
 
+static inline bool pm_trace_rtc_valid(void) { return true; }
 static inline int pm_trace_is_enabled(void) { return 0; }
 
 #define TRACE_DEVICE(dev) do { } while (0)
