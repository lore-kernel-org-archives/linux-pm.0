Return-Path: <SRS0=/bOj=Y7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF78FC6194
	for <linux-pm@archiver.kernel.org>; Thu,  7 Nov 2019 02:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE5217F5
	for <linux-pm@archiver.kernel.org>; Thu,  7 Nov 2019 02:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfKGCxu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:53:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727924AbfKGCxu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Nov 2019 21:53:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 46DE7AD0528C8398758A;
        Thu,  7 Nov 2019 10:53:48 +0800 (CST)
Received: from HGHY2S004841851.china.huawei.com (10.184.217.114) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 7 Nov 2019 10:53:39 +0800
From:   Shen Kai <shenkai8@huawei.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>
CC:     <rafael@kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH]cpufreq: add NULL check to the store method of cpufreq
Date:   Thu, 7 Nov 2019 02:53:02 +0000
Message-ID: <1573095182-22008-1-git-send-email-shenkai8@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <20191107023442.q5xg6ltu2uzbjrp2@vireshk-i7>
References: <20191107023442.q5xg6ltu2uzbjrp2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.217.114]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kai Shen <shenkai8@huawei.com>

Add NULL check in the store function here to avoid NULL callback invoking.
Though some interfaces of cpufreq are set as read-only, user can still get 
write permission using chmod which can lead to a kernel crash.

The following operations can lead to a kernel crash.

chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

This bug was found on linux 4.19

Signed-off-by: Kai Shen <shenkai8@huawei.com>
Reported-by: Feilong Lin <linfeilong@huawei.com>
Reviewed-by: Feilong Lin <linfeilong@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bffc11b..4ccaa96 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -947,6 +947,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
+	if (!fattr->store)
+		return -EPERM;
+
 	/*
 	 * cpus_read_trylock() is used here to work around a circular lock
 	 * dependency problem with respect to the cpufreq_register_driver().
-- 
2.6.4.windows.1


