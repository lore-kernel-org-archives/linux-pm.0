Return-Path: <SRS0=bP2c=AZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF21C433EA
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 07:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF0D22211
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 07:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGNHNV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:13:21 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44038 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbgGNHNU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 03:13:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1529282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0288318-0.000377861-0.97079;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.I1TiiMH_1594710791;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1TiiMH_1594710791)
          by smtp.aliyun-inc.com(10.147.41.158);
          Tue, 14 Jul 2020 15:13:15 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        mripard@kernel.org, wens@csie.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH v4 08/16] thermal: sun8i: add TEMP_CALIB_MASK for calibration data in sun50i_h6_ths_calibrate
Date:   Tue, 14 Jul 2020 15:13:04 +0800
Message-Id: <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594708863.git.frank@allwinnertech.com>
References: <cover.1594708863.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
calculation. On the other hand, the newer SOC may store other data in
the space other than 12bit sensor data. Add mask operation to read data
to avoid conversion error.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 74d73be16496..f423d44b9290 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -244,7 +244,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-		int sensor_reg = caldata[i + 1];
+		int sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
 		int cdata, offset;
 		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
 
-- 
2.24.0

