Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52847C4338F
	for <linux-pm@archiver.kernel.org>; Mon,  9 Aug 2021 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3741760EFF
	for <linux-pm@archiver.kernel.org>; Mon,  9 Aug 2021 11:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhHILz4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:55:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:22491 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhHILzz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Aug 2021 07:55:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214661778"
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="214661778"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 04:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="670764901"
Received: from srpawnik.iind.intel.com ([10.223.107.57])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2021 04:55:32 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] drivers/thermal/intel: add TCC cooling support for AlderLake platform
Date:   Mon,  9 Aug 2021 17:26:35 +0530
Message-Id: <20210809115635.10100-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add tcc cooling support for the AlderLake platform.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 8ec10d55d421..cd80c7db4073 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -79,6 +79,8 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
 	{}
 };
 
-- 
2.17.1

