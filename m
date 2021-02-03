Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E7C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6024364F6C
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 08:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhBCIvf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:51:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:32820 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhBCIve (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 03:51:34 -0500
IronPort-SDR: XCGp58A/5mbre23MW/tjD8NrhVQtcgpP4K8wIZzT5GDjkwZiA0uvM1ncMmUSidU+EtSMzkGd+P
 0iDzfLrH3weA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177501312"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="177501312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:50:52 -0800
IronPort-SDR: cEUiofSbB9VAT4J4Mq9U0O8CsCSINPvUfCYDm91QeRbFgX7iUwR4gowaK27UxdG5gAFRv2k3we
 nlaibvJyA0Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="433315023"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.173])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2021 00:50:49 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Add more CPUs support in turbostat
Date:   Wed,  3 Feb 2021 16:54:11 +0800
Message-Id: <cover.1612341978.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Alder Lake P and Ice Lake D are added in this patch set.

Chen Yu (2):
  tools/power turbostat: Support Alder Lake Mobile
  tools/power turbostat: Support Ice Lake D

 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

