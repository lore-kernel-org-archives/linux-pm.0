Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7019C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FE52148D
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 06:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfDXG7q (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:59:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:30296 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfDXG7q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 02:59:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 23:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,388,1549958400"; 
   d="scan'208";a="318477391"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.161.125])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2019 23:59:45 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] PM: wakup: export wakeup irq when system aborts suspend
Date:   Wed, 24 Apr 2019 14:59:41 +0800
Message-Id: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When suspend is aborted because of an ARMED irq, we can not get any
useful information about which irq is triggered.

Export the wakeup irq via suspend_resume trace event in this case.

Signed-off-by: Brandt, Todd E <todd.e.brandt@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index bb1ae17..d32bd91 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -875,6 +875,7 @@ void pm_system_irq_wakeup(unsigned int irq_number)
 {
 	if (pm_wakeup_irq == 0) {
 		pm_wakeup_irq = irq_number;
+		trace_suspend_resume(TPS("irq_wakeup"), irq_number, true);
 		pm_system_wakeup();
 	}
 }
-- 
2.7.4

