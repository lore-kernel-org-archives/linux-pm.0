Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA37C433DB
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ED764E54
	for <linux-pm@archiver.kernel.org>; Tue,  9 Feb 2021 10:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBIKB4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:01:56 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44448 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230491AbhBIJ7u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 04:59:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOHsNhv_1612864725;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UOHsNhv_1612864725)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Feb 2021 17:59:01 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] power: supply: Use true and false for bool variable
Date:   Tue,  9 Feb 2021 17:58:43 +0800
Message-Id: <1612864723-57143-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warning:

./include/linux/power_supply.h:507:9-10: WARNING: return of 0/1 in
function 'power_supply_is_watt_property' with return type bool.

./include/linux/power_supply.h:479:9-10: WARNING: return of 0/1 in
function 'power_supply_is_amp_property' with return type bool.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 include/linux/power_supply.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 81a55e9..029e6e9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -476,12 +476,12 @@ static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CURRENT_BOOT:
-		return 1;
+		return true;
 	default:
 		break;
 	}
 
-	return 0;
+	return false;
 }
 
 static inline bool power_supply_is_watt_property(enum power_supply_property psp)
@@ -504,12 +504,12 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		return 1;
+		return true;
 	default:
 		break;
 	}
 
-	return 0;
+	return false;
 }
 
 #ifdef CONFIG_POWER_SUPPLY_HWMON
-- 
1.8.3.1

