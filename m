Return-Path: <SRS0=qwVY=5Y=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A7C2BA16
	for <linux-pm@archiver.kernel.org>; Wed,  8 Apr 2020 04:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D2B2072A
	for <linux-pm@archiver.kernel.org>; Wed,  8 Apr 2020 04:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDHETj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:19:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:49178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHETj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 00:19:39 -0400
IronPort-SDR: ih0c5nG8TAkJil4C8DRH7YRGS7rfqk33MXe4Rvdm0R/CucJc5Eo1gzIPpQvhLICJdTd0BimDrx
 8I5AI/rcjycA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 21:19:39 -0700
IronPort-SDR: jyg34RvdK0nQjnvjjoNWcJ63L8z5/qTrAxVIFJpVq9K1CT7BDEn7h4ILXpuO9rpjsSRnnDUayd
 2XHdp6z6/Ecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="451470419"
Received: from tliao1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.172.195])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 21:19:38 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, tiwai@suse.de,
        viresh.kumar@linaro.org
Subject: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling state changed
Date:   Wed,  8 Apr 2020 12:19:17 +0800
Message-Id: <20200408041917.2329-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408041917.2329-1-rui.zhang@intel.com>
References: <20200408041917.2329-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACPI processor cooling device supports 1 cooling state before cpufreq
driver probed, and 4 cooling states after cpufreq driver probed.
Thus update the statistics table when the cpufeq driver is
probed/unprobed.

This fixes an OOB issue when updating the statistics of the processor
cooling device.

Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 41feb88ee92d..179d1b50ee2b 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -142,6 +142,7 @@ void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
+		thermal_cdev_stats_update_max(pr->cdev);
 	}
 }
 
@@ -154,6 +155,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 
 		if (pr)
 			freq_qos_remove_request(&pr->thermal_req);
+		thermal_cdev_stats_update_max(pr->cdev);
 	}
 }
 #else				/* ! CONFIG_CPU_FREQ */
-- 
2.17.1

