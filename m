Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FFAC433EF
	for <linux-pm@archiver.kernel.org>; Mon,  1 Nov 2021 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786D560F70
	for <linux-pm@archiver.kernel.org>; Mon,  1 Nov 2021 12:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhKAMw4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 1 Nov 2021 08:52:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:54909 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhKAMwz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Nov 2021 08:52:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="294462474"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="294462474"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 05:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="488641282"
Received: from unknown (HELO linux-youquan.bj.intel.com) ([10.238.155.175])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2021 05:50:20 -0700
From:   Youquan Song <youquan.song@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     youquan.song@intel.com
Subject: [PATCH] PM/QoS: resume latency 0 should be not latency allowed
Date:   Mon,  1 Nov 2021 19:36:58 +0800
Message-Id: <1635766618-24732-1-git-send-email-youquan.song@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ICX and more recent Intel CPU has C1 exit_latency equal 1 in intel_idle
driver, There are PM QoS interfaces: global /dev/cpu_dma_latency and 
per-device latency constraints. per-CPU set pm_qos_resume_latency_us
to limit single CPU entery into deepest C-state. 
When it is required to disable entry into even C1, we need to set "0"
 to /sys pm_qos_resume_latency_us, but "0" of pm_qos_resume_latency_us
is redefined to no constraint now. 

so this patch set "0" back to original meaning "no latency at all".

Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 drivers/base/power/sysfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a1474fb67db9..b4bd67e6f440 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -214,10 +214,8 @@ static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
 {
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
-	if (value == 0)
-		return sysfs_emit(buf, "n/a\n");
 	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
-		value = 0;
+		return sysfs_emit(buf, "no constraint\n");
 
 	return sysfs_emit(buf, "%d\n", value);
 }
@@ -237,10 +235,8 @@ static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
 		if (value < 0 || value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 			return -EINVAL;
 
-		if (value == 0)
-			value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	} else if (sysfs_streq(buf, "n/a")) {
-		value = 0;
+		value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	} else {
 		return -EINVAL;
 	}
-- 
2.27.0

