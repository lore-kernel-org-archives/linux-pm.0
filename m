Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F99C4332B
	for <linux-pm@archiver.kernel.org>; Sat, 13 Mar 2021 03:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45A864F8E
	for <linux-pm@archiver.kernel.org>; Sat, 13 Mar 2021 03:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhCMDde (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Mar 2021 22:33:34 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:36994 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMDde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 22:33:34 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 9CBB2400062;
        Sat, 13 Mar 2021 11:33:31 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] soc: ti: Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Sat, 13 Mar 2021 11:33:26 +0800
Message-Id: <1615606406-2384-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZThgdSRpJSEhMT0IZVkpNSk5NS01PSkpDQkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6Nio*IT8KOVFOLxIuLhpJ
        LSNPCy1VSlVKTUpOTUtNT0pJSUhDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSk1JQzcG
X-HM-Tid: 0a7829a5722bd991kuws9cbb2400062
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warning:
	WARNING:pm_sr_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/soc/ti/smartreflex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index 5376f3d..b3c7460
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -817,7 +817,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
+DEFINE_DEBUGFS_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 			omap_sr_autocomp_store, "%llu\n");
 
 static int omap_sr_probe(struct platform_device *pdev)
-- 
2.7.4

