From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Update stale polling override comment
Date: Thu, 16 Aug 2018 12:55:01 +0200
Message-ID: <2037635.8RjXc8lXCc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The comment to explain why the menu governor uses idle state 1
instead of idle state 0 as the first one sometimes is stale (among
other things it mentions a user setting not present any more),
so update it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -328,9 +328,8 @@ static int menu_select(struct cpuidle_dr
 		unsigned int polling_threshold;
 
 		/*
-		 * We want to default to C1 (hlt), not to busy polling
-		 * unless the timer is happening really really soon, or
-		 * C1's exit latency exceeds the user configured limit.
+		 * Default to a physical idle state, not to busy polling, unless
+		 * a timer is going to trigger really really soon.
 		 */
 		polling_threshold = max_t(unsigned int, 20, s->target_residency);
 		if (data->next_timer_us > polling_threshold &&
