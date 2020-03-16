Return-Path: <SRS0=xg7F=5B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9218FC3F2CE
	for <linux-pm@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7369C206E2
	for <linux-pm@archiver.kernel.org>; Mon, 16 Mar 2020 12:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgCPMzp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:55:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731059AbgCPMzo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 08:55:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D163E6274A3E00B1B0E7;
        Mon, 16 Mar 2020 20:55:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 20:55:34 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH V2 0/2] thermal: Add HiSilicon Kunpeng thermal driver and Maintainers
Date:   Mon, 16 Mar 2020 20:54:59 +0800
Message-ID: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
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
v2:
 * fix sizeof(* tdev) and sizeof(* tdev->tsensor)

Yang Shen (2):
  thermal: Add HiSilicon Kunpeng thermal driver
  MAINTAINERS: Add maintainers for kunpeng thermal

 MAINTAINERS                       |   7 ++
 drivers/thermal/Kconfig           |   8 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/kunpeng_thermal.c | 219 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 drivers/thermal/kunpeng_thermal.c

--
2.7.4

