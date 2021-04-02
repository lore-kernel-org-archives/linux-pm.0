Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9FEC433ED
	for <linux-pm@archiver.kernel.org>; Fri,  2 Apr 2021 06:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C304610E7
	for <linux-pm@archiver.kernel.org>; Fri,  2 Apr 2021 06:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBGOf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 2 Apr 2021 02:14:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16324 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBGOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 02:14:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBV895hj5z9vgd;
        Fri,  2 Apr 2021 14:12:25 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 14:14:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rjw@rjwysocki.net>, <ulf.hansson@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PM: runtime: Replace inline function pm_runtime_callbacks_present()
Date:   Fri, 2 Apr 2021 14:14:22 +0800
Message-ID: <20210402061422.3396-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit 9a7875461fd0 ("PM: runtime: Replace pm_runtime_callbacks_present()")
forget to change the inline version.

Fixes: 9a7875461fd0 ("PM: runtime: Replace pm_runtime_callbacks_present()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/pm_runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index b492ae00cc90..6c08a085367b 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -265,7 +265,7 @@ static inline void pm_runtime_no_callbacks(struct device *dev) {}
 static inline void pm_runtime_irq_safe(struct device *dev) {}
 static inline bool pm_runtime_is_irq_safe(struct device *dev) { return false; }
 
-static inline bool pm_runtime_callbacks_present(struct device *dev) { return false; }
+static inline bool pm_runtime_has_no_callbacks(struct device *dev) { return false; }
 static inline void pm_runtime_mark_last_busy(struct device *dev) {}
 static inline void __pm_runtime_use_autosuspend(struct device *dev,
 						bool use) {}
-- 
2.17.1

