From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 1/3] Subject: nohz: Expose tick_nohz_enabled
Date: Mon, 11 Jan 2016 17:40:31 +0100
Message-ID: <20160111174031.6cc73575@endymion.delvare>
References: <20160111173915.63ec1bcd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49897 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761187AbcAKQkh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 11:40:37 -0500
In-Reply-To: <20160111173915.63ec1bcd@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

The cpuidle subsystem needs it.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/tick.h     |    2 ++
 kernel/time/tick-sched.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-4.4.orig/include/linux/tick.h	2016-01-11 00:01:32.000000000 +0100
+++ linux-4.4/include/linux/tick.h	2016-01-11 15:10:46.334547548 +0100
@@ -98,6 +98,7 @@ static inline void tick_broadcast_exit(v
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
+extern int tick_nohz_enabled;
 extern int tick_nohz_tick_stopped(void);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
@@ -106,6 +107,7 @@ extern ktime_t tick_nohz_get_sleep_lengt
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
+#define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
--- linux-4.4.orig/kernel/time/tick-sched.c	2016-01-11 15:06:54.776653477 +0100
+++ linux-4.4/kernel/time/tick-sched.c	2016-01-11 15:09:19.022700899 +0100
@@ -387,7 +387,7 @@ void __init tick_nohz_init(void)
 /*
  * NO HZ enabled ?
  */
-static int tick_nohz_enabled __read_mostly  = 1;
+int tick_nohz_enabled __read_mostly = 1;
 unsigned long tick_nohz_active  __read_mostly;
 /*
  * Enable / Disable tickless mode

-- 
Jean Delvare
SUSE L3 Support
