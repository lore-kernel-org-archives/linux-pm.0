From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: Add a kerneldoc comment to cpuidle_use_deepest_state()
Date: Thu, 01 Dec 2016 23:31:32 +0100
Message-ID: <2540734.8hJE4QlsmK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58087 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761188AbcLAWfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 17:35:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since cpuidle_use_deepest_state() is not static, add a proper
kerneldoc comment to it to document its purpose.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -97,7 +97,13 @@ static int find_deepest_state(struct cpu
 	return ret;
 }
 
-/* Set the current cpu to use the deepest idle state, override governors */
+/**
+ * cpuidle_use_deepest_state - Set/clear governor override flag.
+ * @enable: New value of the flag.
+ *
+ * Set/unset the current CPU to use the deepest idle state (override governors
+ * going forward if set).
+ */
 void cpuidle_use_deepest_state(bool enable)
 {
 	struct cpuidle_device *dev;

