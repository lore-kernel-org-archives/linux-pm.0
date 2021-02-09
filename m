Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E781C43381
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA11264E79
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 11:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhBILN6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:13:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12900 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhBILLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:11:54 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DZgCX4gy3zjKGw;
        Tue,  9 Feb 2021 19:10:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 19:10:57 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <giometti@enneenne.com>, <abbotti@mev.co.uk>,
        <hsweeten@visionengravers.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kbuild@vger.kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>
CC:     <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
Date:   Tue, 9 Feb 2021 19:08:17 +0800
Message-ID: <1612868899-9185-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
References: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

We use ccflags-$(CONFIG_HWMON_DEBUG_CHIP) for the debug
message in drivers/hwmon, but the DEBUG flag will not pass to
the subdirectory.

Considering CONFIG_HWMON_DEBUG_CHIP intends to have DEBUG
recursively in driver/hwmon. It will be clearer
to use subdir-ccflags-* instead of ccflags-* to inherit
the debug settings from Kconfig when traversing subdirectories,
and it will avoid omittance of DEBUG define when debug messages
added in the subdirectories.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 09a86c5..1c0c089 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -201,5 +201,5 @@ obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
 obj-$(CONFIG_SENSORS_OCC)	+= occ/
 obj-$(CONFIG_PMBUS)		+= pmbus/
 
-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
+subdir-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
 
-- 
2.8.1

