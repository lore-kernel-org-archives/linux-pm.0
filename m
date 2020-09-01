Return-Path: <SRS0=Ebod=CK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25387C433E2
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 03:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E379D2073A
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 03:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="eLCGrpr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIADIP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:08:15 -0400
Received: from mx1.riseup.net ([198.252.153.129]:33410 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgIADIP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Aug 2020 23:08:15 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BgX7z18dBzDscJ;
        Mon, 31 Aug 2020 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1598929695; bh=3GPF7Cw72U3yHpqxGlFHkg0kPLWIKtlZEbT6AbwqCGU=;
        h=From:To:Cc:Subject:Date:From;
        b=eLCGrpr6+LXztoyZqmgjzxkigiAJsfdGN8n1W3mxXJ+77SKLY3q1sme8DLbH1bVfd
         rBss4lkSTQ/c0TK47fat1baddKMplMJiQaolDBbsHvuWkUg29clnbD6Cl8SmU/6Ci1
         ghmpgOxW70kmPn1Wbdc+RUNqOprlCnVU9xHikL2c=
X-Riseup-User-ID: 48DFEEBA4ED917C81B8707E2D8F6791FD2D18DF7AF7E19EFB7B107AA66C59906
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BgX7y5nYvz8tRn;
        Mon, 31 Aug 2020 20:08:14 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Caleb Callaway <caleb.callaway@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for turbo disabled cases.
Date:   Mon, 31 Aug 2020 20:02:50 -0700
Message-Id: <20200901030250.495928-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This fixes the behavior of the scaling_max_freq and scaling_min_freq
sysfs files in systems which had turbo disabled by the BIOS.

Caleb noticed that the HWP is programmed to operate in the wrong
P-state range on his system when the CPUFREQ policy min/max frequency
is set via sysfs.  This seems to be because in his system
intel_pstate_get_hwp_max() is returning the maximum turbo P-state even
though turbo was disabled by the BIOS, which causes intel_pstate to
scale kHz frequencies incorrectly e.g. setting the maximum turbo
frequency whenever the maximum guaranteed frequency is requested via
sysfs.

Tested-by: Caleb Callaway <caleb.callaway@intel.com>
Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e0220a6fbc69..7eb7b62bd5c4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -825,7 +825,7 @@ static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
 
 	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
-	if (global.no_turbo)
+	if (global.no_turbo || global.turbo_disabled)
 		*current_max = HWP_GUARANTEED_PERF(cap);
 	else
 		*current_max = HWP_HIGHEST_PERF(cap);
-- 
2.28.0

