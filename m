From: dirk.brandewie@gmail.com
Subject: [PATCH 3/5] intel_pstate: fix pid_reset to use fixed point values
Date: Wed, 12 Feb 2014 10:01:05 -0800
Message-ID: <1392228067-14817-4-git-send-email-dirk.j.brandewie@intel.com>
References: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

commit d253d2a526 Improve accuracy by not truncating until final
result, changed internal variables of the PID to be fixed point
numbers. Update the pid_reset() to reflect this change.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d692b10..b80c03d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -150,7 +150,7 @@ static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 	pid->setpoint = setpoint;
 	pid->deadband  = deadband;
 	pid->integral  = int_tofp(integral);
-	pid->last_err  = setpoint - busy;
+	pid->last_err  = int_tofp(setpoint) - int_tofp(busy);
 }
 
 static inline void pid_p_gain_set(struct _pid *pid, int percent)
-- 
1.8.3.1
