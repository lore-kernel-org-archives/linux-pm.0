From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 12/12] power: reset: account for const type of of_device_id.data
Date: Tue,  2 Jan 2018 14:28:08 +0100
Message-ID: <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10905 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753529AbeABN4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 08:56:55 -0500
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: kernel-janitors@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This driver creates a const structure that it stores in the data
field of an of_device_id array.

Add const to the declaration of the location that receives a value
from the data field to ensure that the compiler will continue to check
that the value is not modified and remove the const-dropping cast on
the access to the data field.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/reset/at91-sama5d2_shdwc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -68,7 +68,7 @@ struct shdwc_config {
 };
 
 struct shdwc {
-	struct shdwc_config *cfg;
+	const struct shdwc_config *cfg;
 	void __iomem *at91_shdwc_base;
 };
 
@@ -260,7 +260,7 @@ static int __init at91_shdwc_probe(struc
 	}
 
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
-	at91_shdwc->cfg = (struct shdwc_config *)(match->data);
+	at91_shdwc->cfg = match->data;
 
 	sclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sclk))
