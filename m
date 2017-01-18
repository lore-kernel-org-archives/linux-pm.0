From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH] x86/itmt: Remove unnecessary check to update topology
Date: Wed, 18 Jan 2017 14:30:29 -0800
Message-ID: <1484778629-4404-1-git-send-email-tim.c.chen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbdASAsD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Jan 2017 19:48:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Scheduling to max performance core is enabled by
default for Turbo Boost Maxt Technology 3.0 capable platforms.
Remove useless sysctl_sched_itmt_enabled check to
update sched topology for adding prioritized core scheduling flag.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/itmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index cb9c1ed..f73f475 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -132,10 +132,8 @@ int sched_set_itmt_support(void)
 
 	sysctl_sched_itmt_enabled = 1;
 
-	if (sysctl_sched_itmt_enabled) {
-		x86_topology_update = true;
-		rebuild_sched_domains();
-	}
+	x86_topology_update = true;
+	rebuild_sched_domains();
 
 	mutex_unlock(&itmt_update_mutex);
 
-- 
2.5.5

