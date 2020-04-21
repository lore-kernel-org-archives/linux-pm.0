Return-Path: <SRS0=7vFa=6F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B012C55182
	for <linux-pm@archiver.kernel.org>; Tue, 21 Apr 2020 07:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735442074B
	for <linux-pm@archiver.kernel.org>; Tue, 21 Apr 2020 07:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUHp7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:45:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgDUHp6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Apr 2020 03:45:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DA830786B4213C012945;
        Tue, 21 Apr 2020 15:45:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 15:45:47 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH V3 0/2] thermal:Add HiSilicon Kunpeng thermal driver and Maintainers
Date:   Tue, 21 Apr 2020 15:44:51 +0800
Message-ID: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add HiSilicon Kunpeng thermal driver and Maintainers.

Changelog:
v3:
 * remove tsensor devices enabled checking in probe function
 * fix some comments
v2:
 * fix sizeof(* tdev) and sizeof(* tdev->tsensor)

Yang Shen (2):
  MAINTAINERS: Add maintainers for kunpeng thermal
  thermal: Add HiSilicon Kunpeng thermal driver

 MAINTAINERS                       |   7 ++
 drivers/thermal/Kconfig           |   8 ++U
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/kunpeng_thermal.c | 216 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 drivers/thermal/kunpeng_thermal.c

--
2.7.4

