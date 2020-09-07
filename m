Return-Path: <SRS0=fmUR=CQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD498C433E2
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 16:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963802078E
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497751;
	bh=dRhKoUthx2GXS1YIyhC1huELrdF/mVVRO3qG47TjWT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oQGDNj6shh9PoIgn5s24j5L6+MSASp78sgGyVALr2I6H1DKrc8CgNT65X/mip2/m+
	 z1AheEK916EWYA3rtwk7lf7Pt7DrtxUd6goifdc99lHXWF3tcqaaHn0BZ8HCaynOC5
	 05Cnjzt2aoH6xTVUUb9mjsOj9Hv54jF95p6ISs1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgIGQzT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730748AbgIGQeR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCCF21D90;
        Mon,  7 Sep 2020 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496455;
        bh=dRhKoUthx2GXS1YIyhC1huELrdF/mVVRO3qG47TjWT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KANUzJvCPIRoitjISW6/TdqF1RM18xxNJZIrm7lE1XAT5VHqic/E9Y+mGC5x+sNxY
         ynDLAa8SxPB0K4xSqE9NDYIpzTixeBjZrXOGDruaA9lXOAw65Gv9ZUmDe0Az0DFCef
         JxLasqJSQQYcTYS/AOu3ZgZqecsXlLfaF+9kINBo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Francisco Jerez <currojerez@riseup.net>,
        Caleb Callaway <caleb.callaway@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 36/43] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for turbo disabled
Date:   Mon,  7 Sep 2020 12:33:22 -0400
Message-Id: <20200907163329.1280888-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Francisco Jerez <currojerez@riseup.net>

[ Upstream commit eacc9c5a927e474c173a5d53dd7fb8e306511768 ]

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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[ rjw: Minor subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5bad88f6ddd59..b9ca89dc75c7d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -762,7 +762,7 @@ static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
 
 	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
-	if (global.no_turbo)
+	if (global.no_turbo || global.turbo_disabled)
 		*current_max = HWP_GUARANTEED_PERF(cap);
 	else
 		*current_max = HWP_HIGHEST_PERF(cap);
-- 
2.25.1

