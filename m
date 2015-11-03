From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v1 2/2] intel_pstate: Change the setpoint for the cores
Date: Tue,  3 Nov 2015 10:27:20 +0100
Message-ID: <1446542840-14982-2-git-send-email-philippe.longepe@linux.intel.com>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49435 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbbKCJ00 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Nov 2015 04:26:26 -0500
In-Reply-To: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Stephane Gasparini <stephane.gasparini@linux.intel.com>

Change the setpoint to 60 accordingly to the new core busy scaled formula.
The new formaula is based on the number of cycles per seconds
(average frequency) divided by the requested frequency. So, we need to
chose a setpoint more aggressive to improve performance.

Measured with this parameter, we noticed an improvement in Browsermark
for power and perf compared to the old formula:

Score without the patch: 3517
Power without the patch: 6856 mW

Score with the patch: 3719
Power with the patch: 6265 mW

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 421903f..43f0067 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -872,7 +872,7 @@ static struct cpu_defaults core_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
-		.setpoint = 97,
+		.setpoint = 60,
 		.p_gain_pct = 20,
 		.d_gain_pct = 0,
 		.i_gain_pct = 0,
-- 
1.9.1

