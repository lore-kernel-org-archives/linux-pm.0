Return-Path: <SRS0=4xv0=2O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A86C2D0D5
	for <linux-pm@archiver.kernel.org>; Tue, 24 Dec 2019 02:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349F12073A
	for <linux-pm@archiver.kernel.org>; Tue, 24 Dec 2019 02:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLXCB1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:01:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbfLXCB1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 21:01:27 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6AEBA32927A4CDE31092;
        Tue, 24 Dec 2019 10:01:24 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Dec 2019 10:01:17 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] cpufreq: cppc: put the acpi table after successfully get it
Date:   Tue, 24 Dec 2019 09:56:30 +0800
Message-ID: <1577152590-25574-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1577152590-25574-1-git-send-email-guohanjun@huawei.com>
References: <1577152590-25574-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We need to put the ACPI table to release the table mapping
after we successfully get it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d0ca300..a06777c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -98,6 +98,8 @@ static void cppc_check_hisi_workaround(void)
 			break;
 		}
 	}
+
+	acpi_put_table(tbl);
 }
 
 /* Callback function used to retrieve the max frequency from DMI */
-- 
1.7.12.4

