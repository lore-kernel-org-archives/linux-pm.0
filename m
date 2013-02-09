From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/16] davinci: cpuidle - remove useless initialization
Date: Fri,  8 Feb 2013 20:08:09 -0500
Message-ID: <748f11772154b58426c856b7d90538a9b60ae29a.1360371180.git.len.brown@intel.com>
References: <1360372100-28482-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360372100-28482-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b1beab48f6148d50fee4a56d741cc3168fe1b995.1360371180.git.len.brown@intel.com>
References: <b1beab48f6148d50fee4a56d741cc3168fe1b995.1360371180.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The device->state_count is initialized in the cpuidle_register_device
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/arm/mach-davinci/cpuidle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 5e430bf..5ac9e93 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -96,8 +96,6 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
 	ddr2_pdown = pdata->ddr2_pdown;
 
-	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
-
 	ret = cpuidle_register_driver(&davinci_idle_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register driver\n");
-- 
1.8.1.3.535.ga923c31
