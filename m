Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E900DECAAD8
	for <linux-pm@archiver.kernel.org>; Fri, 23 Sep 2022 14:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiIWOn2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiIWOnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 10:43:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F8140F03;
        Fri, 23 Sep 2022 07:43:21 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYvsS2wQGzMpPd;
        Fri, 23 Sep 2022 22:38:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 22:43:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 22:43:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] cpufreq: tegra194: change tegra239_cpufreq_soc to static
Date:   Fri, 23 Sep 2022 22:50:16 +0800
Message-ID: <20220923145016.109173-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tegra239_cpufreq_soc is only used in tegra194-cpufreq.c now, change it
to static.

Fixes: 676886010707 ("cpufreq: tegra194: Add support for Tegra239")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index cfc1b225f811..c2004cae3f02 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -161,7 +161,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.num_clusters = 3,
 };
 
-const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
+static const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
-- 
2.25.1

