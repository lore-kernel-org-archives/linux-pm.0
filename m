From: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
Subject: [PATCH 7/7] Cpuidle: poll state can measure residency
Date: Mon, 24 Feb 2014 08:29:37 +0200
Message-ID: <1393223377-5744-8-git-send-email-tuukka.tikkanen@linaro.org>
References: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, tuukka.tikkanen@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For some platforms, a poll state is inserted in the cpuidle driver states.
The flags for the state do not indicate that timekeeping is not affected.
As the state does not do anything apart from calling cpu_relax(), the
times returned by ktime_get should remain valid. Add the missing flag.

Signed-off-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
---
 drivers/cpuidle/driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 06dbe7c..136d6a2 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -209,7 +209,7 @@ static void poll_idle_init(struct cpuidle_driver *drv)
 	state->exit_latency = 0;
 	state->target_residency = 0;
 	state->power_usage = -1;
-	state->flags = 0;
+	state->flags = CPUIDLE_FLAG_TIME_VALID;
 	state->enter = poll_idle;
 	state->disabled = false;
 }
-- 
1.7.9.5
