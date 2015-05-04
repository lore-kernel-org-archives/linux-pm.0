From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] cpuidle: Check the sign of index in cpuidle_reflect()
Date: Mon, 04 May 2015 15:57:01 +0200
Message-ID: <1452615.qnuzHTbuFj@vostro.rjw.lan>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63949 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752809AbbEDNeK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 09:34:10 -0400
In-Reply-To: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Avoid calling the governor's ->reflect method if the state index
passed to cpuidle_reflect() is negative.

This allows the analogous check to be dropped from menu_reflect(),
so do that too, and ensures that arbitrary error codes can be
passed to cpuidle_reflect() as the index with no adverse
consequences.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c        |    2 +-
 drivers/cpuidle/governors/menu.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -249,7 +249,7 @@ int cpuidle_enter(struct cpuidle_driver
  */
 void cpuidle_reflect(struct cpuidle_device *dev, int index)
 {
-	if (cpuidle_curr_governor->reflect)
+	if (cpuidle_curr_governor->reflect && index >= 0)
 		cpuidle_curr_governor->reflect(dev, index);
 }
 
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -367,9 +367,9 @@ static int menu_select(struct cpuidle_dr
 static void menu_reflect(struct cpuidle_device *dev, int index)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
+
 	data->last_state_idx = index;
-	if (index >= 0)
-		data->needs_update = 1;
+	data->needs_update = 1;
 }
 
 /**

