From: Milo Kim <milo.kim@ti.com>
Subject: [PATCH 2/2] power:lp8727_charger: parsing child node after getting debounce-ms
Date: Tue, 25 Aug 2015 15:07:08 +0900
Message-ID: <1440482828-7004-2-git-send-email-milo.kim@ti.com>
References: <1440482828-7004-1-git-send-email-milo.kim@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440482828-7004-1-git-send-email-milo.kim@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Milo Kim <milo.kim@ti.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

According to lp8727 bindings[*], charging parameter is optional.
So parsing can be skipped in case those properties are undefined.
However, 'debounce-ms' should be read prior to checking the properties.
Otherwise, 'debounce-ms' property will be ignored even it is configured
inside the DT.
So, counting child is processed after updating 'debounce-ms'.

[*] Documentation/devicetree/bindings/power_supply/lp8727_charger.txt

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Milo Kim <milo.kim@ti.com>
---
 drivers/power/lp8727_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/lp8727_charger.c b/drivers/power/lp8727_charger.c
index 30dc265..042fb3da 100644
--- a/drivers/power/lp8727_charger.c
+++ b/drivers/power/lp8727_charger.c
@@ -515,16 +515,16 @@ static struct lp8727_platform_data *lp8727_parse_dt(struct device *dev)
 	struct lp8727_platform_data *pdata;
 	const char *type;
 
-	/* If charging parameter is not defined, just skip parsing the dt */
-	if (of_get_child_count(np) == 0)
-		return NULL;
-
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
 	of_property_read_u32(np, "debounce-ms", &pdata->debounce_msec);
 
+	/* If charging parameter is not defined, just skip parsing the dt */
+	if (of_get_child_count(np) == 0)
+		return pdata;
+
 	for_each_child_of_node(np, child) {
 		of_property_read_string(child, "charger-type", &type);
 
-- 
1.9.1
