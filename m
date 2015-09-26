From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] intel_idle: Skylake Client Support - updated
Date: Sat, 26 Sep 2015 01:05:12 -0400
Message-ID: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
References: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Addition of PC9 state, and minor tweaks to existing PC6 and PC8 states.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3a3738f..cd4510a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -620,7 +620,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.name = "C6-SKL",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
-		.exit_latency = 75,
+		.exit_latency = 85,
 		.target_residency = 200,
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
@@ -636,11 +636,19 @@ static struct cpuidle_state skl_cstates[] = {
 		.name = "C8-SKL",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
-		.exit_latency = 174,
+		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
 		.enter_freeze = intel_idle_freeze, },
 	{
+		.name = "C9-SKL",
+		.desc = "MWAIT 0x50",
+		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 480,
+		.target_residency = 5000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
 		.name = "C10-SKL",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
-- 
2.6.0.rc1
