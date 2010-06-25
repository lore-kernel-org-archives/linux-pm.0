From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle: avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu) v4
Date: Fri, 25 Jun 2010 16:39:33 +0200
Message-ID: <1277476773.32034.639.camel__8454.17264285988$1277477031$gmane$org@twins>
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
	<20100617062950.GA3979@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100617062950.GA3979@swordfish>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-06-17 at 09:29 +0300, Sergey Senozhatsky wrote:
> Fix
>    
>  BUG: using smp_processor_id() in preemptible [00000000] code: s2disk/3392

> The initial fix was to use get_cpu/put_cpu in nr_iowait_cpu.  However,
> Arjan stated that "the bug is that it needs to be nr_iowait_cpu(int cpu)".
> 
> This patch introduces nr_iowait_cpu(int cpu) and changes to its callers.
> 
> Arjan also pointed out that we can't use get_cpu/put_cpu in update_ts_time_stats
> since we "pick the current cpu, rather than the one denoted by ts" in that case.
> To match given *ts and cpu denoted by *ts we use new field in the struct tick_sched: int cpu.


> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index b232ccc..db14691 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -51,6 +51,7 @@ struct tick_sched {
>  	unsigned long			check_clocks;
>  	enum tick_nohz_mode		nohz_mode;
>  	ktime_t				idle_tick;
> +	int				cpu;
>  	int				inidle;
>  	int				tick_stopped;
>  	unsigned long			idle_jiffies;

> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 1d7b9bc..1907037 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -38,6 +38,9 @@ static ktime_t last_jiffies_update;
>  
>  struct tick_sched *tick_get_tick_sched(int cpu)
>  {
> +	/*FIXME: Arjan van de Ven:
> +	 can we do this bit once, when the ts structure gets initialized?*/
> +	per_cpu(tick_cpu_sched, cpu).cpu = cpu;
>  	return &per_cpu(tick_cpu_sched, cpu);
>  }

> @@ -161,7 +164,7 @@ update_ts_time_stats(struct tick_sched *ts, ktime_t now, u64 *last_update_time)
>  	if (ts->idle_active) {
>  		delta = ktime_sub(now, ts->idle_entrytime);
>  		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
> -		if (nr_iowait_cpu() > 0)
> +		if (nr_iowait_cpu(ts->cpu) > 0)
>  			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
>  		ts->idle_entrytime = now;
>  	}


This all seems extremely silly, why not something like:

---
 kernel/time/tick-sched.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5f171f0..1363d3a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -154,14 +154,14 @@ static void tick_nohz_update_jiffies(ktime_t now)
  * Updates the per cpu time idle statistics counters
  */
 static void
-update_ts_time_stats(struct tick_sched *ts, ktime_t now, u64 *last_update_time)
+update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_update_time)
 {
 	ktime_t delta;
 
 	if (ts->idle_active) {
 		delta = ktime_sub(now, ts->idle_entrytime);
 		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
-		if (nr_iowait_cpu() > 0)
+		if (nr_iowait_cpu(cpu) > 0)
 			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
 		ts->idle_entrytime = now;
 	}
@@ -175,19 +175,19 @@ static void tick_nohz_stop_idle(int cpu, ktime_t now)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
-	update_ts_time_stats(ts, now, NULL);
+	update_ts_time_stats(cpu, ts, now, NULL);
 	ts->idle_active = 0;
 
 	sched_clock_idle_wakeup_event(0);
 }
 
-static ktime_t tick_nohz_start_idle(struct tick_sched *ts)
+static ktime_t tick_nohz_start_idle(int cpu, struct tick_sched *ts)
 {
 	ktime_t now;
 
 	now = ktime_get();
 
-	update_ts_time_stats(ts, now, NULL);
+	update_ts_time_stats(cpu, ts, now, NULL);
 
 	ts->idle_entrytime = now;
 	ts->idle_active = 1;
@@ -216,7 +216,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 	if (!tick_nohz_enabled)
 		return -1;
 
-	update_ts_time_stats(ts, ktime_get(), last_update_time);
+	update_ts_time_stats(cpu, ts, ktime_get(), last_update_time);
 
 	return ktime_to_us(ts->idle_sleeptime);
 }
@@ -242,7 +242,7 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 	if (!tick_nohz_enabled)
 		return -1;
 
-	update_ts_time_stats(ts, ktime_get(), last_update_time);
+	update_ts_time_stats(cpu, ts, ktime_get(), last_update_time);
 
 	return ktime_to_us(ts->iowait_sleeptime);
 }
@@ -284,7 +284,7 @@ void tick_nohz_stop_sched_tick(int inidle)
 	 */
 	ts->inidle = 1;
 
-	now = tick_nohz_start_idle(ts);
+	now = tick_nohz_start_idle(cpu, ts);
 
 	/*
 	 * If this cpu is offline and it is the one which updates
