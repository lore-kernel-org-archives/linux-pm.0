Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB7C49361
	for <linux-pm@archiver.kernel.org>; Thu, 17 Jun 2021 13:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFDD613A9
	for <linux-pm@archiver.kernel.org>; Thu, 17 Jun 2021 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhFQNwb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Jun 2021 09:52:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhFQNwb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 09:52:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltsPU-0007a3-GA; Thu, 17 Jun 2021 13:50:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] opp: remove redundant continue statement
Date:   Thu, 17 Jun 2021 14:50:20 +0100
Message-Id: <20210617135020.16415-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
remove it.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/opp/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9573facce53a..d298e38aaf7e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -197,10 +197,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		required_opp_tables[i] = _find_table_of_opp_np(required_np);
 		of_node_put(required_np);
 
-		if (IS_ERR(required_opp_tables[i])) {
+		if (IS_ERR(required_opp_tables[i]))
 			lazy = true;
-			continue;
-		}
 	}
 
 	/* Let's do the linking later on */
-- 
2.31.1

