From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: supply: twl4030-charger: make twl4030_bci_property_is_writeable static
Date: Wed,  3 May 2017 11:33:57 +0100
Message-ID: <20170503103357.22598-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37641 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbdECKeC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 06:34:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H . Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function twl4030_bci_property_is_writeable can be made static
as it does not need to be in global scope.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/twl4030_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index abd10f6861ae..2f82d0e9ec1b 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -943,7 +943,7 @@ static int twl4030_bci_set_property(struct power_supply *psy,
 	return 0;
 }
 
-int twl4030_bci_property_is_writeable(struct power_supply *psy,
+static int twl4030_bci_property_is_writeable(struct power_supply *psy,
 				      enum power_supply_property psp)
 {
 	switch (psp) {
-- 
2.11.0
