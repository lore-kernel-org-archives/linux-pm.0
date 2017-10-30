From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Mon, 30 Oct 2017 09:10:46 +0200
Message-ID: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
List-Id: linux-pm@vger.kernel.org

The recent change to the PM QoS framework to introduce a proper
no constraint value overlooked to handle the devices which don't
implement PM QoS OPS. Runtime PM is one of the more severely
impacted subsystems, failing every attempt to runtime suspend
a device. This leads into some nasty second level issues like
probe failures and increased power consumption among other things.

Fix this by adding a proper return value for devices that don't
implement PM QoS implicitly.

Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6737a8c..d68b056 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -175,7 +175,8 @@ static inline s32 dev_pm_qos_requested_flags(struct device *dev)
 static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
 {
 	return IS_ERR_OR_NULL(dev->power.qos) ?
-		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
+		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
+		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
