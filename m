Return-Path: <SRS0=ZeAD=AL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF559C433E0
	for <linux-pm@archiver.kernel.org>; Tue, 30 Jun 2020 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C476020675
	for <linux-pm@archiver.kernel.org>; Tue, 30 Jun 2020 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbgF3Pf3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:35:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:56113 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389472AbgF3Pf3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jun 2020 11:35:29 -0400
IronPort-SDR: 9MUvMHsr+nQVQOOATKbmBJyddW8PFJ2VP7+1K9Vt7djZX8tOf0O3mLo+11OUGy9X+1Bqucd7hI
 bGUN2E8ZVtgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164275162"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="164275162"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 08:35:28 -0700
IronPort-SDR: G7tKrINYbzcvfvWHznr2coYdrUvsO33iueotv+iah3XwelwKpr0gtEss5dWDi5JDf83IkdA4I/
 VADAlDox4ueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="481231881"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2020 08:35:26 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael.j.wysocki@intel.com, srinivas.pandruvada@linux.intel.com,
        andriy.shevchenko@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: fan: fix: Update Tiger Lake ACPI device ID
Date:   Tue, 30 Jun 2020 21:11:49 +0530
Message-Id: <1593531709-21749-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tiger Lake's new unique ACPI device ID for Fan is not valid
because of missing 'C' in the ID. Fix this Fan ID by updating it.

Fixes: c248dfe7e0ca ("ACPI: fan: Add Tiger Lake ACPI device ID")
Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/fan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 873e039ad4b7..62873388b24f 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -25,8 +25,8 @@
 
 static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
-	{"INT1044", 0},
 	{"INT3404", 0},
+	{"INTC1044", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
-- 
1.7.9.5

