Return-Path: <SRS0=6wxd=CL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C46C433E2
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F5208CA
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599067482;
	bh=4GhpqVhomlHq3S1HIM4iXts6y7OCYOqvF5xPqDyrGq8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2oOyKKBpQxnN9VWuZA4eVTnMlYL4bhvw4MsI6DzgglgS7Pp4TzkYh35tweQ51oFom
	 PQkAklW8rDo3aaLm1KEWeuPZiGF2H+O6fk0dYp0IeRk4jxb7G/1mv/XOWDFAlKafE5
	 +vN9Cz0MhOZcOHJg7VmgWGxu7r1JaKXaYjkCrARg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIBRYl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgIBRYk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 13:24:40 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E164F20684;
        Wed,  2 Sep 2020 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599067480;
        bh=4GhpqVhomlHq3S1HIM4iXts6y7OCYOqvF5xPqDyrGq8=;
        h=From:To:Cc:Subject:Date:From;
        b=Fh7V5yGzM6ENw0BoXJdPecdir2Fi2ixx6uLGszMiGaQk4ZdMsLP03zI5wrz0HCt7+
         Xlc8HV4gaubACo0wZyABrpHN3338+TonZJGfXNL7yeWMA1PT2HEUv7CcWvgpnoa1Gn
         Ytc/4kChDtdAo061LnxvqEqHHUBHjlmxZ8YO77sY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] interconnect: core: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 19:24:32 +0200
Message-Id: <20200902172433.1138-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index befd111049c0..3d5d719de175 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -444,18 +444,14 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 	src_node = of_icc_get_from_provider(&src_args);
 
 	if (IS_ERR(src_node)) {
-		if (PTR_ERR(src_node) != -EPROBE_DEFER)
-			dev_err(dev, "error finding src node: %ld\n",
-				PTR_ERR(src_node));
+		dev_err_probe(dev, PTR_ERR(src_node), "error finding src node\n");
 		return ERR_CAST(src_node);
 	}
 
 	dst_node = of_icc_get_from_provider(&dst_args);
 
 	if (IS_ERR(dst_node)) {
-		if (PTR_ERR(dst_node) != -EPROBE_DEFER)
-			dev_err(dev, "error finding dst node: %ld\n",
-				PTR_ERR(dst_node));
+		dev_err_probe(dev, PTR_ERR(dst_node), "error finding dst node\n");
 		return ERR_CAST(dst_node);
 	}
 
-- 
2.17.1

