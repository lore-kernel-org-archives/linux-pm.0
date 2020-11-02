Return-Path: <SRS0=ViTu=EI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB928C4741F
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 02:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC5221FC
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 02:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgKBCba (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 1 Nov 2020 21:31:30 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:29473 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgKBCba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 21:31:30 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.156])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 762C8482A58;
        Mon,  2 Nov 2020 10:31:27 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drivers/thermal: cleanup coding style a bit
Date:   Sun,  1 Nov 2020 18:31:21 -0800
Message-Id: <20201102023121.3312-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSB1ISE8eTUJLQxlNVkpNS09JQ09JQ0xNSU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6EAw5Kz8aGSFDLDJINjc0
        TU1PCTBVSlVKTUtPSUNPSUNDS0JCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5NWVdZCAFZQUpNQ043Bg++
X-HM-Tid: 0a7586cb8a5b93bakuws762c8482a58
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function thermal_add_hwmon_sysfs, hwmon will be NULL when
new_hwmon_device = 0, so there is no need to check, kfree will
handle NULL point.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/thermal/thermal_hwmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 8b92e00ff236..ad03262cca56 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -206,8 +206,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	if (new_hwmon_device)
 		hwmon_device_unregister(hwmon->device);
  free_mem:
-	if (new_hwmon_device)
-		kfree(hwmon);
+	kfree(hwmon);
 
 	return result;
 }
-- 
2.29.0

