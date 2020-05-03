Return-Path: <SRS0=xEwV=6R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A53FC47256
	for <linux-pm@archiver.kernel.org>; Sun,  3 May 2020 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E32E20721
	for <linux-pm@archiver.kernel.org>; Sun,  3 May 2020 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgECTLL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 3 May 2020 15:11:11 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:33907 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728885AbgECTLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 15:11:11 -0400
Received: from localhost.localdomain ([93.22.151.175])
        by mwinf5d76 with ME
        id aKB62200S3nJVaM03KB7HH; Sun, 03 May 2020 21:11:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 May 2020 21:11:09 +0200
X-ME-IP: 93.22.151.175
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, edubezval@gmail.com, info@metux.net,
        tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] thermal: stm32: fix spelling mistake "acces" -> "access"
Date:   Sun,  3 May 2020 21:11:04 +0200
Message-Id: <20200503191104.153711-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a typo in Kconfig.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/st/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
index 3c3b695cc3e9..58ece381956b 100644
--- a/drivers/thermal/st/Kconfig
+++ b/drivers/thermal/st/Kconfig
@@ -23,5 +23,5 @@ config STM32_THERMAL
 	help
 	  Support for thermal framework on STMicroelectronics STM32 series of
 	  SoCs. This thermal driver allows to access to general thermal framework
-	  functionalities and to acces to SoC sensor functionalities. This
+	  functionalities and to access to SoC sensor functionalities. This
 	  configuration is fully dependent of MACH_STM32MP157.
-- 
2.25.1

