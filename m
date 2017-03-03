From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 5/9] timer: Export next wake up of a CPU
Date: Fri,  3 Mar 2017 12:41:31 -0800
Message-ID: <1488573695-106680-6-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Knowing the sleep length of the CPU is useful for the power state
determination on idle. The value is relative to the time when the call
was invoked by the CPU. This doesn't work well when there is a need to
know when the actual wakeup is.

By reading the next wake up event of a CPU, governors can determine the
first CPU to wake up (due to timer) amongst a cluster of CPUs and the
sleep time available between the last CPU to idle and the first CPU to
resume. This information is useful to determine if the caches and other
common hardware blocks can also be put in idle during this common period
of inactivity.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/tick.h     | 10 ++++++++++
 kernel/time/tick-sched.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index a04fea1..2416021 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -117,6 +117,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -129,6 +130,15 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
 {
 	return NSEC_PER_SEC / HZ;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	ktime_t len = NSEC_PER_SEC/HZ;
+
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(len, ktime_get());
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2c115fd..03e7c17 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -989,6 +989,17 @@ ktime_t tick_nohz_get_sleep_length(void)
 	return ts->sleep_length;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
+ */
+ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	struct clock_event_device *dev =
+			per_cpu(tick_cpu_device.evtdev, cpu);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.7.4
