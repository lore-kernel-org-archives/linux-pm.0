Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F53C77B61
	for <linux-pm@archiver.kernel.org>; Tue, 25 Apr 2023 13:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjDYNL1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDYNL0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2023 09:11:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD515BB9D
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:11:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rIS0pfcRMLf5zrIS0p4TSz; Tue, 25 Apr 2023 15:11:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682428281;
        bh=WXiKOTUweT4dQBcURtN4IPuxsbpAL9eY85lFUMFtYlY=;
        h=From:To:Cc:Subject:Date;
        b=hbpLJFvCsemS0Uu45T4qTVqdi6a3ZqQQ+8kgeY1JgGuAqYlNDAdj6kEkBbXH2Sn1E
         CbPD7bQGrDkA8WZ8qXAHkNi5BxTR9wy167CR12PDQlv/IZICEwocqLw2dhHjwiYFBL
         wphRORSM/lG3G8wQ9Vn23Zxi8AOvB84be+HoU/Q2xfwZiBRmpsKiYMb3FMkFyrNp5I
         2QzSqucKwZgi+TWyd5J6f0cITlGWj5pCuOFgy3LWA98ADXpBw+xWoQtQwLpuiRdZQv
         o6xowQaW5SnjZJby0ENTYyye77DpXRGCR9VgZlvVVOnxNpJmrJWZiCO/sZkLCNhl+b
         C2lrLVzZ0Au+Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 15:11:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] cpufreq: tegra194: Fix an error handling path in tegra194_cpufreq_probe()
Date:   Tue, 25 Apr 2023 15:11:19 +0200
Message-Id: <30b17e2219abc3a9a137d28bb51e53732bba5103.1682428267.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the probe needs to be deferred, some resources still need to be
released. So branch to the error handling path instead of returning
directly.

Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/cpufreq/tegra194-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index c8d03346068a..36dad5ea5947 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -686,8 +686,10 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	/* Check for optional OPPv2 and interconnect paths on CPU0 to enable ICC scaling */
 	cpu_dev = get_cpu_device(0);
-	if (!cpu_dev)
-		return -EPROBE_DEFER;
+	if (!cpu_dev) {
+		err = -EPROBE_DEFER;
+		goto err_free_res;
+	}
 
 	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
 		err = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
-- 
2.34.1

