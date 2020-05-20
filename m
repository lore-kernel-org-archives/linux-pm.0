Return-Path: <SRS0=Lfw4=7C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB55C433DF
	for <linux-pm@archiver.kernel.org>; Wed, 20 May 2020 11:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389A7207C4
	for <linux-pm@archiver.kernel.org>; Wed, 20 May 2020 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETL37 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 20 May 2020 07:29:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:33065 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETL37 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 07:29:59 -0400
IronPort-SDR: Tv+oiap8EimFtvKTfrqHsqt/7QEE8AOEVhv947PaFNjc3x78LFv9Nh/KLMeECn6E8RepYLWwlt
 sPHmcPsxLowA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 04:29:59 -0700
IronPort-SDR: 01NBMwqFV8OTmqOCteBCh16e5yCHeDTeT7iKrAJkcOynoejJMDsEoXlkUo0K0hfz/LdDHFdB0w
 FYQuTav0J2lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="268239004"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2020 04:29:56 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, srinivas.pandruvada@linux.intel.com,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: remove unused local MSR define
Date:   Wed, 20 May 2020 17:06:18 +0530
Message-Id: <1589974578-26791-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Pawnikar, Sumeet" <sumeet.r.pawnikar@intel.com>

Remove unused PLATFORM_POWER_LIMIT MSR local definition from file
intel_rapl_common.c. This was missed while splitting old RAPL code
intel_rapl.c file into two new files intel_rapl_msr.c and
intel_rapl_common.c as per the commit 3382388d7148
("intel_rapl: abstract RAPL common code"). Currently, this #define
entry is being used only in intel_rapl_msr.c file and local definition
present in this file.

Signed-off-by: Pawnikar, Sumeet <sumeet.r.pawnikar@intel.com>
---
 drivers/powercap/intel_rapl_common.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index eb328655bc01..5527a7c76309 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -26,9 +26,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
-/* Local defines */
-#define MSR_PLATFORM_POWER_LIMIT	0x0000065C
-
 /* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK      0xffffffff
 
-- 
1.7.9.5

