From: Christoph Lameter <cl@linux.com>
Subject: drivers/cpuidle: Replace __get_cpu_var uses for address
 calculation
Date: Tue, 29 Apr 2014 14:24:39 -0500 (CDT)
Message-ID: <alpine.DEB.2.10.1404291423110.18675@gentwo.org>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:51139 "EHLO
	qmta08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933447AbaD2Tav (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 15:30:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

All of these are for address calculation. Replace with
this_cpu_ptr().

[cpufreq changes]
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux.orig/drivers/cpuidle/governors/ladder.c	2014-04-14 13:24:54.769362062 -0500
+++ linux/drivers/cpuidle/governors/ladder.c	2014-04-14 13:24:54.765362140 -0500
@@ -66,7 +66,7 @@
 static int ladder_select_state(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev)
 {
-	struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
+	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx = ldev->last_state_idx;
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
@@ -170,7 +170,7 @@
  */
 static void ladder_reflect(struct cpuidle_device *dev, int index)
 {
-	struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
+	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	if (index > 0)
 		ldev->last_state_idx = index;
 }
Index: linux/drivers/cpuidle/governors/menu.c
===================================================================
--- linux.orig/drivers/cpuidle/governors/menu.c	2014-04-14 13:24:54.769362062 -0500
+++ linux/drivers/cpuidle/governors/menu.c	2014-04-14 13:24:54.765362140 -0500
@@ -285,7 +285,7 @@
  */
 static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	struct menu_device *data = &__get_cpu_var(menu_devices);
+	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 	unsigned int interactivity_req;
@@ -377,7 +377,7 @@
  */
 static void menu_reflect(struct cpuidle_device *dev, int index)
 {
-	struct menu_device *data = &__get_cpu_var(menu_devices);
+	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	data->last_state_idx = index;
 	if (index >= 0)
 		data->needs_update = 1;
@@ -390,7 +390,7 @@
  */
 static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	struct menu_device *data = &__get_cpu_var(menu_devices);
+	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int last_idx = data->last_state_idx;
 	struct cpuidle_state *target = &drv->states[last_idx];
 	unsigned int measured_us;
