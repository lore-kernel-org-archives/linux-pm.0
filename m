Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD30C433F5
	for <linux-pm@archiver.kernel.org>; Fri,  6 May 2022 01:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388154AbiEFBya (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 May 2022 21:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388195AbiEFByT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 21:54:19 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C25205CD;
        Thu,  5 May 2022 18:50:35 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 6 May
 2022 09:50:34 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 6 May
 2022 09:50:33 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/thermal: Remove unneeded semicolon
Date:   Fri, 6 May 2022 09:50:31 +0800
Message-ID: <1651801831-24944-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes coccicheck warning:

tools/thermal/thermometer/thermometer.c:147:3-4: Unneeded semicolon

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 tools/thermal/thermometer/thermometer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 914986f20a37..1a87a0a77f9f 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -144,7 +144,7 @@ static int configuration_init(const char *path, struct configuration *config)
 		if (!node) {
 			ERROR("Missing node name '%d'\n", i);
 			return -1;
-		};
+		}
 
 		if (!config_setting_lookup_string(node, "name", &name)) {
 			ERROR("Thermal zone name not found\n");
-- 
2.7.4

