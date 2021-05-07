Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3644FC433B4
	for <linux-pm@archiver.kernel.org>; Fri,  7 May 2021 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E5F61415
	for <linux-pm@archiver.kernel.org>; Fri,  7 May 2021 15:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhEGPIU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 7 May 2021 11:08:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:17710 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhEGPIT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 May 2021 11:08:19 -0400
IronPort-SDR: mDvmrMP6OggVDbgS04hLfYBevXhLwrXGrN4rYZRaX4iQAeCqCySt6fyLbNaMF9jepqWnWB2ONd
 UF/2GOUgqNTg==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198827641"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="198827641"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 08:07:19 -0700
IronPort-SDR: DECo38n+PAuQwl5yGAWJKfIzicsF5x4akE3NDfkHKRH91O21YTENUfoxN/34Rgfmfkcxj4xFvh
 UI6fXh83I0dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="540369080"
Received: from srpawnik-nuc8i7beh.iind.intel.com ([10.223.107.144])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2021 08:07:17 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Add battery participant for Intel SoCs
Date:   Fri,  7 May 2021 20:28:19 +0530
Message-Id: <20210507145819.22608-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add ACPI Device ID for DPTF battery participant for the Intel
Jasper Lake (INT3532) and Tiger Lake (INTC1050) SoC based platforms.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index d14025a85ce8..da5d5f0be2f2 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -24,6 +24,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
+	{"INT3532"},
 	{"INTC1040"},
 	{"INTC1041"},
 	{"INTC1043"},
@@ -33,6 +34,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1047"},
 	{"INTC1048"},
 	{"INTC1049"},
+	{"INTC1050"},
 	{"INTC1060"},
 	{"INTC1061"},
 	{""},
-- 
2.17.1

