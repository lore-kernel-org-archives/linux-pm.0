From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 11/13] thermal: qoriq: Do not report invalid temperature reading
Date: Sun, 31 Mar 2019 21:14:16 -0700
Message-ID: <20190401041418.5999-12-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Before returning measured temperature data to upper layer we need to
make sure that the reading was marked as "valid" to avoid reporting
bogus data.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7ff93dfcd68b..9d227654f879 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -37,6 +37,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -62,10 +63,18 @@ static int tmu_get_temp(void *p, int *temp)
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
+	int ret;
 
-	regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
-	*temp = (val & 0xff) * 1000;
+	ret = regmap_read_poll_timeout(qdata->regmap,
+				       REGS_TRITSR(qsensor->id),
+				       val,
+				       val & TRITSR_V,
+				       USEC_PER_MSEC,
+				       10 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
+	*temp = (val & 0xff) * 1000;
 	return 0;
 }
 
-- 
2.20.1
