Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35472C64E8A
	for <linux-pm@archiver.kernel.org>; Mon, 30 Nov 2020 05:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D423320809
	for <linux-pm@archiver.kernel.org>; Mon, 30 Nov 2020 05:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgK3Fhb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 Nov 2020 00:37:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3Fhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 00:37:31 -0500
Received: from 220-133-187-190.hinet-ip.hinet.net ([220.133.187.190] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjbrh-0002xu-Kv; Mon, 30 Nov 2020 05:36:46 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        srinivas.pandruvada@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] thermal: core: Add indication for userspace usage
Date:   Mon, 30 Nov 2020 13:36:38 +0800
Message-Id: <20201130053640.54608-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are seeing thermal shutdown on Intel based mobile workstations, the
shutdown happens during the first trip handle in
thermal_zone_device_register():
kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down

However, we shouldn't do a thermal shutdown here, since
1) We may want to use a dedicated daemon, Intel's thermald in this case,
to handle thermal shutdown.

2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
ThermalZone. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
"... If this object it present under a device, the device’s driver
evaluates this object to determine the device’s critical cooling
temperature trip point. This value may then be used by the device’s
driver to program an internal device temperature sensor trip point."

So a "critical trip" here merely means we should take a more aggressive
cooling method.

So add an indication to let thermal core know it should leave thermal
device to userspace to handle.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 include/linux/thermal.h        | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc1c90b..6561e3767529 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1477,6 +1477,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 			goto unregister;
 	}
 
+	if (tz->tzp && tz->tzp->userspace)
+		thermal_zone_device_disable(tz);
+
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	mutex_unlock(&thermal_list_lock);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d07ea27e72a9..e8e8fac78fc8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -247,6 +247,8 @@ struct thermal_zone_params {
 	 */
 	bool no_hwmon;
 
+	bool userspace;
+
 	int num_tbps;	/* Number of tbp entries */
 	struct thermal_bind_params *tbp;
 
-- 
2.29.2

