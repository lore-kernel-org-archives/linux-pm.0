Return-Path: <SRS0=Pjfh=5C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CFC1975A
	for <linux-pm@archiver.kernel.org>; Tue, 17 Mar 2020 17:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D0520735
	for <linux-pm@archiver.kernel.org>; Tue, 17 Mar 2020 17:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQRlg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:41:36 -0400
Received: from v6.sk ([167.172.42.174]:51262 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgCQRlg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Mar 2020 13:41:36 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 621DF60EC2;
        Tue, 17 Mar 2020 17:41:34 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        kongxinwei <kong.kongxinwei@hisilicon.com>,
        Wangtao <kevin.wangtao@hisilicon.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] thermal: hisilicon: Don't enable by default
Date:   Tue, 17 Mar 2020 18:41:30 +0100
Message-Id: <20200317174130.23523-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Users are generally unlikely to have a HiSilicon thermal sensor.
Like most other thermal drivers, don't build it by default/

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/thermal/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 02c3aa322a4a6..2062f8ec272b6 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -233,7 +233,6 @@ config HISI_THERMAL
 	depends on ARCH_HISI || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
-	default y
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
-- 
2.25.1

