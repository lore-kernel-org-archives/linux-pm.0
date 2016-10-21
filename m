From: Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH 1/2] PM / devfreq: exynos-ppmu: ppmu_events array should not be NULL terminated
Date: Fri, 21 Oct 2016 09:09:08 +0800
Message-ID: <1477012149-9928-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32940 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbcJUBJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 21:09:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id i85so6969345pfa.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2016 18:09:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

The rest of the code uses ARRAY_SIZE to count the number of entries in
ppmu_events array. The NULL terminated entry makes ARRAY_SIZE return
off-by-one value.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
This patch was sent on https://patchwork.kernel.org/patch/9342637/
 drivers/devfreq/event/exynos-ppmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index f55cf0e..c9ffaf0 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -90,8 +90,6 @@ struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
-
-	{ /* sentinel */ },
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.7.4

