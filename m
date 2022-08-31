Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B21ECAAD1
	for <linux-pm@archiver.kernel.org>; Wed, 31 Aug 2022 15:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiHaPtT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiHaPtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2022 11:49:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6CDAC;
        Wed, 31 Aug 2022 08:49:13 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661960948twaldri9
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 23:49:06 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: G46xFj+wOV/n5f2V0sXg0WXxitei3nEZS1U5Wj6HXsPhwk296M1wlIYc8AV88
        bC8r7jGk88OWIbdHorhKSq3qXK6Zo3kuU7FVMabU8oJdy/BGPCv7GW9EwCIocpQhBtUpy1f
        VOnGChG4nF3AFYmr1GgRXGKHgthp/0bTQgxzplN7R0zALEsuLbTcbTNONZLVNR6hjq6tOpM
        Rsypfr5TAUek4RFadtLU58E8QUl9LJDTTcre48tGxUAOp22LVgeEZTpDbgLmSw0VWYet4jy
        86To/LMlNFmKvXc+ypIWLSjbVin6DtO69M/mfxWuzzT7oL4VLaE0AZuNhwab9ShmleQz+s2
        1bwie0t6WWzEd1bG9wDQ1HggIIpvlmdmrnjBrRrxYRPA/criBBjBl3cOx3US/U6kpvWAJzD
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] power: supply: tps65217: Fix comments typo
Date:   Wed, 31 Aug 2022 11:49:05 -0400
Message-Id: <20220831154905.1513-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Delete the unneeded word "the" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/power/supply/tps65217_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index ba33d1617e0b..a4bc9f2a10bc 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -50,7 +50,7 @@ static int tps65217_config_charger(struct tps65217_charger *charger)
 	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
 	 *
 	 * The device can be configured to support a 100k NTC (B = 3960) by
-	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
+	 * setting the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
 	 * is not recommended to do so. In sleep mode, the charger continues
 	 * charging the battery, but all register values are reset to default
 	 * values. Therefore, the charger would get the wrong temperature
-- 
2.35.1

