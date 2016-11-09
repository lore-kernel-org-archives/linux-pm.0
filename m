From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] thermal/powerclamp: add back module device table
Date: Wed,  9 Nov 2016 07:01:01 -0800
Message-ID: <1478703661-10875-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: eric.ernst@linux.intel.com, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 replaced module
cpu id table with a cpu feature check, which is logically correct.
But we need the module device table to allow module auto loading.
---
 drivers/thermal/intel_powerclamp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index f0bad48..c82b41f 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -694,9 +694,16 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 	.set_cur_state = powerclamp_set_cur_state,
 };
 
+static const struct x86_cpu_id __initconst intel_powerclamp_ids[] = {
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
+
 static int __init powerclamp_probe(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+
+	if (!x86_match_cpu(intel_powerclamp_ids)) {
 		pr_err("CPU does not support MWAIT");
 		return -ENODEV;
 	}
-- 
1.9.1
