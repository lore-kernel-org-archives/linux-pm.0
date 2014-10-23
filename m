From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 3/5] cpuidle: idle: menu: Don't reflect when a state selection failed
Date: Thu, 23 Oct 2014 11:01:19 +0200
Message-ID: <1414054881-17713-3-git-send-email-daniel.lezcano@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

In the current code, the check to reflect or not the outcoming state is done
against the idle state which has been chosen and its value.

Instead of doing a check in each of the reflect functions, just don't call reflect
if something went wrong in the idle path.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/cpuidle/governors/ladder.c | 3 +--
 drivers/cpuidle/governors/menu.c   | 4 +---
 kernel/sched/idle.c                | 3 ++-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index fb396d6..c0b36a8 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -165,8 +165,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 static void ladder_reflect(struct cpuidle_device *dev, int index)
 {
 	struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
-	if (index > 0)
-		ldev->last_state_idx = index;
+	ldev->last_state_idx = index;
 }
 
 static struct cpuidle_governor ladder_governor = {
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index a17515f..3907301 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -365,9 +365,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 static void menu_reflect(struct cpuidle_device *dev, int index)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
-	data->last_state_idx = index;
-	if (index >= 0)
-		data->needs_update = 1;
+	data->needs_update = 1;
 }
 
 /**
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 58c7522..49dcc7d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -162,7 +162,8 @@ use_default:
 	/*
 	 * Give the governor an opportunity to reflect on the outcome
 	 */
-	cpuidle_reflect(dev, entered_state);
+	if (entered_state >= 0)
+		cpuidle_reflect(dev, entered_state);
 
 exit_idle:
 	__current_set_polling();
-- 
1.9.1
