Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD7C433B4
	for <linux-pm@archiver.kernel.org>; Wed, 31 Mar 2021 23:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C14D61057
	for <linux-pm@archiver.kernel.org>; Wed, 31 Mar 2021 23:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhCaX1O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:27:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhCaX0n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:43 -0400
IronPort-SDR: w5MCbd54sERppn6hTod8839NmdGgDpo+2pTPrTs5P/ySEmhq9B5CmBivU+0dl7C4Uvh9mV047C
 KoylDuzAmgNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528075"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528075"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:43 -0700
IronPort-SDR: xwOOwb0k9GZShlrNlTui8Sij0F6Vrg2dDW+fs8qHpcXkAPPQak7zEPawSN9Bz6kH1jDaewC58Y
 y5pW+hBM36+A==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685743"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:41 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM)
Subject: [PATCH 3/7] PM: runtime: remove kernel-doc warnings
Date:   Wed, 31 Mar 2021 18:26:10 -0500
Message-Id: <20210331232614.304591-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

remove make W=1 warnings

drivers/base/power/runtime.c:926: warning: Function parameter or
member 'timer' not described in 'pm_suspend_timer_fn'

drivers/base/power/runtime.c:926: warning: Excess function parameter
'data' description in 'pm_suspend_timer_fn'

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fe1dad68aee4..1fc1a992f90c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -951,7 +951,7 @@ static void pm_runtime_work(struct work_struct *work)
 
 /**
  * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
- * @data: Device pointer passed by pm_schedule_suspend().
+ * @timer: hrtimer used by pm_schedule_suspend().
  *
  * Check if the time is right and queue a suspend request.
  */
-- 
2.25.1

