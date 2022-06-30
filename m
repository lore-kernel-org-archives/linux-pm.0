Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FAAC43334
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jun 2022 07:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiF3H7A (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiF3H6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 03:58:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842C41306;
        Thu, 30 Jun 2022 00:58:50 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6CE3C66017F5;
        Thu, 30 Jun 2022 08:58:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656575929;
        bh=7ycOl0tf4G0sSnkM0jeUXBwerp1p2XzwKGi4RzRqJcc=;
        h=From:To:Cc:Subject:Date:From;
        b=eUlcV6ImEVCpigysQR9fXFnu70De58qNsrrPtXqNOz0ykpk3Q2m+8aUHilk1fHLq3
         L1JRbkW3VeVQdGNX4CykiTBf7AYHLQGo15WHv2W6iAvZGETCfjjzyxklCLRx/m7vvG
         GFkbuEo0wifOz+A4NXr60gOPuJPgFOT7UpobDOc58iNG5oEJfEOGuEZnzSsKFXtUMN
         cHYN5YINR5HAbIti5MU2DRLvBn7wc7sYmeEQxha+mde8njJCeOoQtf+O5BveL8YZRv
         aACXGjxNSx2HbzvtFrP50dwBiApVzrxEc9QGtOy34zS02zi77ntAF2iTrnnT6oCgnm
         RW8rPGO1FKpww==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM / devfreq: tegra30: Add error message for devm_devfreq_add_device()
Date:   Thu, 30 Jun 2022 10:57:51 +0300
Message-Id: <20220630075751.1360786-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's difficult to notice that driver failed to probe by looking at KMSG
when devm_devfreq_add_device() fails. Add explicit error message for this
case.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 30382bdfc655..f0d414b881e3 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -926,8 +926,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	devfreq = devm_devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
 					  "tegra_actmon", NULL);
-	if (IS_ERR(devfreq))
+	if (IS_ERR(devfreq)) {
+		dev_err(&pdev->dev, "Failed to add device: %pe\n", devfreq);
 		return PTR_ERR(devfreq);
+	}
 
 	return 0;
 }
-- 
2.36.1

