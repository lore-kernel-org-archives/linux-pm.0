From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] power: supply: constify psy_tcd_ops.
Date: Tue, 13 Jun 2017 10:39:43 +0530
Message-ID: <52491fb24dcf85b8e5624a9582d68784e762656c.1497330213.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

File size before:
text	data	bss	dec   hex filename
4240	 200	 80	4520 11a8 drivers/power/supply/power_supply_core.o

File size After adding 'const':
text	data	bss	dec   hex filename
4296	 136	 80	4512 11a0 drivers/power/supply/power_supply_core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 7ec7c7c..2cc64b8 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -669,7 +669,7 @@ static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
 	return ret;
 }
 
-static struct thermal_cooling_device_ops psy_tcd_ops = {
+static const struct thermal_cooling_device_ops psy_tcd_ops = {
 	.get_max_state = ps_get_max_charge_cntl_limit,
 	.get_cur_state = ps_get_cur_chrage_cntl_limit,
 	.set_cur_state = ps_set_cur_charge_cntl_limit,
-- 
1.9.1
