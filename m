From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 6/6] devfreq: rk3399_dmc: fix spelling mistakes.
Date: Wed,  9 May 2018 14:57:48 +0200
Message-ID: <20180509125749.31318-7-enric.balletbo@collabora.com>
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509125749.31318-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org, kernel@collabora.com, hl@rock-chips.com, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Fix some spelling mistakes in error and debug messages.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4:
- [6/6] Introduce this new patch that fixes some spelling.

Changes in v3: None
Changes in v2: None

 drivers/devfreq/rk3399_dmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5bfca028eaaf..d5c03e5abe13 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -103,7 +103,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
 					    target_volt);
 		if (err) {
-			dev_err(dev, "Cannot to set voltage %lu uV\n",
+			dev_err(dev, "Cannot set voltage %lu uV\n",
 				target_volt);
 			goto out;
 		}
@@ -111,8 +111,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
 	if (err) {
-		dev_err(dev, "Cannot to set frequency %lu (%d)\n",
-			target_rate, err);
+		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
+			err);
 		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
 				      dmcfreq->volt);
 		goto out;
@@ -128,8 +128,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	/* If get the incorrect rate, set voltage to old value. */
 	if (dmcfreq->rate != target_rate) {
-		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu,\
-			Current frequency %lu\n", target_rate, dmcfreq->rate);
+		dev_err(dev, "Got wrong frequency, Request %lu, Current %lu\n",
+			target_rate, dmcfreq->rate);
 		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
 				      dmcfreq->volt);
 		goto out;
@@ -137,7 +137,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
 					    target_volt);
 	if (err)
-		dev_err(dev, "Cannot to set vol %lu uV\n", target_volt);
+		dev_err(dev, "Cannot set voltage %lu uV\n", target_volt);
 
 	dmcfreq->rate = target_rate;
 	dmcfreq->volt = target_volt;
-- 
2.17.0
