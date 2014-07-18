From: dirk.brandewie@gmail.com
Subject: [PATCH 06/11] cpufreq: intel_pstate: Remove unnecessary intermediate variable sample_time
Date: Fri, 18 Jul 2014 08:37:22 -0700
Message-ID: <1405697848-13546-7-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47328 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422773AbaGRPht (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so5641458pad.11
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:48 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

Remove the unnecessary intermediate assignment and use directly the
pid_params.sample_rate_ms variable.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dee9e58..e0ed078 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -599,10 +599,9 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 
 static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 {
-	int sample_time, delay;
+	int delay;
 
-	sample_time = pid_params.sample_rate_ms;
-	delay = msecs_to_jiffies(sample_time);
+	delay = msecs_to_jiffies(pid_params.sample_rate_ms);
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
-- 
1.9.3

