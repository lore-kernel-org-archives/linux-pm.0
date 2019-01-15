From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: use BIT() for idle state flags and remove CPUIDLE_DRIVER_FLAGS_MASK
Date: Tue, 15 Jan 2019 12:22:10 -0500
Message-ID: <20190115172210.19793-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Use BIT() macro to do a small tidy-up. The CPUIDLE_DRIVER_FLAGS_MASK
 is not being used, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/cpuidle.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4dff74f48d4b..3b39472324a3 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -69,11 +69,9 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_NONE       (0x00)
-#define CPUIDLE_FLAG_POLLING	(0x01) /* polling state */
-#define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
-#define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
-
-#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
+#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
+#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
+#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
-- 
2.17.0
