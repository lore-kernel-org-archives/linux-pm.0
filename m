Return-Path: <SRS0=Ia5J=CR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE52C43461
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 20:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D091720936
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599596057;
	bh=H5IQY9Nls454P7CTQaw3C3R6LUfM6Oc9TYn06wRJ0Lk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ss49i6+1BPk8qd7o0UPJSz33rUgniUCd4S7gJNWvLdNok1jLp/ic5tVwG/Bhkg+k9
	 rnvXKA6KWXZ8kYow/udKTJlWmAgPx3rA1QY6FU3veGHdwc58Av4iOrd+7l+GdwLUfY
	 0r9xLsciI5sCcBlfh7h3YwsfsBFXXTEgDrNE6w9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgIHUNk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgIHUNc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 16:13:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D90C21D43;
        Tue,  8 Sep 2020 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596012;
        bh=H5IQY9Nls454P7CTQaw3C3R6LUfM6Oc9TYn06wRJ0Lk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XNkkWk4PFb+BBKBOZeVnGC030CV8O+55J/wM0/RiG/Rbm1Vwk8l5o/jb8z3yX8NBS
         YS0Pj5VeYCQz9rCh1O2AbWB0YgORzzkiULix3bVsED6yhRGj1ZsFaQssw/w/JNYkZf
         5r3ak2dma0Vf2huLHdgv0NHMZe1DGKqOOFE3Gie0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] power: supply: bq27xxx: use BIT() for bit flags
Date:   Tue,  8 Sep 2020 22:13:16 +0200
Message-Id: <20200908201319.3567-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908201319.3567-1-krzk@kernel.org>
References: <20200908201319.3567-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BIT() is a preferred way to toggle bit-like flags: no problems with 32/64
bit systems, less chances for mistakes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2deac3fbb036..e971af43dd45 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -847,13 +847,14 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 
 #define bq27z561_dm_regs 0
 #define bq28z610_dm_regs 0
-
-#define BQ27XXX_O_ZERO	0x00000001
-#define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
-#define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
-#define BQ27XXX_O_CFGUP	0x00000008
-#define BQ27XXX_O_RAM	0x00000010
-#define BQ27Z561_O_BITS	0x00000020
+#define bq34z100_dm_regs 0
+
+#define BQ27XXX_O_ZERO		BIT(0)
+#define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
+#define BQ27XXX_O_UTOT		BIT(2) /* has OT overtemperature flag */
+#define BQ27XXX_O_CFGUP		BIT(3)
+#define BQ27XXX_O_RAM		BIT(4)
+#define BQ27Z561_O_BITS		BIT(5)
 
 #define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
-- 
2.17.1

