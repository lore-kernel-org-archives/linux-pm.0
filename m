From: Eric Ernst <eric.ernst@linux.intel.com>
Subject: [PATCH 1/1] thermal/powerclamp: correct cpu support check
Date: Thu,  6 Oct 2016 08:56:49 -0700
Message-ID: <1475769409-188472-1-git-send-email-eric.ernst@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:39292 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942073AbcJFP7Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Oct 2016 11:59:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, rafael.j.wysocki@intel.com, jacob.jun.pan@linux.intel.com, Eric Ernst <eric.ernst@linux.intel.com>

Initial logic for checking CPU match resulted in OR of CPU features
rather than the intended AND.

Updated to use boot_cpu_has macro rather than x86_match_cpu.

In addition, MWAIT is the only required CPU feature for idle
injection to work.  Drop other feature requirements since they are
only needed for optimal efficiency.

Signed-off-by: Eric Ernst <eric.ernst@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 0e4dc0afcfd2..7a223074df3d 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -669,20 +669,10 @@ static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 	.set_cur_state = powerclamp_set_cur_state,
 };
 
-static const struct x86_cpu_id intel_powerclamp_ids[] __initconst = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_ARAT },
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_NONSTOP_TSC },
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_CONSTANT_TSC},
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
-
 static int __init powerclamp_probe(void)
 {
-	if (!x86_match_cpu(intel_powerclamp_ids)) {
-		pr_err("Intel powerclamp does not run on family %d model %d\n",
-				boot_cpu_data.x86, boot_cpu_data.x86_model);
+	if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+		pr_err("CPU does not support MWAIT");
 		return -ENODEV;
 	}
 
-- 
1.9.1

