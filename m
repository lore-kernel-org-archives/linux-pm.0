Return-Path: <SRS0=fF9S=YY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9FCA9ECE
	for <linux-pm@archiver.kernel.org>; Thu, 31 Oct 2019 13:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEAC20873
	for <linux-pm@archiver.kernel.org>; Thu, 31 Oct 2019 13:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJaNOZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:14:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:63632 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfJaNOZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:14:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 06:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="206106606"
Received: from sunjia-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.173.87])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2019 06:14:22 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Add Cometlake support
Date:   Thu, 31 Oct 2019 21:14:22 +0800
Message-Id: <20191031131422.18887-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

From a turbostat point of view, Cometlake is like Kabylake.

Suggested-by: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5d0fddda842c..985e195f066b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4610,6 +4610,8 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
+	case INTEL_FAM6_COMETLAKE_L:
+	case INTEL_FAM6_COMETLAKE:
 		return INTEL_FAM6_SKYLAKE_L;
 
 	case INTEL_FAM6_ICELAKE_L:
-- 
2.17.1

