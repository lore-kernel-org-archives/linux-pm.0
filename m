From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.14.y 8/8] power: supply: charger-manager: Fix incorrect return value
Date: Fri, 22 Mar 2019 17:17:23 +0100
Message-ID: <20190322161727.1153278-9-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Fix incorrect return value.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
(cherry picked from commit f25a646fbe2051527ad9721853e892d13a99199e)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/charger-manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 6502fa7c2106..f60dfc213257 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct charger_manager *cm,
 	if (ret < 0) {
 		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
 			cable->extcon_name, cable->name);
-		ret = -EINVAL;
 	}
 
 	return ret;
@@ -1629,7 +1628,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);
-- 
2.20.0
