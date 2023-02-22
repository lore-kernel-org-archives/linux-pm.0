Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EECC61DA4
	for <linux-pm@archiver.kernel.org>; Wed, 22 Feb 2023 06:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBVGpp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Feb 2023 01:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVGpo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2023 01:45:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B52FCC7;
        Tue, 21 Feb 2023 22:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677048343; x=1708584343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wuo0nIIgWAqQ8fcp0ROhiW2stx6q20Di4BWobm89vqI=;
  b=L+dn/F6kxHFoaWAS5oDrJjtxzO8K33iNcsuV1RWXKB5VY4QonoFk0b2S
   cY6Z306+s+y/PTsfFq8yQDsbYN/WDSy3l3sxGFf7GJYHFqPspZr68DtAF
   oFO+7CPv5ergbthpdV42GIP5jlGxurOyvB2NILlVmhLeQJifW06umVhr5
   1fjEffj/wb9FymT01afPmSBCPLF+EsIgNWpfEoiG+Vw7xwz/6hf8s2lae
   JfNUzZfa7Y8QywuCAIyq44z2B9R4InsJIcJdxxY+k5/liy+AoeJydt10u
   Pqnuf2qLxvw9cJMLbKX4boMJS+/bf1FwvROnUM3EmlEQnflvJjaaNFD6+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="419078505"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="419078505"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 22:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="760838132"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="760838132"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2023 22:45:37 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for Sapphire Rapids
Date:   Tue, 21 Feb 2023 22:45:26 -0800
Message-Id: <20230222064526.1971688-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While majority of server OS distributions are deployed with performance
governor as the default, some distributions like Ubuntu uses powersave
governor as the default.

While the powersave governor has much lower power, the performance is
lower than +25% for several workloads compared to performance governor.

One report is published by www.Phoronix.com showing difference of 37%.

The goal here is to keep mean performance delta of powersave governor
from performance governor around 10% to 12% by running wide variety
of server workloads. For some bursty workload, this delta can be still
large, as ramp up of frequency will still lag with powersave governor
irrespective of EPP setting. The performance governor always requests
maximum frequency.

Based on experiments, EPP of 0x00, 0x10, 0x20, the performance delta for
powersave governor is around 12%. But the EPP 0x20 has 18% lower average
power.

Also experimets are done by raising intel_pstate sysfs min_perf_pct as
high as 50%. This didn't bring in any additional improvements compared
to just changing EPP.

From the Alder Lake processor generation, intel_pstate driver has
capability to update EPP for the default balance_performance based
on the CPU model. Use the same method to update the default
balance_performance EPP for the Sapphire Rapids processor to 0x20.

Link: https://www.phoronix.com/review/centos-clear-spr/6
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fd73d6d2b808..32a4004d155d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3372,6 +3372,7 @@ static const struct x86_cpu_id intel_epp_balance_perf[] = {
 	 * AlderLake Mobile CPUs.
 	 */
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 102),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 32),
 	{}
 };
 
-- 
2.39.1

