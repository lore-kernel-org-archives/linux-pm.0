Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67F0C00140
	for <linux-pm@archiver.kernel.org>; Mon, 15 Aug 2022 12:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbiHOMom (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiHOMom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2022 08:44:42 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A4DF12
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 05:44:41 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NZSQoHlfpPMmaNZSQoRFYh; Mon, 15 Aug 2022 14:44:39 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 14:44:39 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] OPP: Fix an un-initialized variable usage
Date:   Mon, 15 Aug 2022 14:44:37 +0200
Message-Id: <a21fb09a4f2fcdb08eeb43cf4fb525621b16d086.1660567465.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

smatch complains that 'ret' may be returned un-initialized.

Explicitly return 0 if we reach the end of the function (should
'opp_table->clk_count' be 0).

Fixes: 8174a3a613af ("OPP: Provide a simple implementation to configure multiple clocks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 77d1ba3a4154..e87567dbe99f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -873,7 +873,7 @@ int dev_pm_opp_config_clks_simple(struct device *dev,
 		}
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_config_clks_simple);
 
-- 
2.34.1

