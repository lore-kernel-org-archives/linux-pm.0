Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F560C25B6B
	for <linux-pm@archiver.kernel.org>; Wed, 25 Oct 2023 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjJYTVw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 25 Oct 2023 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYTVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 15:21:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55750181;
        Wed, 25 Oct 2023 12:21:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77EA1474;
        Wed, 25 Oct 2023 12:22:29 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E62753F738;
        Wed, 25 Oct 2023 12:21:46 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 5/7] thermal: gov_power_allocator: Use shorter variable when possible
Date:   Wed, 25 Oct 2023 20:22:23 +0100
Message-Id: <20231025192225.468228-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025192225.468228-1-lukasz.luba@arm.com>
References: <20231025192225.468228-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'cdev' pointer is initialed, so there is no need to use
'instance->cdev'.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 79621b42ead38..0f7f8278eacc5 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -560,7 +560,7 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 			continue;
 
 		instance->target = 0;
-		mutex_lock(&instance->cdev->lock);
+		mutex_lock(&cdev->lock);
 		/*
 		 * Call for updating the cooling devices local stats and avoid
 		 * periods of dozen of seconds when those have not been
@@ -569,9 +569,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 		cdev->ops->get_requested_power(cdev, &req_power);
 
 		if (update)
-			__thermal_cdev_update(instance->cdev);
+			__thermal_cdev_update(cdev);
 
-		mutex_unlock(&instance->cdev->lock);
+		mutex_unlock(&cdev->lock);
 	}
 }
 
-- 
2.25.1

