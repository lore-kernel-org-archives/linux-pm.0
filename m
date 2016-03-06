From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V5 1/4] Remove extra conversions in pid calculation
Date: Sun,  6 Mar 2016 08:34:03 +0100
Message-ID: <1457249646-23072-2-git-send-email-philippe.longepe@linux.intel.com>
References: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20429 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcCFHc6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 6 Mar 2016 02:32:58 -0500
In-Reply-To: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

pid->setpoint and pid->deadband can be initialize in float so we
can remove the int_tofp in pid_calc.

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eb0aef0..114e4e0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -198,8 +198,8 @@ static struct perf_limits *limits = &powersave_limits;
 
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 			     int deadband, int integral) {
-	pid->setpoint = setpoint;
-	pid->deadband  = deadband;
+	pid->setpoint = int_tofp(setpoint);
+	pid->deadband  = int_tofp(deadband);
 	pid->integral  = int_tofp(integral);
 	pid->last_err  = int_tofp(setpoint) - int_tofp(busy);
 }
@@ -225,9 +225,9 @@ static signed int pid_calc(struct _pid *pid, int32_t busy)
 	int32_t pterm, dterm, fp_error;
 	int32_t integral_limit;
 
-	fp_error = int_tofp(pid->setpoint) - busy;
+	fp_error = pid->setpoint - busy;
 
-	if (abs(fp_error) <= int_tofp(pid->deadband))
+	if (abs(fp_error) <= pid->deadband)
 		return 0;
 
 	pterm = mul_fp(pid->p_gain, fp_error);
-- 
1.9.1

