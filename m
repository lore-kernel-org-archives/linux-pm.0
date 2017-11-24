From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 03/10] PM / QoS: Fix device resume latency for non PM QoS devices
Date: Fri, 24 Nov 2017 21:23:13 +0530
Message-ID: <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

In 'commit 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")'
PM QoS resume latency modified 0 as "no latency at all". However
dev_pm_qos_raw_read_value() returns 0 for devices which doesn't have
PM QoS constraints. This is blocking runtime suspend for these devices
in rpm_check_suspend_allowed(). Return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
when PM QoS constraints are not available for a particular device.

Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/pm_qos.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6737a8c9e8c6..d68b0569a5eb 100644
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
2.1.4
