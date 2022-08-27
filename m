Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59914ECAAD2
	for <linux-pm@archiver.kernel.org>; Sat, 27 Aug 2022 07:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbiH0HOj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 27 Aug 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiH0HOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Aug 2022 03:14:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3818BB01D;
        Sat, 27 Aug 2022 00:14:35 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF7BY29mxzYcmx;
        Sat, 27 Aug 2022 15:10:13 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 15:14:33 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/2] power: supply: adp5061: some fixes from device mockup test
Date:   Sat, 27 Aug 2022 07:32:22 +0000
Message-ID: <20220827073224.713803-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series fixes some issues found by device mockup unittest, not
sure how about the real device.

Wei Yongjun (2):
  power: supply: adp5061: fix out-of-bounds read in
    adp5061_get_chg_type()
  power: supply: adp5061: show unknown capacity_level as text

 drivers/power/supply/adp5061.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1

