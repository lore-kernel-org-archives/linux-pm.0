Return-Path: <SRS0=unav=Z3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC5C43603
	for <linux-pm@archiver.kernel.org>; Thu,  5 Dec 2019 11:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195A2245C
	for <linux-pm@archiver.kernel.org>; Thu,  5 Dec 2019 11:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfLELwH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:52:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:61483 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfLELwH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 06:52:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 03:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="294514230"
Received: from yuanwan1-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.174.225])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2019 03:52:05 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Subject: [PATCH] thermal: Add Daniel Lezcano as the thermal maintainer
Date:   Thu,  5 Dec 2019 19:51:50 +0800
Message-Id: <20191205115150.18836-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Daniel Lezcano as the co-maintainer of thermal subsystem.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8abdb50af79..0efadb61fe8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16287,7 +16287,7 @@ F:	drivers/media/radio/radio-raremono.c
 
 THERMAL
 M:	Zhang Rui <rui.zhang@intel.com>
-R:	Daniel Lezcano <daniel.lezcano@linaro.org>
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 R:	Amit Kucheria <amit.kucheria@verdurent.com>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
-- 
2.17.1

