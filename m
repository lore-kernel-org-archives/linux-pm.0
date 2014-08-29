From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] charger-manager: Remove casting the return value which is a
 void pointer
Date: Fri, 29 Aug 2014 12:45:27 +0900
Message-ID: <004d01cfc33b$ac6746d0$0535d470$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23539 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaH2Dpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 23:45:30 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NB100C3TUFSN380@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 29 Aug 2014 12:45:28 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Sebastian Reichel' <sre@kernel.org>
Cc: 'Dmitry Eremin-Solenikov' <dbaryshkov@gmail.com>, 'David Woodhouse' <dwmw2@infradead.org>, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/power/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 9e4dab46eefd..1b87702c1753 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1656,7 +1656,7 @@ static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node)
 		return of_cm_parse_desc(&pdev->dev);
-	return (struct charger_desc *)dev_get_platdata(&pdev->dev);
+	return dev_get_platdata(&pdev->dev);
 }
 
 static int charger_manager_probe(struct platform_device *pdev)
-- 
2.0.0


