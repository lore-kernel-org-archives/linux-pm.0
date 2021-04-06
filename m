Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD4C433ED
	for <linux-pm@archiver.kernel.org>; Tue,  6 Apr 2021 07:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD67160FE7
	for <linux-pm@archiver.kernel.org>; Tue,  6 Apr 2021 07:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbhDFHBB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:01:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15552 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhDFHA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 03:00:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDyz03JJhzPnBY;
        Tue,  6 Apr 2021 14:58:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 15:00:41 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-pm@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Remove unused for_each_policy macro
Date:   Tue, 6 Apr 2021 15:00:59 +0800
Message-ID: <1617692459-35670-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

macro 'for_each_policy' has become unused since commit
f963735a3ca3 ("cpufreq: Create for_each_{in}active_policy()"),
Remove it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/cpufreq/cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1d1b563cea4b..802abc925b2a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -42,9 +42,6 @@ static LIST_HEAD(cpufreq_policy_list);
 #define for_each_inactive_policy(__policy)		\
 	for_each_suitable_policy(__policy, false)
 
-#define for_each_policy(__policy)			\
-	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
-
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)				\
-- 
2.7.4

