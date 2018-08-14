From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Fix white space
Date: Tue, 14 Aug 2018 12:39:02 +0200
Message-ID: <38361268.Ie9rOxbguv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix some damaged white space in menu_select().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -429,8 +429,8 @@ static int menu_select(struct cpuidle_dr
 			 * tick, so try to correct that.
 			 */
 			for (i = idx - 1; i >= 0; i--) {
-			    if (drv->states[i].disabled ||
-			        dev->states_usage[i].disable)
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
 					continue;
 
 				idx = i;
