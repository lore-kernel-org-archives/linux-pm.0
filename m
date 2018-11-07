From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] opp: ti-opp-supply: Dynamically update u_volt_min
Date: Wed, 7 Nov 2018 10:04:22 +0530
Message-ID: <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-pm@vger.kernel.org

The voltage range (min, max) provided in the device tree is from
the data manual and is pretty big, catering to a wide range of devices.
On a i2c read/write failure the regulator_set_voltage_triplet function
falls back to set voltage between min and max. The min value from Device
Tree can be lesser than the optimal value and in that case that can lead
to a hang or crash. Hence set the u_volt_min dynamically to the optimal
voltage value.

Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/opp/ti-opp-supply.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 9e5a9a3..29e08a4 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -290,6 +290,9 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
 					  new_supply_vbb->u_volt);
 
+	if (new_supply_vdd->u_volt_min < vdd_uv)
+		new_supply_vdd->u_volt_min = vdd_uv;
+
 	/* Scaling up? Scale voltage before frequency */
 	if (freq > old_freq) {
 		ret = _opp_set_voltage(dev, new_supply_vdd, vdd_uv, vdd_reg,
-- 
1.9.1
