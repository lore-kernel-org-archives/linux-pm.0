From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0115/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:41:47 +0800
Message-ID: <20160802104147.21419-1-baolex.ni@intel.com>
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
 drivers/cpufreq/cpufreq-nforce2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index 5503d49..60f2dcb 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -51,8 +51,8 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
 MODULE_LICENSE("GPL");
 
-module_param(fid, int, 0444);
-module_param(min_fsb, int, 0444);
+module_param(fid, int, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(min_fsb, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_PARM_DESC(fid, "CPU multiplier to use (11.5 = 115)");
 MODULE_PARM_DESC(min_fsb,
-- 
2.9.2
