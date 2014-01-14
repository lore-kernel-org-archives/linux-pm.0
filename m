From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [PATCH v1 4/6] pseries/cpuidle: Make cpuidle-pseries backend driver
 a non-module.
Date: Tue, 14 Jan 2014 16:26:18 +0530
Message-ID: <20140114105615.3064.90274.stgit@deepthi.in.ibm.com>
References: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114105525.3064.52013.stgit@deepthi.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, benh@kernel.crashing.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

Currently cpuidle-pseries backend driver cannot be
built as a module due to dependencies wrt cpuidle framework.
This patch removes all the module related code in the driver.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-pseries.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 32d86bc..5e13f6c 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -289,17 +289,4 @@ static int __init pseries_processor_idle_init(void)
 	return 0;
 }
 
-static void __exit pseries_processor_idle_exit(void)
-{
-
-	unregister_cpu_notifier(&setup_hotplug_notifier);
-	cpuidle_unregister(&pseries_idle_driver);
-	return;
-}
-
-module_init(pseries_processor_idle_init);
-module_exit(pseries_processor_idle_exit);
-
-MODULE_AUTHOR("Deepthi Dharwar <deepthi@linux.vnet.ibm.com>");
-MODULE_DESCRIPTION("Cpuidle driver for POWER");
-MODULE_LICENSE("GPL");
+device_initcall(pseries_processor_idle_init);
