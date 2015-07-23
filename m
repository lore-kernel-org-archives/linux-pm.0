From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RESEND PATCH] cpupower: Do not change the frequency of offline cpu
Date: Thu, 23 Jul 2015 12:20:27 +0530
Message-ID: <1437634227-12555-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:45463 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbGWGuo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 02:50:44 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Thu, 23 Jul 2015 12:20:40 +0530
In-Reply-To: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: trenn@suse.com, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Check if the cpu is online before changing the frequency/governor of
the cpu.

Reported-by: Pavaman Subramaniyam <pavsubra@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Thomas Renninger <trenn@suse.com>
---

Included Reported-by tag

 tools/power/cpupower/utils/cpufreq-set.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index f656e58..4e21357 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -17,6 +17,7 @@
 
 #include "cpufreq.h"
 #include "helpers/helpers.h"
+#include "helpers/sysfs.h"
 
 #define NORM_FREQ_LEN 32
 
@@ -318,6 +319,9 @@ int cmd_freq_set(int argc, char **argv)
 		    cpufreq_cpu_exists(cpu))
 			continue;
 
+		if (sysfs_is_cpu_online(cpu) != 1)
+			continue;
+
 		printf(_("Setting cpu: %d\n"), cpu);
 		ret = do_one_cpu(cpu, &new_pol, freq, policychange);
 		if (ret) {
-- 
1.9.3

