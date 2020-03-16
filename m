Return-Path: <SRS0=xg7F=5B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E7C0044D
	for <linux-pm@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E30205ED
	for <linux-pm@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgCPMzs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:55:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731056AbgCPMzs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 08:55:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4B46E81A8D2C35820C1;
        Mon, 16 Mar 2020 20:55:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 20:55:35 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH V2 2/2] MAINTAINERS: Add maintainers for kunpeng thermal
Date:   Mon, 16 Mar 2020 20:55:01 +0800
Message-ID: <1584363301-15858-3-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
References: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Yang Shen and Zhou Wang as maintainers for kunpeng thermal

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18c..b7d4af4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7602,6 +7602,13 @@ F:	drivers/crypto/hisilicon/sgl.c
 F:	drivers/crypto/hisilicon/zip/
 F:	Documentation/ABI/testing/debugfs-hisi-zip
 
+HISILICON KUNPENG TSENSOR DRIVER
+M:	Yang Shen <shenyang39@huawei.com>
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/kunpeng_thermal.c
+
 HMM - Heterogeneous Memory Management
 M:	Jérôme Glisse <jglisse@redhat.com>
 L:	linux-mm@kvack.org
-- 
2.7.4

