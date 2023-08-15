Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69396C001DB
	for <linux-pm@archiver.kernel.org>; Tue, 15 Aug 2023 01:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjHOBka (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Aug 2023 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHOBk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 21:40:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608EEE7;
        Mon, 14 Aug 2023 18:40:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPv4y18s7ztRyh;
        Tue, 15 Aug 2023 09:36:50 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 09:40:25 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] cpufreq: Prefer to print cpuid in MIN/MAX QoS register error message
Date:   Tue, 15 Aug 2023 09:40:02 +0800
Message-ID: <20230815014002.4132226-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a cpufreq_policy is allocated, the cpus, related_cpus and real_cpus
of policy are still unset. Therefore, it is preferable to print the
passed 'cpu' parameter instead of a empty 'cpus' cpumask in error
message when registering MIN/MAX QoS notifier fails.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..a757f90aa9d6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1234,16 +1234,16 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
 				    &policy->nb_min);
 	if (ret) {
-		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
-			ret, cpumask_pr_args(policy->cpus));
+		dev_err(dev, "Failed to register MIN QoS notifier: %d (CPU%u)\n",
+			ret, cpu);
 		goto err_kobj_remove;
 	}
 
 	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MAX,
 				    &policy->nb_max);
 	if (ret) {
-		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
-			ret, cpumask_pr_args(policy->cpus));
+		dev_err(dev, "Failed to register MAX QoS notifier: %d (CPU%u)\n",
+			ret, cpu);
 		goto err_min_qos_notifier;
 	}
 
-- 
2.25.1

