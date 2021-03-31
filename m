Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AFAC43600
	for <linux-pm@archiver.kernel.org>; Wed, 31 Mar 2021 16:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6001E6101A
	for <linux-pm@archiver.kernel.org>; Wed, 31 Mar 2021 16:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhCaQec (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:34:32 -0400
Received: from foss.arm.com ([217.140.110.172]:46494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233747AbhCaQeW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 12:34:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D3411D4;
        Wed, 31 Mar 2021 09:34:21 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA5213F792;
        Wed, 31 Mar 2021 09:34:19 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH 1/2] thermal: power_allocator: maintain the device statistics from going stale
Date:   Wed, 31 Mar 2021 17:33:51 +0100
Message-Id: <20210331163352.32416-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331163352.32416-1-lukasz.luba@arm.com>
References: <20210331163352.32416-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the temperature is below the first activation trip point the cooling
devices are not checked, so they cannot maintain fresh statistics. It
leads into the situation, when temperature crosses first trip point, the
statistics are stale and show state for very long period. This has impact
on IPA algorithm calculation and wrong decisions. Thus, check the cooling
devices even when the temperature is low, to refresh these statistics.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2802a0e13c88..0cbd10cab193 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -575,15 +575,27 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	u32 req_power;
 
 	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+
 		if ((instance->trip != params->trip_max_desired_temperature) ||
 		    (!cdev_is_power_actor(instance->cdev)))
 			continue;
 
 		instance->target = 0;
 		mutex_lock(&instance->cdev->lock);
+		/*
+		 * Call for updating the cooling devices local stats and avoid
+		 * periods of dozen of seconds when those have not been
+		 * maintained. The long period would come into the first check
+		 * when lower threshold is crossed. Thus, limit it to single
+		 * one longer polling period.
+		 */
+		cdev->ops->get_requested_power(cdev, &req_power);
+
 		instance->cdev->updated = false;
 		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
-- 
2.17.1

