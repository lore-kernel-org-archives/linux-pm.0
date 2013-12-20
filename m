From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 1/9] ARM: EXYNOS: cpuidle: fix AFTR mode check
Date: Fri, 20 Dec 2013 19:47:23 +0100
Message-ID: <1387565251-7051-2-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

The EXYNOS cpuidle driver code assumes that cpuidle core will handle
dev->state_count smaller than drv->state_count but currently this is
untrue (dev->state_count is used only for handling cpuidle state sysfs
entries and drv->state_count is used for all other cases) and will not
be fixed in the future as dev->state_count is planned to be removed.

Fix the issue by checking for the max supported idle state in AFTR
state's ->enter handler (exynos4_enter_lowpower()) and entering AFTR
mode only when cores other than CPU0 are offline.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index da65b03..f57cb91 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -172,8 +172,8 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 {
 	int new_index = index;
 
-	/* This mode only can be entered when other core's are offline */
-	if (num_online_cpus() > 1)
+	/* AFTR can only be entered when cores other than CPU0 are offline */
+	if (num_online_cpus() > 1 || dev->cpu != 0)
 		new_index = drv->safe_state_index;
 
 	if (new_index == 0)
@@ -235,10 +235,6 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-		/* Support IDLE only */
-		if (cpu_id != 0)
-			device->state_count = 1;
-
 		ret = cpuidle_register_device(device);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register cpuidle device\n");
-- 
1.8.2.3
