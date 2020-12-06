Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CEBC4167B
	for <linux-pm@archiver.kernel.org>; Sun,  6 Dec 2020 12:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32A62313F
	for <linux-pm@archiver.kernel.org>; Sun,  6 Dec 2020 12:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgLFMPG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 6 Dec 2020 07:15:06 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:20958 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgLFMPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 07:15:06 -0500
Received: from localhost.localdomain ([93.22.38.146])
        by mwinf5d81 with ME
        id 10DM2400139BigV030DMGj; Sun, 06 Dec 2020 13:13:22 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Dec 2020 13:13:22 +0100
X-ME-IP: 93.22.38.146
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     georgi.djakov@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, weiyongjun1@huawei.com,
        krzk@kernel.org, leonard.crestez@nxp.com, liushixin2@huawei.com,
        abailon@baylibre.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] interconnect: imx: Remove a useless test
Date:   Sun,  6 Dec 2020 13:13:22 +0100
Message-Id: <20201206121322.29434-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'dn' can't be NULL here, it is tested just the line above.
Remove this useless test.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/interconnect/imx/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index e398ebf1dbba..c770951a909c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -96,7 +96,7 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 			return -ENODEV;
 		}
 		/* Allow scaling to be disabled on a per-node basis */
-		if (!dn || !of_device_is_available(dn)) {
+		if (!of_device_is_available(dn)) {
 			dev_warn(dev, "Missing property %s, skip scaling %s\n",
 				 adj->phandle_name, node->name);
 			of_node_put(dn);
-- 
2.27.0

