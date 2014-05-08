From: dirk.brandewie@gmail.com
Subject: [PATCH 5/5] intel_pstate: Add CPU IDs for Broadwell processors
Date: Thu,  8 May 2014 12:57:27 -0700
Message-ID: <1399579047-5792-6-git-send-email-dirk.j.brandewie@intel.com>
References: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Add support the Broadwell processors.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4c26faf..6ef6f7f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -663,10 +663,13 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x37, byt_params),
 	ICPU(0x3a, core_params),
 	ICPU(0x3c, core_params),
+	ICPU(0x3d, core_params),
 	ICPU(0x3e, core_params),
 	ICPU(0x3f, core_params),
 	ICPU(0x45, core_params),
 	ICPU(0x46, core_params),
+	ICPU(0x4f, core_params),
+	ICPU(0x56, core_params),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
1.9.0
