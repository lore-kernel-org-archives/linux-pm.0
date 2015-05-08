From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: Fix the kerneldoc comment for cpuidle_enter_state()
Date: Fri, 08 May 2015 16:11:07 +0200
Message-ID: <2191946.OHBZ8VucI3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54819 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752553AbbEHNqC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 09:46:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The kerneldoc comment for cpuidle_enter_state() doesn't match the
function's header any more, so fix it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -150,7 +150,7 @@ int cpuidle_enter_freeze(struct cpuidle_
  * cpuidle_enter_state - enter the state and update stats
  * @dev: cpuidle device for this cpu
  * @drv: cpuidle driver for this cpu
- * @next_state: index into drv->states of the state to enter
+ * @index: index into the states table in @drv of the state to enter
  */
 int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 			int index)

