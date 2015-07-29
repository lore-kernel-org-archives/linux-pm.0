From: Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH] intel_pstate: Fix possible overflow complained by Coverity
Date: Wed, 29 Jul 2015 23:53:10 +0800
Message-ID: <1438185190-12805-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32029 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbbG2Ptj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jul 2015 11:49:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: kristen.c.accardi@intel.com, rui.zhang@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, Chen Yu <yu.c.chen@intel.com>

Coverity scanning performed on intel_pstate.c shows possible
overflow when doing left shifting:
val = pstate << 8;
since pstate is of type integer, while val is of u64, left shifting
pstate might lead to potential loss of upper bits. Say, if pstate equals
0x4000 0000, after pstate << 8 we will get zero assigned to val.
Although pstate will not likely be that big, this patch cast the left
operand to u64 before performing the left shift, to avoid complaining
from Coverity.

Reported-by: Coquard, Christophe <christophe.coquard@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 15ada47..6effe81 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -522,7 +522,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
 	int32_t vid_fp;
 	u32 vid;
 
-	val = pstate << 8;
+	val = (u64)pstate << 8;
 	if (limits.no_turbo && !limits.turbo_disabled)
 		val |= (u64)1 << 32;
 
@@ -611,7 +611,7 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
 {
 	u64 val;
 
-	val = pstate << 8;
+	val = (u64)pstate << 8;
 	if (limits.no_turbo && !limits.turbo_disabled)
 		val |= (u64)1 << 32;
 
-- 
1.9.1

