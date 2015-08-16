From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/7] intel_idle: allow idle states to be freeze-mode specific
Date: Sat, 15 Aug 2015 23:25:47 -0400
Message-ID: <7dd0e0af64afe4aa08ccdd167f64bd007f09b515.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
In-Reply-To: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

intel_idle uses a NULL "enter" field in a cpuidle state
to recognize the invalid entry terminating a variable-length array.

Linux-4.0 added support for the system-wide "freeze" state
in cpuidle drivers via the new "enter_freeze" field.

The natural way to expose a deep idle state for freeze,
but not for run-time idle is to supply "enter_freeze" without "enter";
so we update the driver to accept such states.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 2a36a95..008e943 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -965,7 +965,8 @@ static int __init intel_idle_cpuidle_driver_init(void)
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
 		int num_substates, mwait_hint, mwait_cstate;
 
-		if (cpuidle_state_table[cstate].enter == NULL)
+		if ((cpuidle_state_table[cstate].enter == NULL) &&
+		    (cpuidle_state_table[cstate].enter_freeze == NULL))
 			break;
 
 		if (cstate + 1 > max_cstate) {
-- 
2.5.0.330.g130be8e
