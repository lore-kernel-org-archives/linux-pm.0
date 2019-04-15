From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] power: supply: core: fix typo in function to get current charge control limit
Date: Mon, 15 Apr 2019 16:29:18 +0200
Message-ID: <20190415142918.4383-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is a spelling mistake in ps_get_cur_charge_cntl_limit function so
replace 'chrage' for 'charge'.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/power/supply/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c917a8b43b2b..ef2aecfe2cd2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -899,7 +899,7 @@ static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
 	return ret;
 }
 
-static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd,
+static int ps_get_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
 					unsigned long *state)
 {
 	struct power_supply *psy;
@@ -934,7 +934,7 @@ static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
 
 static const struct thermal_cooling_device_ops psy_tcd_ops = {
 	.get_max_state = ps_get_max_charge_cntl_limit,
-	.get_cur_state = ps_get_cur_chrage_cntl_limit,
+	.get_cur_state = ps_get_cur_charge_cntl_limit,
 	.set_cur_state = ps_set_cur_charge_cntl_limit,
 };
 
-- 
2.20.1
