From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/76] ARM: davinci: Fix for cpuidle consolidation changes
Date: Fri, 30 Mar 2012 06:13:25 -0400
Message-ID: <6a6ea0acc9375571a13aa8c4e105a0807e1c16a4.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Robert Lee <rob.lee@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Robert Lee <rob.lee@linaro.org>

The recent cpuidle consolidation changes erroneously omitted one
critical line of code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
Tested-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/arm/mach-davinci/cpuidle.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 93ae096..9107691 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -55,10 +55,11 @@ static int davinci_enter_idle(struct cpuidle_device *dev,
 #define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN	BIT(0)
 
 static struct cpuidle_driver davinci_idle_driver = {
-	.name		= "cpuidle-davinci",
-	.owner		= THIS_MODULE,
-	.states[0]	= ARM_CPUIDLE_WFI_STATE,
-	.states[1]	= {
+	.name			= "cpuidle-davinci",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
 		.enter			= davinci_enter_idle,
 		.exit_latency		= 10,
 		.target_residency	= 100000,
-- 
1.7.10.rc2.19.gfae9d

