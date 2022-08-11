Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8491C3F6B0
	for <linux-pm@archiver.kernel.org>; Thu, 11 Aug 2022 17:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiHKRN5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiHKRNg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2022 13:13:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58AF99E13F;
        Thu, 11 Aug 2022 09:54:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4D44113E;
        Thu, 11 Aug 2022 09:54:49 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.15.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8AEE3F5A1;
        Thu, 11 Aug 2022 09:54:47 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: [PATCH] cpufreq: check only freq_table in __resolve_freq()
Date:   Thu, 11 Aug 2022 17:54:08 +0100
Message-Id: <20220811165408.23027-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The there is no need to check if the cpufreq driver implements callback
cpufreq_driver::target_index. The logic in the __resolve_freq uses
the frequency table available in the policy. It doesn't matter if the
driver provides 'target_index' or 'target' callback. It just has to
populate the 'policy->freq_table'.

Thus, check only frequency table during the frequency resolving call.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7820c4e74289..69b3d61852ac 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
-	if (!cpufreq_driver->target_index)
+	if (!policy->freq_table)
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
-- 
2.17.1

