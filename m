From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/13] intel_idle: Propagate hot plug errors.
Date: Wed,  6 Apr 2016 17:00:56 -0400
Message-ID: <169b3a75e4fd7024ad14c6abbecaeba27016414d.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Richard Cochran <rcochran@linutronix.de>

If a cpuidle registration error occurs during the hot plug notifier
callback, we should really inform the hot plug machinery instead of
just ignoring the error.  This patch changes the callback to properly
return on error.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 807be29..45e93f4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -879,8 +879,11 @@ static int cpu_hotplug_notify(struct notifier_block *n,
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
2.8.0.rc4.16.g56331f8
