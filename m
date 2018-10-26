From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] ARM: cpuidle: Convert to use cpuidle_register|unregister()
Date: Fri, 26 Oct 2018 16:49:15 +0200
Message-ID: <20181026144915.3084-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The only reason that remains, to why the ARM cpuidle driver calls
cpuidle_register_driver(), is to avoid printing an error message in case
another driver already have been registered for the CPU. This seems a bit
silly, but more importantly, if that is a common scenario, perhaps we
should change cpuidle_register() accordingly instead.

In either case, let's consolidate the code, by converting to use
cpuidle_register|unregsiter(), which also avoids the unnecessary allocation
of the struct cpuidle_device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index df564d783216..3a407a3ef22b 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -82,7 +82,6 @@ static int __init arm_idle_init_cpu(int cpu)
 {
 	int ret;
 	struct cpuidle_driver *drv;
-	struct cpuidle_device *dev;
 
 	drv = kmemdup(&arm_idle_driver, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
@@ -119,33 +118,12 @@ static int __init arm_idle_init_cpu(int cpu)
 		goto out_kfree_drv;
 	}
 
-	ret = cpuidle_register_driver(drv);
-	if (ret) {
-		if (ret != -EBUSY)
-			pr_err("Failed to register cpuidle driver\n");
+	ret = cpuidle_register(drv, NULL);
+	if (ret)
 		goto out_kfree_drv;
-	}
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto out_unregister_drv;
-	}
-	dev->cpu = cpu;
-
-	ret = cpuidle_register_device(dev);
-	if (ret) {
-		pr_err("Failed to register cpuidle device for CPU %d\n",
-		       cpu);
-		goto out_kfree_dev;
-	}
 
 	return 0;
 
-out_kfree_dev:
-	kfree(dev);
-out_unregister_drv:
-	cpuidle_unregister_driver(drv);
 out_kfree_drv:
 	kfree(drv);
 	return ret;
@@ -176,9 +154,7 @@ static int __init arm_idle_init(void)
 	while (--cpu >= 0) {
 		dev = per_cpu(cpuidle_devices, cpu);
 		drv = cpuidle_get_cpu_driver(dev);
-		cpuidle_unregister_device(dev);
-		cpuidle_unregister_driver(drv);
-		kfree(dev);
+		cpuidle_unregister(drv);
 		kfree(drv);
 	}
 
-- 
2.17.1
