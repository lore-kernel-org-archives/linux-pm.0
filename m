Return-Path: <SRS0=WlPs=7D=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13DC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 21 May 2020 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB6B207D3
	for <linux-pm@archiver.kernel.org>; Thu, 21 May 2020 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEUJ3m (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 May 2020 05:29:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4833 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbgEUJ3m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 05:29:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD4FB29C2C7DB4CD3171;
        Thu, 21 May 2020 17:29:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 17:29:29 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <sre@kernel.org>
CC:     <john.garry@huawei.com>, <linux-pm@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] base:power:sysfs: Remove redundant attribute runtime_status in runtime_attrs
Date:   Thu, 21 May 2020 17:25:47 +0800
Message-ID: <1590053147-32207-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

The attribute runtime_status is already defined in power_attrs, and
it is not necessary to define it again in runtime_attrs, so remove it.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/base/power/sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 2b99fe1..3ef4adf 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -613,9 +613,6 @@ static const struct attribute_group pm_wakeup_attr_group = {
 };
 
 static struct attribute *runtime_attrs[] = {
-#ifndef CONFIG_PM_ADVANCED_DEBUG
-	&dev_attr_runtime_status.attr,
-#endif
 	&dev_attr_control.attr,
 	&dev_attr_runtime_suspended_time.attr,
 	&dev_attr_runtime_active_time.attr,
-- 
2.8.1

