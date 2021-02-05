Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356E0C433E6
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85A064FB8
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 09:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBEJu6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:50:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12133 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhBEJrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 04:47:35 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX9Wr2YZ7z164x3;
        Fri,  5 Feb 2021 17:45:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:46:40 +0800
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
Subject: [PATCH 3/4] pps: Use subdir-ccflags-* to inherit debug flag
Date:   Fri, 5 Feb 2021 17:44:14 +0800
Message-ID: <1612518255-23052-4-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Use subdir-ccflags-* instead of ccflags-* to inherit the debug
settings from Kconfig when traversing subdirectories.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pps/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
index ceaf65c..7a2d3f7 100644
--- a/drivers/pps/Makefile
+++ b/drivers/pps/Makefile
@@ -8,4 +8,4 @@ pps_core-$(CONFIG_NTP_PPS)	+= kc.o
 obj-$(CONFIG_PPS)		:= pps_core.o
 obj-y				+= clients/ generators/
 
-ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
+subdir-ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
-- 
2.8.1

