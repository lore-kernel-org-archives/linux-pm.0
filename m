Return-Path: <SRS0=fF9S=YY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C795FCA9ECF
	for <linux-pm@archiver.kernel.org>; Thu, 31 Oct 2019 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C342087E
	for <linux-pm@archiver.kernel.org>; Thu, 31 Oct 2019 13:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfJaNSQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:18:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:64576 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfJaNSQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:18:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 06:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="212456665"
Received: from sunjia-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.173.87])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2019 06:18:15 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/2] powercap/intel_rapl: add support for Cometlake desktop
Date:   Thu, 31 Oct 2019 21:18:12 +0800
Message-Id: <20191031131812.19427-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031131812.19427-1-rui.zhang@intel.com>
References: <20191031131812.19427-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add CometLake desktop support in intel_rapl driver

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index cc1e82d513a9..a67701ed93e8 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -979,6 +979,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(COMETLAKE_L, rapl_defaults_core),
+	INTEL_CPU_FAM6(COMETLAKE, rapl_defaults_core),
 
 	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
-- 
2.17.1

