From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] opp: ti-opp-supply: Correct the supply in _get_optimal_vdd_voltage call
Date: Wed, 7 Nov 2018 10:04:23 +0530
Message-ID: <1541565263-8296-3-git-send-email-j-keerthy@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-pm@vger.kernel.org

_get_optimal_vdd_voltage call provides new_supply_vbb->u_volt
as the reference voltage while it should be really new_supply_vdd->u_volt.

Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/opp/ti-opp-supply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 29e08a4..3f4fb4d 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -288,7 +288,7 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 	int ret;
 
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
-					  new_supply_vbb->u_volt);
+					  new_supply_vdd->u_volt);
 
 	if (new_supply_vdd->u_volt_min < vdd_uv)
 		new_supply_vdd->u_volt_min = vdd_uv;
-- 
1.9.1
