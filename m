From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 2/2] PM / devfreq: exynos-nocp: Remove redundant code to reset load_count/total_count
Date: Sun, 25 Sep 2016 20:13:58 +0800
Message-ID: <1474805638-30407-2-git-send-email-axel.lin@ingics.com>
References: <1474805638-30407-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33393 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966297AbcIYMOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2016 08:14:15 -0400
Received: by mail-pa0-f66.google.com with SMTP id oz2so7375304pac.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2016 05:14:14 -0700 (PDT)
In-Reply-To: <1474805638-30407-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

This is done by devfreq_event_get_event() so remove the redundant code in
exynos_nocp_get_event().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
v2: only add Chanwoo's Ack.
 drivers/devfreq/event/exynos-nocp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index a584140..49e712a 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -176,9 +176,6 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 	return 0;
 
 out:
-	edata->load_count = 0;
-	edata->total_count = 0;
-
 	dev_err(nocp->dev, "Failed to read the counter of NoC probe device\n");
 
 	return ret;
-- 
2.7.4

