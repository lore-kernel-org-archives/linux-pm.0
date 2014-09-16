From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH RESEND 2/2] power: max8925: Use of_get_child_by_name
Date: Tue, 16 Sep 2014 18:10:41 +0200
Message-ID: <1410883841-8276-2-git-send-email-k.kozlowski@samsung.com>
References: <1410883841-8276-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20479 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbaIPQKw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Sep 2014 12:10:52 -0400
In-reply-to: <1410883841-8276-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Use of_get_child_by_name to obtain reference to charger node instead of
of_find_node_by_name which can walk outside of the parent node.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max8925_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/max8925_power.c b/drivers/power/max8925_power.c
index 0cf237808d47..a6d45eef64dd 100644
--- a/drivers/power/max8925_power.c
+++ b/drivers/power/max8925_power.c
@@ -443,7 +443,7 @@ max8925_power_dt_init(struct platform_device *pdev)
 	if (!nproot)
 		return pdev->dev.platform_data;
 
-	np = of_find_node_by_name(nproot, "charger");
+	np = of_get_child_by_name(nproot, "charger");
 	if (!np) {
 		dev_err(&pdev->dev, "failed to find charger node\n");
 		return NULL;
-- 
1.9.1

