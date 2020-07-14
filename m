Return-Path: <SRS0=bP2c=AZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BBEC433E2
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6E722516
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 14:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgGNOO3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:14:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbgGNOO3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 10:14:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 881A14886A9F576467E5;
        Tue, 14 Jul 2020 22:14:28 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 22:14:21 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH -next] cpuidle/pseries: Make symbol 'pseries_idle_driver' static
Date:   Tue, 14 Jul 2020 22:24:24 +0800
Message-ID: <20200714142424.66648-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sparse tool complains as follows:

drivers/cpuidle/cpuidle-pseries.c:25:23: warning:
 symbol 'pseries_idle_driver' was not declared. Should it be static?
 
'pseries_idle_driver' is not used outside of this file, so marks
it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 6513ef2af66a..3e058ad2bb51 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -22,7 +22,7 @@
 #include <asm/idle.h>
 #include <asm/plpar_wrappers.h>
 
-struct cpuidle_driver pseries_idle_driver = {
+static struct cpuidle_driver pseries_idle_driver = {
 	.name             = "pseries_idle",
 	.owner            = THIS_MODULE,
 };

