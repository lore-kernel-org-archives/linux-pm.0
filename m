Return-Path: <SRS0=HpL5=3C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B82C33CAE
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BA7222C3
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 20:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="gy5tCFd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMUDP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:03:15 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:64523 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMUDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 15:03:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EB1F53F858;
        Mon, 13 Jan 2020 21:03:11 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=gy5tCFd4;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hy1-aEYqDTEn; Mon, 13 Jan 2020 21:03:11 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8B5223F75E;
        Mon, 13 Jan 2020 21:03:10 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id 3F5145C5; Mon, 13 Jan 2020 21:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1578945789; bh=dzPHPJdArrjCgbSclNQ4HJU2AzCNI0tuD2yFvZLOYtY=;
        h=From:To:Cc:Subject:Date:From;
        b=gy5tCFd4ry+7rnM9/aUIUW8STsRfeL26sNaDIVM7lEvQrK/2gNlgjFlL76Bx+lr/m
         rLhc0s0l+JeNpbDkVFASWyHY6zddJDarX0MfWqXMaVS8r37fZbDhiP0ZjTXIvVr/aM
         c7uKWbVQaZUX1TgerqymWm3277f0XOcfkuKlT9LU=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH] power: avs: qcom-cpr: add a printout after the driver has been initialized
Date:   Mon, 13 Jan 2020 21:02:58 +0100
Message-Id: <20200113200258.18031-1-nks@flawful.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to easier inform the user that the driver has been initialized
successfully, add a printout after the driver has been initialized.

At the same time, remove a dev_dbg() that is now redundant.

Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/power/avs/qcom-cpr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 9192fb747653..b158a684d05c 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -1547,8 +1547,6 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 		goto unlock;
 	}
 
-	dev_dbg(drv->dev, "number of OPPs: %d\n", drv->num_corners);
-
 	drv->corners = devm_kcalloc(drv->dev, drv->num_corners,
 				    sizeof(*drv->corners),
 				    GFP_KERNEL);
@@ -1586,6 +1584,9 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 				   acc_desc->enable_mask,
 				   acc_desc->enable_mask);
 
+	dev_info(drv->dev, "driver initialized with %u OPPs\n",
+		 drv->num_corners);
+
 unlock:
 	mutex_unlock(&drv->lock);
 
-- 
2.24.1

