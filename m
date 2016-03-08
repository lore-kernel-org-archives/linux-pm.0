From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 1/4] intel_pstate: Remove extra conversions in pid calculation
Date: Tue,  8 Mar 2016 10:31:15 +0100
Message-ID: <1457429481-13283-4-git-send-email-philippe.longepe@linux.intel.com>
References: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17831 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbcCHJaP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 04:30:15 -0500
In-Reply-To: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

pid->setpoint and pid->deadband can be initialized in fixed point, so we
can avoid the int_tofp in pid_calc.

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

