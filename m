From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Tue, 15 Jun 2010 19:13:03 +0300
Message-ID: <20100615161303.GA4102__6048.95661022073$1276618328$gmane$org@swordfish.minsk.epam.com>
References: <20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100615080808.6286448b@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


I've changed struct tick_sched to match passed *ts and cpu. Also changed "&per_cpu(tick_cpu_sched, cpu)"
call to "struct tick_sched *tick_get_tick_sched(int cpu)" which we already have.

But I don't really like this part:
struct tick_sched *tick_get_tick_sched(int cpu)
{
	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
	ts->cpu = cpu;
	^^^^^^^^^^^^^
	return ts;
}

Please kindly review.

---

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 52ff8aa..4871ed5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -137,14 +137,17 @@ static inline int which_bucket(unsigned int duration)
 {
 	int bucket = 0;
 
+	int cpu = get_cpu();
 	/*
 	 * We keep two groups of stats; one with no
 	 * IO pending, one without.
 	 * This allows us to calculate
 	 * E(duration)|iowait
 	 */
-	if (nr_iowait_cpu())
+	if (nr_iowait_cpu(cpu))
 		bucket = BUCKETS/2;
+	
+	put_cpu();
 
 	if (duration < 10)
 		return bucket;
@@ -169,14 +172,17 @@ static inline int which_bucket(unsigned int duration)
 static inline int performance_multiplier(void)
 {
 	int mult = 1;
-
+	int cpu = get_cpu();
+	
 	/* for higher loadavg, we are more reluctant */
 
 	mult += 2 * get_loadavg();
 
 	/* for IO wait tasks (per cpu!) we add 5x each */
-	mult += 10 * nr_iowait_cpu();
+	mult += 10 * nr_iowait_cpu(cpu);
 
+	put_cpu();
+	
 	return mult;
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f118809..747fcae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -139,7 +139,7 @@ extern int nr_processes(void);
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
-extern unsigned long nr_iowait_cpu(void);
+extern unsigned long nr_iowait_cpu(int cpu);
 extern unsigned long this_cpu_load(void);
 
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index b232ccc..db14691 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -51,6 +51,7 @@ struct tick_sched {
 	unsigned long			check_clocks;
 	enum tick_nohz_mode		nohz_mode;
 	ktime_t				idle_tick;
+	int				cpu;
 	int				inidle;
 	int				tick_stopped;
 	unsigned long			idle_jiffies;
diff --git a/kernel/sched.c b/kernel/sched.c
index f8b8996..f61b48e 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2864,9 +2864,9 @@ unsigned long nr_iowait(void)
 	return sum;
 }
 
-unsigned long nr_iowait_cpu(void)
+unsigned long nr_iowait_cpu(int cpu)
 {
-	struct rq *this = this_rq();
+	struct rq *this = cpu_rq(cpu);
 	return atomic_read(&this->nr_iowait);
 }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1d7b9bc..5105345 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -38,7 +38,9 @@ static ktime_t last_jiffies_update;
 
 struct tick_sched *tick_get_tick_sched(int cpu)
 {
-	return &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ts->cpu = cpu;
+	return ts;
 }
 
 /*
@@ -137,7 +139,7 @@ __setup("nohz=", setup_tick_nohz);
 static void tick_nohz_update_jiffies(ktime_t now)
 {
 	int cpu = smp_processor_id();
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 	unsigned long flags;
 
 	cpumask_clear_cpu(cpu, nohz_cpu_mask);
@@ -159,9 +161,10 @@ update_ts_time_stats(struct tick_sched *ts, ktime_t now, u64 *last_update_time)
 	ktime_t delta;
 
 	if (ts->idle_active) {
+		int cpu = ts->cpu;
 		delta = ktime_sub(now, ts->idle_entrytime);
 		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
-		if (nr_iowait_cpu() > 0)
+		if (nr_iowait_cpu(cpu) > 0)
 			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
 		ts->idle_entrytime = now;
 	}
@@ -173,7 +176,7 @@ update_ts_time_stats(struct tick_sched *ts, ktime_t now, u64 *last_update_time)
 
 static void tick_nohz_stop_idle(int cpu, ktime_t now)
 {
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 
 	update_ts_time_stats(ts, now, NULL);
 	ts->idle_active = 0;
@@ -211,7 +214,7 @@ static ktime_t tick_nohz_start_idle(struct tick_sched *ts)
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 
 	if (!tick_nohz_enabled)
 		return -1;
@@ -237,7 +240,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 
 	if (!tick_nohz_enabled)
 		return -1;
@@ -267,7 +270,7 @@ void tick_nohz_stop_sched_tick(int inidle)
 	local_irq_save(flags);
 
 	cpu = smp_processor_id();
-	ts = &per_cpu(tick_cpu_sched, cpu);
+	ts = tick_get_tick_sched(cpu);
 
 	/*
 	 * Call to tick_nohz_start_idle stops the last_update_time from being
@@ -508,7 +511,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 void tick_nohz_restart_sched_tick(void)
 {
 	int cpu = smp_processor_id();
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 	unsigned long ticks;
 #endif
@@ -671,7 +674,7 @@ static void tick_nohz_kick_tick(int cpu, ktime_t now)
 #if 0
 	/* Switch back to 2.6.27 behaviour */
 
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 	ktime_t delta;
 
 	/*
@@ -688,7 +691,7 @@ static void tick_nohz_kick_tick(int cpu, ktime_t now)
 
 static inline void tick_check_nohz(int cpu)
 {
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 	ktime_t now;
 
 	if (!ts->idle_active && !ts->tick_stopped)
@@ -818,7 +821,7 @@ void tick_setup_sched_timer(void)
 #if defined CONFIG_NO_HZ || defined CONFIG_HIGH_RES_TIMERS
 void tick_cancel_sched_timer(int cpu)
 {
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct tick_sched *ts = tick_get_tick_sched(cpu);
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
