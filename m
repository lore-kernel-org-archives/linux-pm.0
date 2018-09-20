From: Matt Lupfer <mlupfer@ddn.com>
Subject: [PATCH] tools/power: Fix typo in man page
Date: Thu, 20 Sep 2018 10:31:44 -0400
Message-ID: <20180920143144.12210-1-mlupfer@ddn.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Matt Lupfer <mlupfer@ddn.com>
List-Id: linux-pm@vger.kernel.org

>From context, we mean EPB (Enegry Performance Bias).

Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 17db1c3af4d0..78c6361898b1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -40,7 +40,7 @@ in the same processor package.
 Hardware P-States (HWP) are effectively an expansion of hardware
 P-state control from the opportunistic turbo-mode P-state range
 to include the entire range of available P-states.
-On Broadwell Xeon, the initial HWP implementation, EBP influenced HWP.
+On Broadwell Xeon, the initial HWP implementation, EPB influenced HWP.
 That influence was removed in subsequent generations,
 where it was moved to the
 Energy_Performance_Preference (EPP) field in
-- 
2.17.1
