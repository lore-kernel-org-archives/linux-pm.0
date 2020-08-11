Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A7C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0676420771
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 15:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgHKPb6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:31:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:25702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgHKPb6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 11:31:58 -0400
IronPort-SDR: ZFQMpcdBiQkuBl94MJigaYyCcLJQMizVoGNLR6Fu+mtZYllEI+NkmQbuUtZVoyyjdmGh+KeLls
 CHqrP84NsieQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="238588448"
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="238588448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 08:31:57 -0700
IronPort-SDR: cFl6xFoNFfmLjyOrkeDmJA3aU4Ve4ZWdglrb9z+CTxO6QbgaoXfqDAhFFTLQ8wgPUQ+6bRLeLm
 6nlBxb+zO2JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="439077176"
Received: from xzhao1-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.175.227])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2020 08:31:54 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Subject: [PATCH v2 1/3] perf/x86/rapl: Fix missing psys sysfs attributes
Date:   Tue, 11 Aug 2020 23:31:47 +0800
Message-Id: <20200811153149.12242-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811153149.12242-1-rui.zhang@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This fixes a problem introduced by
commit 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
that perf event sysfs attributes for psys RAPL domain are missing.

Fixes: 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 68b38820b10e..e9723833551f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -665,7 +665,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
 	&rapl_events_gpu_group,
-	&rapl_events_gpu_group,
+	&rapl_events_psys_group,
 	NULL,
 };
 
-- 
2.17.1

