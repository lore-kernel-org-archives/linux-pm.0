From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0119/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:05 +0800
Message-ID: <20160802104205.21683-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36088 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920AbcHBLTs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 07:19:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/cpufreq/gx-suspmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 3488c9c..25a4e48 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -126,7 +126,7 @@ static int stock_freq;
 
 /* PCI bus clock - defaults to 30.000 if cpu_khz is not available */
 static int pci_busclk;
-module_param(pci_busclk, int, 0444);
+module_param(pci_busclk, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 /* maximum duration for which the cpu may be suspended
  * (32us * MAX_DURATION). If no parameter is given, this defaults
@@ -135,7 +135,7 @@ module_param(pci_busclk, int, 0444);
  * is suspended -- processing power is just 0.39% of what it used to be,
  * though. 781.25 kHz(!) for a 200 MHz processor -- wow. */
 static int max_duration = 255;
-module_param(max_duration, int, 0444);
+module_param(max_duration, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 /* For the default policy, we want at least some processing power
  * - let's say 5%. (min = maxfreq / POLICY_MIN_DIV)
-- 
2.9.2

