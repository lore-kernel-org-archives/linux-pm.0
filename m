Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F358AC4332F
	for <linux-pm@archiver.kernel.org>; Wed,  6 Apr 2022 22:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiDFWKb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiDFWK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 18:10:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C9131D12DE;
        Wed,  6 Apr 2022 15:08:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1FF12FC;
        Wed,  6 Apr 2022 15:08:32 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38BB83F5A1;
        Wed,  6 Apr 2022 15:08:30 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        amit.kachhap@gmail.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v3 3/5] thermal: Add interface to cooling devices to handle governor change
Date:   Wed,  6 Apr 2022 23:08:07 +0100
Message-Id: <20220406220809.22555-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406220809.22555-1-lukasz.luba@arm.com>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interface to cooling devices to handle governor change, to better
setup internal needed structures or to cleanup them. This interface is
going to be used by thermal governor Intelligent Power Allocation (IPA).
which requires to setup monitoring mechanism in the cpufreq cooling
devices.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/thermal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c314893970b3..baaa84d989bd 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -87,6 +87,7 @@ struct thermal_cooling_device_ops {
 	int (*get_requested_power)(struct thermal_cooling_device *, u32 *);
 	int (*state2power)(struct thermal_cooling_device *, unsigned long, u32 *);
 	int (*power2state)(struct thermal_cooling_device *, u32, unsigned long *);
+	int (*change_governor)(struct thermal_cooling_device *cdev, bool set);
 };
 
 struct thermal_cooling_device {
-- 
2.17.1

