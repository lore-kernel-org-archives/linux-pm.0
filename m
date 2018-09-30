From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 08/14] power: supply: charger-manager: simplify generation of sysfs attribute group name
Date: Mon,  1 Oct 2018 00:03:43 +0200
Message-ID: <20180930220349.10515-9-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This is a simple cleanup and there should be no functional changes.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/charger-manager.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index faa1a67cf3d2..7ce0a4a2645c 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1369,8 +1369,7 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	struct charger_desc *desc = cm->desc;
 	struct charger_regulator *charger;
 	int chargers_externally_control = 1;
-	char buf[11];
-	char *str;
+	char *name;
 	int ret;
 	int i;
 
@@ -1378,19 +1377,15 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	for (i = 0; i < desc->num_charger_regulators; i++) {
 		charger = &desc->charger_regulators[i];
 
-		snprintf(buf, 10, "charger.%d", i);
-		str = devm_kzalloc(cm->dev,
-				strlen(buf) + 1, GFP_KERNEL);
-		if (!str)
+		name = devm_kasprintf(cm->dev, GFP_KERNEL, "charger.%d", i);
+		if (!name)
 			return -ENOMEM;
 
-		strcpy(str, buf);
-
 		charger->attrs[0] = &charger->attr_name.attr;
 		charger->attrs[1] = &charger->attr_state.attr;
 		charger->attrs[2] = &charger->attr_externally_control.attr;
 		charger->attrs[3] = NULL;
-		charger->attr_g.name = str;
+		charger->attr_g.name = name;
 		charger->attr_g.attrs = charger->attrs;
 
 		sysfs_attr_init(&charger->attr_name.attr);
-- 
2.19.0
