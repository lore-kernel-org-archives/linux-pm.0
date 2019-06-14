Return-Path: <SRS0=avRG=UN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC18EC31E44
	for <linux-pm@archiver.kernel.org>; Fri, 14 Jun 2019 07:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1621473
	for <linux-pm@archiver.kernel.org>; Fri, 14 Jun 2019 07:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfFNHoi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:44:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:49698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNHoi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 03:44:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 00:44:37 -0700
X-ExtLoop1: 1
Received: from rajneesh-desk.iind.intel.com ([10.66.234.53])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2019 00:44:35 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael.j.wysocki@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 1/2] tools/power turbostat: Add Ice Lake NNPI support
Date:   Fri, 14 Jun 2019 13:09:46 +0530
Message-Id: <20190614073947.12270-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables turbostat utility on Ice Lake NNPI SoC.

Cc: Len Brown <lenb@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be9719f..d225cd373966 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4594,6 +4594,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_SKYLAKE_MOBILE;
 
 	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_NNPI:
 		return INTEL_FAM6_CANNONLAKE_MOBILE;
 	}
 	return model;
-- 
2.17.1

