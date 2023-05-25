Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD54C7EE29
	for <linux-pm@archiver.kernel.org>; Thu, 25 May 2023 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjEYVRR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 May 2023 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjEYVRQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 17:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58112198;
        Thu, 25 May 2023 14:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE0464B2D;
        Thu, 25 May 2023 21:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084DCC433D2;
        Thu, 25 May 2023 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685049434;
        bh=+BQpgA/b2ao3wMNuPjBRBOPHdCtlI4INTxsSIyFtPTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsBOLATfz/A+zYQ4T2Ms2FFPQ1PDBD40nWF5l0+hpk5LXR5PL33HsALvmL/lJi2pO
         i3r55klIrE96/DKSwIEYyyNBQncZXBsm9Ho/aFd6gYoY9Ui+sNz8Iw2nUXMnvGFRtT
         Djb488i7WWHH2AnwtNA6Uh1/+IjxE3+hHUHMfkRugQ6Gn2wHG+6CnZIBSPm5Vg48/g
         zbOqhK+Xq5EM58bxyHQKv/KOnegaXl2+MrMJ+fVI8qbM/mJWmR42IrTeJz7sHDNPSh
         3YaJfTG0eqNbEORzg+krT5od6bYcm5BQGe2vEEQSjbZl5qpq/AJl5lAy3KhzZP85ha
         d5IHzB9XUspHg==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <eduval@amazon.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] thermal: core: introduce governor .reboot_prepare()
Date:   Thu, 25 May 2023 14:16:53 -0700
Message-Id: <20230525211655.627415-2-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525211655.627415-1-evalenti@kernel.org>
References: <20230525211655.627415-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

This callback is used to notify the governors that
reboot is coming up. Upon this event, this callback
gives governors the opportunity to leave the thermal
zones in a sane state prior to reboot.

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 include/linux/thermal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 82c8e09a63e0..d3c8af928522 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -201,6 +201,9 @@ struct thermal_zone_device {
  *		below the trip point temperature
  * @check_error:	callback called whenever temperature updates fail.
  *		Opportunity for the governor to react on errors.
+ * @reboot_prepare:	callback called upon system restart.
+ *		Opportunity for the governor to tear down zones or at least
+ *		leave them in a safe state.
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -209,6 +212,7 @@ struct thermal_governor {
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz, int trip);
 	void (*check_error)(struct thermal_zone_device *tz, int error);
+	void (*reboot_prepare)(struct thermal_zone_device *tz);
 	struct list_head	governor_list;
 };
 
-- 
2.34.1

