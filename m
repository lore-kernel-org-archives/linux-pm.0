From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: intel_pstate: Remove unused member name of cpudata
Date: Tue, 20 May 2014 21:12:27 +0300
Message-ID: <537B9B0B.1020404@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:59339 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751864AbaETSMb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 14:12:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org >> LKML" <linux-kernel@vger.kernel.org>

Although, a value is assigned to member name of struct cpudata,
it is never used.

We can safely remove it.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/intel_pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 24a534a..a6d5afa 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -88,8 +88,6 @@ struct _pid {
 struct cpudata {
 	int cpu;
 
-	char name[64];
-
 	struct timer_list timer;
 
 	struct pstate_data pstate;
@@ -544,8 +542,6 @@ static inline void intel_pstate_pstate_decrease(struct cpudata *cpu, int steps)
 
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
-	sprintf(cpu->name, "Intel 2nd generation core");
-
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
 	cpu->pstate.max_pstate = pstate_funcs.get_max();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
-- 
1.9.0
