Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388EC433E6
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 11:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6092B64E7C
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 11:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBILOH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:14:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12883 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhBILLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:11:54 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZgC80hJcz7jJn;
        Tue,  9 Feb 2021 19:09:40 +0800 (CST)
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
Subject: [PATCH v2 1/4] driver core: Use subdir-ccflags-* to inherit debug flag
Date:   Tue, 9 Feb 2021 19:08:16 +0800
Message-ID: <1612868899-9185-2-git-send-email-yangyicong@hisilicon.com>
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

Currently we can turn on the debug message in the top directory
driver/base and subdirectory driver/base/power with kconfig
option CONFIG_DEBUG_DRIVER. But the DEBUG flags will not
pass to subdirectory drvier/base/firmware_loader which
the ccflags-$(CONFIG_DEBUG_DRIVER) is missing and there is
no kconfig option to turn on the debug message for it.

Use subdir-ccflags-* for the DEBUG flag in the top directory
will fix this. Considering CONFIG_DEBUG_DRIVER intends
to turn on the debug recursively, use subdir-cclags-* will
be clearer and avoid omittance of DEBUG define
in the subdirectory.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/base/Makefile       | 2 +-
 drivers/base/power/Makefile | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 5e7bf96..c6bdf19 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -27,5 +27,5 @@ obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 
 obj-y			+= test/
 
-ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
+subdir-ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 8fdd007..2990167 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -5,5 +5,3 @@ obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
-
-ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
-- 
2.8.1

