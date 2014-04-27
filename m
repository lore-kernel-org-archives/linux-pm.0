From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpuidle / menu: Return error code if there are no suitable states
Date: Sun, 27 Apr 2014 14:55:30 +0200
Message-ID: <6832089.A5AOPipfbA@vostro.rjw.lan>
References: <2471963.urOyfY8mOG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58240 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751154AbaD0MjO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 08:39:14 -0400
In-Reply-To: <2471963.urOyfY8mOG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If there is a PM QoS latency limit and all of the sufficiently shallow
C-states are disabled, the cpuidle menu governor returns 0 which on
some systems is CPUIDLE_DRIVER_STATE_START and shouldn't be returned
if that C-state has been disabled.

Fix the issue by modifying the menu governor to return an error code
in such situations.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    2 +-
 include/linux/cpuidle.h          |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -296,7 +296,7 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	data->last_state_idx = 0;
+	data->last_state_idx = CPUIDLE_DRIVER_STATE_POLL;
 
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0))
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -217,8 +217,10 @@ static inline int cpuidle_register_gover
 
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
 #define CPUIDLE_DRIVER_STATE_START	1
+#define CPUIDLE_DRIVER_STATE_POLL	0
 #else
 #define CPUIDLE_DRIVER_STATE_START	0
+#define CPUIDLE_DRIVER_STATE_POLL	(-ENXIO)
 #endif
 
 #endif /* _LINUX_CPUIDLE_H */

