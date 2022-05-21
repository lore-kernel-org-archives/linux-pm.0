Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B61C433F5
	for <linux-pm@archiver.kernel.org>; Sat, 21 May 2022 03:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiEUDLN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 20 May 2022 23:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiEUDLB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 23:11:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5EB1583B;
        Fri, 20 May 2022 20:10:59 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4pVz44DVzhYx0;
        Sat, 21 May 2022 11:10:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 11:10:57 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <Pierre.Gondois@arm.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] cpufreq: CPPC: Fix build error without CONFIG_ACPI_CPPC_CPUFREQ_FIE
Date:   Sat, 21 May 2022 11:24:38 +0800
Message-ID: <20220521032438.2504155-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If CONFIG_ACPI_CPPC_CPUFREQ_FIE is not set, building fails:

drivers/cpufreq/cppc_cpufreq.c: In function ‘populate_efficiency_class’:
drivers/cpufreq/cppc_cpufreq.c:584:2: error: ‘cppc_cpufreq_driver’ undeclared (first use in this function); did you mean ‘cpufreq_driver’?
  cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
  ^~~~~~~~~~~~~~~~~~~
  cpufreq_driver

Make declare of cppc_cpufreq_driver out of CONFIG_ACPI_CPPC_CPUFREQ_FIE
to fix this.

Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3eaa23d1aaf5..1837f2ce8243 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -61,6 +61,8 @@ static struct cppc_workaround_oem_info wa_info[] = {
 	}
 };

+static struct cpufreq_driver cppc_cpufreq_driver;
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE

 /* Frequency invariance support */
@@ -75,7 +77,6 @@ struct cppc_freq_invariance {
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;

-static struct cpufreq_driver cppc_cpufreq_driver;
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
 static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
--
2.31.1

