From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] nohz: Align types to bool for tick_nohz_tick_stopped_cpu()
Date: Thu, 12 Apr 2018 09:09:19 +0200
Message-ID: <1523516959-5761-2-git-send-email-ulf.hansson@linaro.org>
References: <1523516959-5761-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523516959-5761-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The intent was likely to also make the inline version a bool, so let's
change this.

Fixes: 22ab8bc02a5f ("nohz: Allow to check if remote CPU tick is stopped")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased on top of Linus' latest master to apply cleanly.

---
 include/linux/tick.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 4132eba..389aa25 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -138,7 +138,7 @@ static inline void tick_nohz_idle_stop_tick_protected(void)
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline bool tick_nohz_tick_stopped(void) { return false; }
-static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
+static inline bool tick_nohz_tick_stopped_cpu(int cpu) { return false; }
 static inline void tick_nohz_idle_stop_tick(void) { }
 static inline void tick_nohz_idle_retain_tick(void) { }
 static inline void tick_nohz_idle_restart_tick(void) { }
-- 
2.7.4
