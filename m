Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830FC433EF
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 03:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357368AbiD0DK2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Apr 2022 23:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357356AbiD0DKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 23:10:21 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401363616B;
        Tue, 26 Apr 2022 20:07:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VBQb5qj_1651028815;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VBQb5qj_1651028815)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 11:06:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] tools/thermal: remove unneeded semicolon
Date:   Wed, 27 Apr 2022 11:06:19 +0800
Message-Id: <20220427030619.81556-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220427030619.81556-1-jiapeng.chong@linux.alibaba.com>
References: <20220427030619.81556-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warnings:

./tools/thermal/thermometer/thermometer.c:147:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
2.20.1.7.g153144c

