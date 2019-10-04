Return-Path: <SRS0=lxUh=X5=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C413FC4360C
	for <linux-pm@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB75207FF
	for <linux-pm@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201679;
	bh=QJNtgzf3I7MaqgTwW24kwXRCqf/tm/P6Sh5Bo/9VnwA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhYQKEaCLM3Z3xJ3UzjneTCm6bOkwws0KT02a4/dz0//+A3pSZ7VBmfhpU61OkSAF
	 nd0nUlDsXK/15LgLDlzsl/ovQTbiw4CLJ0/nVJLWUD/1ArkhJR/kO5+Yn9sfagbKwz
	 bSdUj8QVAZk6PTFP4TNWol4pYu/Iaa9g9/IzXR3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbfJDPHy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPHw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 11:07:52 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693762133F;
        Fri,  4 Oct 2019 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201671;
        bh=QJNtgzf3I7MaqgTwW24kwXRCqf/tm/P6Sh5Bo/9VnwA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2UDp5dGGX/8FZNXAiEEBqoJAFgg5033UO0O6fs41817qSowaRVAFmPLAoNAzdNUfA
         kMA/TAU/YvtqPXUVIgec3b6V5kJLk80ctVeIpX8TdaF00KqX8iJkt5/+xsHnISBlRU
         nBhxCvmbyupeqamN5SvFZLpmyDrbtTJzKOJqLNak=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 3/3] power: supply: ab8500: Handle invalid IRQ from platform_get_irq_byname()
Date:   Fri,  4 Oct 2019 17:07:38 +0200
Message-Id: <20191004150738.6542-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004150738.6542-1-krzk@kernel.org>
References: <20191004150738.6542-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

platform_get_irq_byname() might return -errno which later would be
cast to an unsigned int and used in request_irq().

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as cc-stable as this was not reproduced and not tested.
---
 drivers/power/supply/ab8500_btemp.c   |  5 +++++
 drivers/power/supply/ab8500_charger.c |  5 +++++
 drivers/power/supply/ab8500_fg.c      | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index a167938e32f2..cfd8152bf8fc 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1082,6 +1082,11 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	/* Register interrupts */
 	for (i = 0; i < ARRAY_SIZE(ab8500_btemp_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
+		if (irq < 0) {
+			ret = irq;
+			goto free_irq;
+		}
+
 		ret = request_threaded_irq(irq, NULL, ab8500_btemp_irq[i].isr,
 			IRQF_SHARED | IRQF_NO_SUSPEND,
 			ab8500_btemp_irq[i].name, di);
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index e51d0e72beea..7ad23df6f75a 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3556,6 +3556,11 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	/* Register interrupts */
 	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
+		if (irq < 0) {
+			ret = irq;
+			goto free_irq;
+		}
+
 		ret = request_threaded_irq(irq, NULL, ab8500_charger_irq[i].isr,
 			IRQF_SHARED | IRQF_NO_SUSPEND,
 			ab8500_charger_irq[i].name, di);
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 7d879589adc2..01f3da103813 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3151,6 +3151,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* Register primary interrupt handlers */
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
+		if (irq < 0) {
+			ret = irq;
+			goto free_irq_th;
+		}
+
 		ret = request_irq(irq, ab8500_fg_irq_th[i].isr,
 				  IRQF_SHARED | IRQF_NO_SUSPEND,
 				  ab8500_fg_irq_th[i].name, di);
@@ -3166,6 +3171,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 	/* Register threaded interrupt handler */
 	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
+	if (irq < 0) {
+		ret = irq;
+		goto free_irq_th;
+	}
+
 	ret = request_threaded_irq(irq, NULL, ab8500_fg_irq_bh[0].isr,
 				IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 			ab8500_fg_irq_bh[0].name, di);
-- 
2.17.1

