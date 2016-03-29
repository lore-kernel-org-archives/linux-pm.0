From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 09/10] intel_idle: Propagate hot plug errors.
Date: Tue, 29 Mar 2016 15:16:01 +0200
Message-ID: <a5a301488f49f278c7998d72cfadce052f5eadb8.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If a cpuidle registration error occurs during the hot plug notifier
callback, we should really inform the hot plug machinery instead of
just ignoring the error.  This patch changes the callback to properly
return on error.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 4418cfa..8420ba1 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -818,8 +818,11 @@ static int cpu_hotplug_notify(struct notifier_block *n,
 		 * driver in this case
 		 */
 		dev = per_cpu_ptr(intel_idle_cpuidle_devices, hotcpu);
-		if (!dev->registered)
-			intel_idle_cpu_init(hotcpu);
+		if (dev->registered)
+			break;
+
+		if (intel_idle_cpu_init(hotcpu))
+			return NOTIFY_BAD;
 
 		break;
 	}
-- 
2.1.4
