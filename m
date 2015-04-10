From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: Change the setpoint for atom params
Date: Fri, 10 Apr 2015 11:06:43 -0700
Message-ID: <1428689203-3204-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16372 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316AbbDJSGq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Apr 2015 14:06:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Change the setpoint for the Baytrail and Cherrytrail cpus.  This
will cause more aggressive pstate selection and improves
performance on a variety of workloads with little power penalty.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 872c577..204e43e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -636,7 +636,7 @@ static struct cpu_defaults byt_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
-		.setpoint = 97,
+		.setpoint = 60,
 		.p_gain_pct = 14,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
-- 
1.9.3

