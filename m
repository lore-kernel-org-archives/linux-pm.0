From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0118/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:00 +0800
Message-ID: <20160802104200.21617-1-baolex.ni@intel.com>
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
 drivers/cpufreq/elanfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index bfce11c..7ca0395 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -223,7 +223,7 @@ static void __exit elanfreq_exit(void)
 }
 
 
-module_param(max_freq, int, 0444);
+module_param(max_freq, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, "
-- 
2.9.2
