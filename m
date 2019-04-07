Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B1C10F0E
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10EA213F2
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDGSNH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:13:07 -0400
Received: from muru.com ([72.249.23.125]:44690 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfDGSNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Apr 2019 14:13:07 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D2FF881BA;
        Sun,  7 Apr 2019 18:13:21 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4/7] power: supply: cpcap-battery: Fix coulomb counter calibration register use
Date:   Sun,  7 Apr 2019 11:12:51 -0700
Message-Id: <20190407181254.64537-5-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190407181254.64537-1-tony@atomide.com>
References: <20190407181254.64537-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The coulomb counter calibration is not CCO, it's CCM. And the CCM is
nine bits wide signed register, so let's use sign_extend32() for it.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -84,7 +84,7 @@ struct cpcap_battery_config {
 struct cpcap_coulomb_counter_data {
 	s32 sample;		/* 24 or 32 bits */
 	s32 accumulator;
-	s16 offset;		/* 10-bits */
+	s16 offset;		/* 9 bits */
 };
 
 enum cpcap_battery_state {
@@ -224,8 +224,6 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 	if (!divider)
 		return 0;
 
-	offset &= 0x7ff;		/* 10-bits, signed */
-
 	switch (ddata->vendor) {
 	case CPCAP_VENDOR_ST:
 		cc_lsb = 95374;		/* μAms per LSB */
@@ -318,12 +316,12 @@ cpcap_battery_read_accumulated(struct cpcap_battery_ddata *ddata,
 	ccd->accumulator = ((s16)buf[3]) << 16;
 	ccd->accumulator |= buf[2];
 
-	/* Offset value CPCAP_REG_CCO */
-	ccd->offset = buf[5];
-
-	/* Adjust offset based on mode value CPCAP_REG_CCM? */
-	if (buf[4] >= 0x200)
-		ccd->offset |= 0xfc00;
+	/*
+	 * Coulomb counter calibration offset is CPCAP_REG_CCM,
+	 * REG_CCO seems unused
+	 */
+	ccd->offset = buf[4];
+	ccd->offset = sign_extend32(ccd->offset, 9);
 
 	return cpcap_battery_cc_to_uah(ddata,
 				       ccd->sample,
-- 
2.21.0
