Return-Path: <SRS0=Prsx=SX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48860C10F14
	for <linux-pm@archiver.kernel.org>; Sun, 21 Apr 2019 08:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A8C2147C
	for <linux-pm@archiver.kernel.org>; Sun, 21 Apr 2019 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfDUIar (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:30:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:3221 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUIar (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Apr 2019 04:30:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Apr 2019 01:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,377,1549958400"; 
   d="scan'208";a="339367993"
Received: from jzha102-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.170.41])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2019 01:30:45 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] tools/power turbostat: add Jacobsville support
Date:   Sun, 21 Apr 2019 16:30:22 +0800
Message-Id: <1555835422-2868-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jacobsville behaves like Denverton.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be..29d6e9d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4595,6 +4595,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 
 	case INTEL_FAM6_ICELAKE_MOBILE:
 		return INTEL_FAM6_CANNONLAKE_MOBILE;
+
+	case INTEL_FAM6_ATOM_TREMONT_X:
+		return INTEL_FAM6_ATOM_GOLDMONT_X;
 	}
 	return model;
 }
-- 
2.7.4

