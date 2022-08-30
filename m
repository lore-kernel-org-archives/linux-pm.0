Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3762ECAAA1
	for <linux-pm@archiver.kernel.org>; Tue, 30 Aug 2022 08:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiH3IKx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 30 Aug 2022 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH3IKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 04:10:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03D7392A;
        Tue, 30 Aug 2022 01:10:51 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MH0M22wxWzHnYD;
        Tue, 30 Aug 2022 16:09:02 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 16:10:48 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <mmayer@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <chris.zjh@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] cpufreq: bmips-cpufreq: Use module_init and add module_exit
Date:   Tue, 30 Aug 2022 16:07:32 +0800
Message-ID: <20220830080732.3600988-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- Use module_init instead of device_initcall.
- Add a function for module_exit to unregister driver.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
v2:
- add semicolon after module_exit to keep the format consistent
---
 drivers/cpufreq/bmips-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
index f7c23fa468f0..39221a9a187a 100644
--- a/drivers/cpufreq/bmips-cpufreq.c
+++ b/drivers/cpufreq/bmips-cpufreq.c
@@ -156,7 +156,7 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
 	.name		= BMIPS_CPUFREQ_PREFIX,
 };
 
-static int __init bmips_cpufreq_probe(void)
+static int __init bmips_cpufreq_driver_init(void)
 {
 	struct cpufreq_compat *cc;
 	struct device_node *np;
@@ -176,7 +176,13 @@ static int __init bmips_cpufreq_probe(void)
 
 	return cpufreq_register_driver(&bmips_cpufreq_driver);
 }
-device_initcall(bmips_cpufreq_probe);
+module_init(bmips_cpufreq_driver_init);
+
+static void __exit bmips_cpufreq_driver_exit(void)
+{
+	cpufreq_unregister_driver(&bmips_cpufreq_driver);
+}
+module_exit(bmips_cpufreq_driver_exit);
 
 MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
 MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
-- 
2.31.0

