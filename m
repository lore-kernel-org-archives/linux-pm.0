From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: fix spelling mistake: supply: "Celcius" -> "Celsius"
Date: Wed, 28 Dec 2016 21:59:26 +0000
Message-ID: <20161228215926.8111-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbcL1WAM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 17:00:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in comments in the headers

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/ab8500_btemp.c    | 6 +++---
 drivers/power/supply/bq24190_charger.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 6ffdc18..ae0a84f 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -76,8 +76,8 @@ struct ab8500_btemp_ranges {
  * @dev:		Pointer to the structure device
  * @node:		List of AB8500 BTEMPs, hence prepared for reentrance
  * @curr_source:	What current source we use, in uA
- * @bat_temp:		Dispatched battery temperature in degree Celcius
- * @prev_bat_temp	Last measured battery temperature in degree Celcius
+ * @bat_temp:		Dispatched battery temperature in degree Celsius
+ * @prev_bat_temp	Last measured battery temperature in degree Celsius
  * @parent:		Pointer to the struct ab8500
  * @gpadc:		Pointer to the struct gpadc
  * @fg:			Pointer to the struct fg
@@ -464,7 +464,7 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
  * @tbl_size:	size of the resistance to temperature table
  * @res:	resistance to calculate the temperature from
  *
- * This function returns the battery temperature in degrees Celcius
+ * This function returns the battery temperature in degrees Celsius
  * based on the NTC resistance.
  */
 static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index e958433..2f333ef 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -199,7 +199,7 @@ static const int bq24190_cvc_vreg_values[] = {
 	4400000
 };
 
-/* REG06[1:0] (TREG) in tenths of degrees Celcius */
+/* REG06[1:0] (TREG) in tenths of degrees Celsius */
 static const int bq24190_ictrc_treg_values[] = {
 	600, 800, 1000, 1200
 };
-- 
2.10.2

