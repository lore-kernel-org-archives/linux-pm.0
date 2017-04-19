From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH RESEND] cpuidle: cpuidle-cps: remove unused variable
Date: Wed, 19 Apr 2017 13:20:54 +0200
Message-ID: <1492600854-23810-1-git-send-email-marcin.nowakowski@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:29394 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934010AbdDSLU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 07:20:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "^Cfael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Marcin Nowakowski <marcin.nowakowski@imgtec.com>, trivial@kernel.org

'core' in cps_cpuidle_init has never been used and is unnecessary, so
remove the dead code.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: trivial@kernel.org
---
 Re-sending to the linux-pm mailing list, as I missed it earlier

 drivers/cpuidle/cpuidle-cps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
index 926ba98..12b9145 100644
--- a/drivers/cpuidle/cpuidle-cps.c
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -118,7 +118,7 @@ static void __init cps_cpuidle_unregister(void)
 
 static int __init cps_cpuidle_init(void)
 {
-	int err, cpu, core, i;
+	int err, cpu, i;
 	struct cpuidle_device *device;
 
 	/* Detect supported states */
@@ -160,7 +160,6 @@ static int __init cps_cpuidle_init(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		core = cpu_data[cpu].core;
 		device = &per_cpu(cpuidle_dev, cpu);
 		device->cpu = cpu;
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-- 
2.7.4
