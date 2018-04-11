From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] nohz: Align types to bool for tick_nohz_tick_stopped_cpu()
Date: Wed, 11 Apr 2018 13:01:33 +0200
Message-ID: <1523444493-12665-2-git-send-email-ulf.hansson@linaro.org>
References: <1523444493-12665-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523444493-12665-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The intent was likely to also make the inline version a bool, so let's
change this.

Fixes: 22ab8bc02a5f ("nohz: Allow to check if remote CPU tick is stopped")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f9070b9..cb52c38 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,7 +126,7 @@ extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline bool tick_nohz_tick_stopped(void) { return false; }
-static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
+static inline bool tick_nohz_tick_stopped_cpu(int cpu) { return false; }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 
-- 
2.7.4
