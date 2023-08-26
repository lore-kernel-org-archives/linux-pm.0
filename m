Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C03C83F11
	for <linux-pm@archiver.kernel.org>; Sat, 26 Aug 2023 01:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHZB0S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Aug 2023 21:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjHZB0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 21:26:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EEDE77;
        Fri, 25 Aug 2023 18:26:12 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXfFR2dxLzNnH1;
        Sat, 26 Aug 2023 09:22:35 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Sat, 26 Aug
 2023 09:26:10 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: governor: Free dbs_data directly when gov->init() fails
Date:   Sat, 26 Aug 2023 01:24:15 +0000
Message-ID: <20230826012415.1126955-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Due to the kobject embedded in the dbs_data doest not has a release()
method yet, it needs to use kfree() to free dbs_data directly when
governor fails to allocate the tunner field of dbs_data.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_governor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 85da677c43d6..6e1ac864e87e 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -438,8 +438,10 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
 
 	ret = gov->init(dbs_data);
-	if (ret)
+	if (ret) {
+		kfree(dbs_data);
 		goto free_policy_dbs_info;
+	}
 
 	/*
 	 * The sampling interval should not be less than the transition latency
-- 
2.34.1

