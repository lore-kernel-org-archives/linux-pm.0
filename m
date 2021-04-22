Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C1BC43460
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08256140F
	for <linux-pm@archiver.kernel.org>; Thu, 22 Apr 2021 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbhDVPh1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:37:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237938AbhDVPh0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 11:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CE613A1;
        Thu, 22 Apr 2021 08:36:51 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A705C3F73B;
        Thu, 22 Apr 2021 08:36:49 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH 3/3] thermal: power allocator: use __thermal_cdev_update()
Date:   Thu, 22 Apr 2021 16:36:24 +0100
Message-Id: <20210422153624.6074-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422153624.6074-1-lukasz.luba@arm.com>
References: <20210422153624.6074-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the new helper function and avoid unnecessery second lock/unlock,
which was present in old approach with thermal_cdev_update().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index a6cdb2e892da..13e375751d22 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -301,9 +301,8 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 
 	instance->target = clamp_val(state, instance->lower, instance->upper);
 	mutex_lock(&cdev->lock);
-	cdev->updated = false;
+	__thermal_cdev_update(cdev);
 	mutex_unlock(&cdev->lock);
-	thermal_cdev_update(cdev);
 
 	return 0;
 }
-- 
2.17.1

