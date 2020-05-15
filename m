Return-Path: <SRS0=YTwn=65=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC20C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 07:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C552065C
	for <linux-pm@archiver.kernel.org>; Fri, 15 May 2020 07:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgEOHas (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 May 2020 03:30:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:58202 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgEOHar (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 May 2020 03:30:47 -0400
IronPort-SDR: OAzjJchaGOs1wF/kopAuYFw5EoYG+jnqKOZSVDE1pecrWSUwwbe8Ppj14zfIn7XdXWV7aEUhe4
 5skYV7oPTRlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 00:30:47 -0700
IronPort-SDR: 2FOSAGVEPkV7lI4UluhYtgPI5Gx5EKixzT6lObp8b9kfIWts32FV/k50GcUeFCmIhL6Vi7XJkM
 wN2ma1Lpb3dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="281134906"
Received: from yche104-mobl3.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.171.35])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2020 00:30:45 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] powercap/intel_rapl: add support for ElkhartLake
Date:   Fri, 15 May 2020 15:30:41 +0800
Message-Id: <20200515073041.2261-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Add intel_rapl support for ElkhartLake platform.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index eb328655bc01..c3e335e37c7d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -989,6 +989,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
 
-- 
2.17.1

