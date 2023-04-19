Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A0C77B73
	for <linux-pm@archiver.kernel.org>; Wed, 19 Apr 2023 14:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjDSOka (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 19 Apr 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjDSOkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 10:40:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B309D4498
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 07:40:11 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325079349"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325079349"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021232571"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="1021232571"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2023 07:39:49 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/7] intel_idle: use pr_info instead of printk
Date:   Wed, 19 Apr 2023 17:39:41 +0300
Message-Id: <20230419143947.1342730-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230419143947.1342730-1-dedekind1@gmail.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Substitute 'printk()' with 'pr_info()', because 'intel_idle' already uses
'pr_debug()', so using 'pr_info()' will be more consistent.

In addition to this, this patch addresses  the following checkpatch.pl
warning:
  WARNING: printk() should include KERN_<LEVEL> facility level

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 938c17f25d94..726a361da422 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1895,7 +1895,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
 		if ((cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
-			printk("intel_idle: forced intel_idle_irq for state %d\n", cstate);
+			pr_info("forced intel_idle_irq for state %d\n", cstate);
 			drv->states[drv->state_count].enter = intel_idle_irq;
 		}
 
-- 
2.38.1

