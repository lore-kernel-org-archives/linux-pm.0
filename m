From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/2] drivers: cpuidle: add driver/device checks in cpuidle_enter_freeze()
Date: Tue, 24 Feb 2015 17:58:50 +0000
Message-ID: <1424800730-32059-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

The changes in commit:

381063133246 ("PM / sleep: Re-implement suspend-to-idle handling")

let suspend-to-idle code bypass the cpuidle_select() function to
enter the deepest idle state. The sanity checks carried out in
cpuidle_select() are bypassed too and this can cause breakage
on systems that try to suspend-to-idle with no registered cpuidle
driver.

This patch factors out a function cpuidle_device_disabled() that
is used to carry out sanity checks (ie CPUidle is disabled on the
cpu executing the code) in both cpuidle_select() and cpuidle_enter_freeze()
so that the checks are unified and carried out in both control paths.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f47edc6c..344fe6c 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -44,6 +44,12 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
+static bool cpuidle_device_disabled(struct cpuidle_driver *drv,
+				    struct cpuidle_device *dev)
+{
+	return (off || !initialized || !drv || !dev || !dev->enabled);
+}
+
 /**
  * cpuidle_play_dead - cpu off-lining
  *
@@ -124,6 +130,11 @@ void cpuidle_enter_freeze(void)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int index;
 
+	if (cpuidle_device_disabled(drv, dev)) {
+		arch_cpu_idle();
+		return;
+	}
+
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
 	 * that interrupts won't be enabled when it exits and allows the tick to
@@ -202,11 +213,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	if (off || !initialized)
-		return -ENODEV;
-
-	if (!drv || !dev || !dev->enabled)
-		return -EBUSY;
+	if (cpuidle_device_disabled(drv, dev))
+		return -1;
 
 	return cpuidle_curr_governor->select(drv, dev);
 }
-- 
2.2.1
