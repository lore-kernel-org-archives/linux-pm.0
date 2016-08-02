From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0124/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:28 +0800
Message-ID: <20160802104228.22018-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/cpufreq/speedstep-smi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 770a9ae..dffd887 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -378,9 +378,9 @@ static void __exit speedstep_exit(void)
 	cpufreq_unregister_driver(&speedstep_driver);
 }
 
-module_param(smi_port, int, 0444);
-module_param(smi_cmd,  int, 0444);
-module_param(smi_sig, uint, 0444);
+module_param(smi_port, int, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(smi_cmd,  int, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(smi_sig, uint, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_PARM_DESC(smi_port, "Override the BIOS-given IST port with this value "
 		"-- Intel's default setting is 0xb2");
-- 
2.9.2
