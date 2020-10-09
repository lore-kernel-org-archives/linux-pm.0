Return-Path: <SRS0=Nxon=DQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D080C433E7
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 03:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65DB2224A
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 03:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgJID3T (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Oct 2020 23:29:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:44241 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJID3S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 23:29:18 -0400
IronPort-SDR: aHCfDFZMHpVPbDeacdqyoa2jiH7IqLthMipOEaxh4y+d3q0g46VjzGsP8rb41Epb8JqIXNTxhN
 byEL1M1J99UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250132281"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="250132281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:29:18 -0700
IronPort-SDR: Sf53ALl94+IwaR67cbc0mSNm0XFAkt30+MfErZGKG32nAe/wjl6gi3dfADAmxfAdkvL0PwA5Wr
 6aMsR5tDFLew==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="528751366"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:29:16 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC][PATCH] cpufreq: intel_pstate: Delete intel_pstate sysfs if failed to register the driver
Date:   Fri,  9 Oct 2020 11:30:38 +0800
Message-Id: <20201009033038.23157-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a corner case that if the intel_pstate driver failed to be
registered(might be due to invalid MSR access) and with the acpi_cpufreq
loaded, the intel_pstate sysfs might still be created, which makes the
user confusing(turbostat for example):

grep . /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
acpi-cpufreq

grep . /sys/devices/system/cpu/intel_pstate/*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:0
/sys/devices/system/cpu/intel_pstate/min_perf_pct:0
grep: /sys/devices/system/cpu/intel_pstate/no_turbo: Resource temporarily unavailable
grep: /sys/devices/system/cpu/intel_pstate/num_pstates: Resource temporarily unavailable
/sys/devices/system/cpu/intel_pstate/status:off
grep: /sys/devices/system/cpu/intel_pstate/turbo_pct: Resource temporarily unavailable

The existing of intel_pstate sysfs does not mean that the intel_pstate driver
has been successfully loaded(for example, echo off to status), but the
intel_pstate sysfs should not co-exist when acpi-cpufreq is also present.
Fix this issue by deleting the intel_pstate sysfs if the driver failed
to be loaded during bootup.

Reported-by: Wendy Wang <wendy.wang@intel.com>
Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9a515c460a00..8c5f9680de83 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1420,6 +1420,26 @@ static void __init intel_pstate_sysfs_expose_params(void)
 	}
 }
 
+static void __init intel_pstate_sysfs_clean(void)
+{
+	if (!intel_pstate_kobject)
+		return;
+
+	sysfs_remove_group(intel_pstate_kobject, &intel_pstate_attr_group);
+
+	if (per_cpu_limits)
+		goto release_kobj;
+
+	sysfs_remove_file(intel_pstate_kobject, &max_perf_pct.attr);
+	sysfs_remove_file(intel_pstate_kobject, &min_perf_pct.attr);
+
+	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids))
+		sysfs_remove_file(intel_pstate_kobject, &energy_efficiency.attr);
+
+release_kobj:
+	kobject_put(intel_pstate_kobject);
+}
+
 static void intel_pstate_sysfs_expose_hwp_dynamic_boost(void)
 {
 	int rc;
@@ -3063,8 +3083,10 @@ static int __init intel_pstate_init(void)
 	mutex_lock(&intel_pstate_driver_lock);
 	rc = intel_pstate_register_driver(default_driver);
 	mutex_unlock(&intel_pstate_driver_lock);
-	if (rc)
+	if (rc) {
+		intel_pstate_sysfs_clean();
 		return rc;
+	}
 
 	if (hwp_active) {
 		const struct x86_cpu_id *id;
-- 
2.17.1

