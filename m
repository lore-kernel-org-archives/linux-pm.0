From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/2] thermal: ti-soc-thermal: Do not print error message in the EPROBE_DEFER case
Date: Fri, 12 Dec 2014 10:14:25 -0400
Message-ID: <1418393665-16850-3-git-send-email-edubezval@gmail.com>
References: <1418393665-16850-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418393665-16850-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Avoid printing the error message in the EPROBE_DEFER case
where registering cpu cooling at ti-soc-thermal thermal driver.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 5f07d7e..096fb21 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -405,9 +405,14 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	/* Register cooling device */
 	data->cool_dev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR(data->cool_dev)) {
-		dev_err(bgp->dev,
-			"Failed to register cpufreq cooling device\n");
-		return PTR_ERR(data->cool_dev);
+		int ret = PTR_ERR(data->cool_dev);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(bgp->dev,
+				"Failed to register cpu cooling device %d\n",
+				ret);
+
+		return ret;
 	}
 	ti_bandgap_set_sensor_data(bgp, id, data);
 
-- 
2.1.3
