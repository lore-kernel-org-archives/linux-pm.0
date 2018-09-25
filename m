From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 12/14] thermal/drivers/hisi: Add more sensors channel
Date: Tue, 25 Sep 2018 11:03:10 +0200
Message-ID: <1537866192-12320-13-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Add the sensor channels id for the little, g3d and modem.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 87d8a13..ba89cb9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -56,7 +56,12 @@
 #define HI3660_TEMP_LAG			(4000)
 
 #define HI6220_CLUSTER0_SENSOR		2
+#define HI6220_CLUSTER1_SENSOR		1
+
+#define HI3660_LITTLE_SENSOR		0
 #define HI3660_BIG_SENSOR		1
+#define HI3660_G3D_SENSOR		2
+#define HI3660_MODEM_SENSOR		3
 
 struct hisi_thermal_data;
 
-- 
2.7.4
