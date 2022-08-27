Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C4C0502E
	for <linux-pm@archiver.kernel.org>; Sat, 27 Aug 2022 07:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbiH0HOj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 27 Aug 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiH0HOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Aug 2022 03:14:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B18DB8A6D;
        Sat, 27 Aug 2022 00:14:36 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF7Cl6z84zlWCT;
        Sat, 27 Aug 2022 15:11:15 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 15:14:34 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/2] power: supply: adp5061: show unknown capacity_level as text
Date:   Sat, 27 Aug 2022 07:32:24 +0000
Message-ID: <20220827073224.713803-3-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220827073224.713803-1-weiyongjun1@huawei.com>
References: <20220827073224.713803-1-weiyongjun1@huawei.com>
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

adp5061_get_battery_status() only defined show chg_status <= 4, others will
be show as '-1731902199' from /sys/class/power_supply/xx/capacity_level.
switch to show them as 'Unknown'.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/power/supply/adp5061.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index daee1161c305..fcf8ff0bc974 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -493,6 +493,9 @@ static int adp5061_get_battery_status(struct adp5061_state *st,
 	case 0x4: /* VBAT_SNS > VWEAK */
 		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 		break;
+	default:
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		break;
 	}
 
 	return ret;
-- 
2.34.1

