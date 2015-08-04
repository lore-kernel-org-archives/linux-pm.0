From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH v2 1/3] cpuidle/coupled: Remove cpuidle_device::safe_state_index
Date: Tue,  4 Aug 2015 13:48:55 +0800
Message-ID: <1438667337-16903-1-git-send-email-xlpang@126.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-112.126.com ([123.125.50.112]:39819 "EHLO m50-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbbHDFvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Aug 2015 01:51:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

cpuidle_device::safe_state_index need to be initialized before
use, it should be the same as cpuidle_driver::safe_state_index.

We tackled this issue by removing the safe_state_index from the
cpuidle_device structure and use the one in the cpuidle_driver
structure instead.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/cpuidle/coupled.c | 4 ++--
 include/linux/cpuidle.h   | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 7936dce..6493e40 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -473,7 +473,7 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 			return entered_state;
 		}
 		entered_state = cpuidle_enter_state(dev, drv,
-			dev->safe_state_index);
+			drv->safe_state_index);
 		local_irq_disable();
 	}
 
@@ -521,7 +521,7 @@ retry:
 		}
 
 		entered_state = cpuidle_enter_state(dev, drv,
-			dev->safe_state_index);
+			drv->safe_state_index);
 		local_irq_disable();
 	}
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d075d34..786ad32 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -84,7 +84,6 @@ struct cpuidle_device {
 	struct list_head 	device_list;
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-	int			safe_state_index;
 	cpumask_t		coupled_cpus;
 	struct cpuidle_coupled	*coupled;
 #endif
-- 
1.9.1


