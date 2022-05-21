Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1BCC433F5
	for <linux-pm@archiver.kernel.org>; Sat, 21 May 2022 11:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbiEULNp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 21 May 2022 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbiEULMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2022 07:12:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745E2A270;
        Sat, 21 May 2022 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eIx3k1Qc5iDERKRG4DXwAn1kj0nW2MTGI8lby89/NC8=;
  b=DR4WEiTKTrwIgCu3/GDoAaPrXhhyujHIwSZMobhNRMRZknsS9iRb7NU4
   af2FATsX4ozf1VBuKLWwIW/lnhnSbzasWMKD3+GB2+k4vdD8xszJQ4rpt
   nF66cPz8Hwgsxm5Xo1OcOSp0F9l6g29Y5Fs8kR82+Mk8yYkW4/Bwp8SKm
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727920"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:56 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: lp8788: fix typo in comment
Date:   Sat, 21 May 2022 13:10:35 +0200
Message-Id: <20220521111145.81697-25-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/power/supply/lp8788-charger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 397e5a03b7d9..56c57529c228 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -376,7 +376,7 @@ static int lp8788_update_charger_params(struct platform_device *pdev,
 		return 0;
 	}
 
-	/* settting charging parameters */
+	/* setting charging parameters */
 	for (i = 0; i < pdata->num_chg_params; i++) {
 		param = pdata->chg_params + i;
 

