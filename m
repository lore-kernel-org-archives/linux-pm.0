From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/9] POWERPC: pseries: cpuidle: remove superfluous
 dev->state_count initialization
Date: Fri, 20 Dec 2013 19:47:24 +0100
Message-ID: <1387565251-7051-3-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

pseries cpuidle driver sets dev->state_count to drv->state_count so
the default dev->state_count initialization in cpuidle_enable_device()
(called from cpuidle_register_device()) can be used instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a166e38..8aa8c40 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -271,7 +271,6 @@ static void pseries_idle_devices_uninit(void)
 static int pseries_idle_devices_init(void)
 {
 	int i;
-	struct cpuidle_driver *drv = &pseries_idle_driver;
 	struct cpuidle_device *dev;
 
 	pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
@@ -280,7 +279,6 @@ static int pseries_idle_devices_init(void)
 
 	for_each_possible_cpu(i) {
 		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
-		dev->state_count = drv->state_count;
 		dev->cpu = i;
 		if (cpuidle_register_device(dev)) {
 			printk(KERN_DEBUG \
-- 
1.8.2.3
