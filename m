Return-Path: <SRS0=Pn1r=UM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE9C31E45
	for <linux-pm@archiver.kernel.org>; Thu, 13 Jun 2019 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AF92133D
	for <linux-pm@archiver.kernel.org>; Thu, 13 Jun 2019 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560451077;
	bh=8mF4OgdcQJOXWHxpTOlqM/OAiNxFqn0FYkZbhjZW0hY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wkn+sSMUrMezECG1eawBHywVAGe9NigClxHDUGKBQLf7G+uJoD2aYbmEY64qUpVw0
	 IzCSXlKJkbtVch3Hkel0mTeSSFqO5P87cDzbwC5Co1ztTrro7O8Vk6wPshbK9U3nMN
	 gS/4xdWI0/CMyHUZTktE1M4ZnbASGiwNbrYsKWMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfFMSh4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfFMSh4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jun 2019 14:37:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B10D208CA;
        Thu, 13 Jun 2019 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560451075;
        bh=8mF4OgdcQJOXWHxpTOlqM/OAiNxFqn0FYkZbhjZW0hY=;
        h=Date:From:To:Cc:Subject:From;
        b=t4A9/Rt0/sSVo8qm0FU82P4c0PUl3LvdKgbvtBpiORzYxBW3O8fXsPdMUvPCgODx+
         hiBpcBlKGWSG8/AeTyvEBZCUPjreUiyHfcrOk4IkE/a9iUypjIKwy5fUf3vZ6Vgm+p
         ouyi3UfKFCE9tDoxjGgQW1CY2MCVZHHwxPJrG96s=
Date:   Thu, 13 Jun 2019 20:37:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wei Ni <wni@nvidia.com>, Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: tegra: no need to check return value of
 debugfs_create functions
Message-ID: <20190613183753.GB32085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Wei Ni <wni@nvidia.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/tegra/soctherm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index fcf70a3728b6..43941eb734eb 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1485,23 +1485,13 @@ DEFINE_SHOW_ATTRIBUTE(regs);
 static void soctherm_debug_init(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
-	struct dentry *root, *file;
+	struct dentry *root;
 
 	root = debugfs_create_dir("soctherm", NULL);
-	if (!root) {
-		dev_err(&pdev->dev, "failed to create debugfs directory\n");
-		return;
-	}
 
 	tegra->debugfs_dir = root;
 
-	file = debugfs_create_file("reg_contents", 0644, root,
-				   pdev, &regs_fops);
-	if (!file) {
-		dev_err(&pdev->dev, "failed to create debugfs file\n");
-		debugfs_remove_recursive(tegra->debugfs_dir);
-		tegra->debugfs_dir = NULL;
-	}
+	debugfs_create_file("reg_contents", 0644, root, pdev, &regs_fops);
 }
 #else
 static inline void soctherm_debug_init(struct platform_device *pdev) {}
-- 
2.22.0

