From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 07/10] tick/sched: Split out jiffies update helper function
Date: Tue, 18 Apr 2017 13:11:09 +0200
Message-ID: <20170418111400.936735984@linutronix.de>
References: <20170418111102.490432548@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52305 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdDRQol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 12:44:41 -0400
Content-Disposition: inline;
 filename=tick-sched_Split-out-jiffies-update-helper.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global funtion in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/tick-internal.h |    1 +
 kernel/time/tick-sched.c    |   27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -151,6 +151,7 @@ static inline void tick_nohz_init(void)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
+extern u64 get_jiffies_update(unsigned long *basej);
 #else
 #define tick_nohz_active (0)
 #endif
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -112,6 +112,24 @@ static ktime_t tick_init_jiffy_update(vo
 	return period;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
+{
+	unsigned long seq, basejiff;
+	u64 basemono;
+
+	do {
+		seq = read_seqbegin(&jiffies_lock);
+		basemono = last_jiffies_update;
+		basejiff = jiffies;
+	} while (read_seqretry(&jiffies_lock, seq));
+	*basej = basejiff;
+	return basemono;
+}
+#endif
 
 static void tick_sched_do_timer(ktime_t now)
 {
@@ -667,15 +685,10 @@ static ktime_t tick_nohz_stop_sched_tick
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono, next_tick, next_local, next_global, next_rcu, delta, expires;
-	unsigned long seq, basejiff;
+	unsigned long basejiff;
 	ktime_t	tick;
 
-	/* Read jiffies and the time when jiffies were updated last */
-	do {
-		seq = read_seqbegin(&jiffies_lock);
-		basemono = last_jiffies_update;
-		basejiff = jiffies;
-	} while (read_seqretry(&jiffies_lock, seq));
+	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
 
 	if (rcu_needs_cpu(basemono, &next_rcu) ||
