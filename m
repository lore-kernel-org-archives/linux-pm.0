Return-Path: <SRS0=t+QV=ZO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913EC432C0
	for <linux-pm@archiver.kernel.org>; Fri, 22 Nov 2019 06:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354392053B
	for <linux-pm@archiver.kernel.org>; Fri, 22 Nov 2019 06:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403563;
	bh=JNSklQNz9vqxyS3kmFKL2m9+pzdRIfV4JKVPzeen/oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2O4c+LJbyKF+Zxf1d/jbjxeekBfNDaY3+qwigw4gRTEbgyhT8EURtgYXeaxHt4UZ
	 rlh8h1nJgM1Tfb7giCvlePDlCEJY95I3N7S6Ift7jHy+U+0lo/TAMa/0XHpEWmy6Sk
	 PITKBGT+n4CYJK4J//ZqnHC5DGFjZDhUnl/ztuXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKVGTS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbfKVFz6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Nov 2019 00:55:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370D32068F;
        Fri, 22 Nov 2019 05:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402158;
        bh=JNSklQNz9vqxyS3kmFKL2m9+pzdRIfV4JKVPzeen/oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWMMR5pVhXNDSja98rITJwr+HGisDyRMo2xwbvCbIvfVA3r4NP/L9YLeAuKKds80M
         OJGTJaPfjKpedRTx8v6pFjtMcmh15ZCsj6Qn3kwGT0RTLk1Xy+WootaOJDiyNzH0GB
         pvlQBLZ6BJnziphik+ctaQy/q8ki901y30xUv09I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Meyer <thomas@m3y3r.de>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 012/127] PM / AVS: SmartReflex: NULL check before some freeing functions is not needed
Date:   Fri, 22 Nov 2019 00:53:50 -0500
Message-Id: <20191122055544.3299-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

[ Upstream commit 14d338a857f05f894ba3badd9e6d3039c68b8180 ]

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/avs/smartreflex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 974fd684bab2c..4b6fddc183948 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -994,8 +994,7 @@ static int omap_sr_remove(struct platform_device *pdev)
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
-	if (sr_info->dbg_dir)
-		debugfs_remove_recursive(sr_info->dbg_dir);
+	debugfs_remove_recursive(sr_info->dbg_dir);
 
 	pm_runtime_disable(&pdev->dev);
 	list_del(&sr_info->node);
-- 
2.20.1

