From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too
Date: Fri, 27 Feb 2015 00:39:56 +0100
Message-ID: <6897721.eAEtlVivc4@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <4425438.YlYNQyf1hp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4425438.YlYNQyf1hp@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify cpuidle_enter_freeze() to do the sanity checks done by
cpuidle_select() to avoid crashing the suspend-to-idle code
path in case something is missing.

Original-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -44,6 +44,12 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
+static bool cpuidle_not_available(struct cpuidle_driver *drv,
+				  struct cpuidle_device *dev)
+{
+	return off || !initialized || !drv || !dev || !dev->enabled;
+}
+
 /**
  * cpuidle_play_dead - cpu off-lining
  *
@@ -126,6 +132,9 @@ void cpuidle_enter_freeze(void)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int index;
 
+	if (cpuidle_not_available(drv, dev))
+		goto fallback;
+
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
 	 * that interrupts won't be enabled when it exits and allows the tick to
@@ -143,10 +152,13 @@ void cpuidle_enter_freeze(void)
 	 * at all and try to enter it normally.
 	 */
 	index = cpuidle_find_deepest_state(drv, dev, false);
-	if (index >= 0)
+	if (index >= 0) {
 		cpuidle_enter(drv, dev, index);
-	else
-		arch_cpu_idle();
+		return;
+	}
+
+ fallback:
+	arch_cpu_idle();
 }
 
 /**
@@ -205,12 +217,9 @@ int cpuidle_enter_state(struct cpuidle_d
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	if (off || !initialized)
+	if (cpuidle_not_available(drv, dev))
 		return -ENODEV;
 
-	if (!drv || !dev || !dev->enabled)
-		return -EBUSY;
-
 	return cpuidle_curr_governor->select(drv, dev);
 }
 
