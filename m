From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power_supply: charger-manager: Fix dereferencing of ERR_PTR
Date: Tue, 24 Mar 2015 08:58:43 +0100
Message-ID: <1427183923-7317-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:41212 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbbCXH6x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2015 03:58:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

If power_supply_register() fails do not dereference returned ERR_PTR.
The pointer was dereferenced to print name of battery which registration
failed. Instead use the name from the power supply description passed to
the power_supply_register() function.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 5933c1a585f4..0aed13f90891 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1772,7 +1772,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 						&psy_cfg);
 	if (IS_ERR(cm->charger_psy)) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
-			cm->charger_psy->desc->name);
+			cm->charger_psy_desc.name);
 		return PTR_ERR(cm->charger_psy);
 	}
 
-- 
1.9.1

