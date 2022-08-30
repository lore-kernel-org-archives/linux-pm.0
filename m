Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9272ECAAA1
	for <linux-pm@archiver.kernel.org>; Tue, 30 Aug 2022 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiH3RZn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiH3RZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 13:25:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4C1612A4;
        Tue, 30 Aug 2022 10:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C9C61798;
        Tue, 30 Aug 2022 17:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D467C43140;
        Tue, 30 Aug 2022 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661880161;
        bh=clkQyZKh5bH63+URz0rVRixmIuxpZVkeNeCIrGtcjM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+8FPJeb6zO8050kvyhlktdoVznUykcm4PEI2fpV5Ky2a7wt/Zm+q7PzJtdnbsY7j
         0I/rfxW29W1HWFG8trS7+XYa0SWiU6yh2Oix7Ku8U2R3tLcKMyXl7OgRzJgCMaUVzI
         Iuz2tHDkBfWyX1VSwTewzTExPY1W0z0j7MvFpfFH86Jw9ps/ZRhBip2DbuTTru+vFb
         QXp3b0KlIyRwrX96tJ6rYZuEOWs105w1o1TdKo3y3vVWQ6oO6tXQvFHchzQRL/nro/
         7Z5YVm+AcCgKMKGYu1UtmVKpEsl5H96XfOnQMA0Lkin+tEBc1/yR3z8VSsKnEx2Pqc
         /ITU82X1HxKNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/23] cpufreq: check only freq_table in __resolve_freq()
Date:   Tue, 30 Aug 2022 13:21:33 -0400
Message-Id: <20220830172141.581086-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830172141.581086-1-sashal@kernel.org>
References: <20220830172141.581086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

[ Upstream commit 6ca7076fbfaeccce173aeab832d76b9e49e1034b ]

There is no need to check if the cpufreq driver implements callback
cpufreq_driver::target_index. The logic in the __resolve_freq uses
the frequency table available in the policy. It doesn't matter if the
driver provides 'target_index' or 'target' callback. It just has to
populate the 'policy->freq_table'.

Thus, check only frequency table during the frequency resolving call.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cddf7e13c2322..799431d287ee8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
-	if (!cpufreq_driver->target_index)
+	if (!policy->freq_table)
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
-- 
2.35.1

