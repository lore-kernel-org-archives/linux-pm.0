Return-Path: <SRS0=wqoS=6S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B28C3A5A9
	for <linux-pm@archiver.kernel.org>; Mon,  4 May 2020 19:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9D2073E
	for <linux-pm@archiver.kernel.org>; Mon,  4 May 2020 19:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="C1WmJ9M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEDTrw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 May 2020 15:47:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:57761 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEDTru (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:50 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0h1cX3zx2;
        Mon,  4 May 2020 21:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621668; bh=02QjF35bIYLrUMp0+nBPGRRjewlZ8g3tIFyMHy0VycA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=C1WmJ9M8dwnGHOocsWJBm/Lq2+dKHLuDNHF08QE2Y2PdiuIIXUFM/YRgBjSdp3cS1
         zYfEZx9dOUAuuYyao+5QsueP12h+MNW8I+hYSqfDo8GgqhVJa6raqQnrPe9itr6iZ0
         aEq/iobyWZGprYrtlp1phmef/w/sEWLFDhu79moJbKc5MrJyp6LYwRbrQ6OYk0Aem0
         O1iSInXF5iJF1jr+9hmOQfJMLeYRzVvp68Wjnhx4huufQEBux61GzNBedn0E3AcK5/
         PJnQ5uRk2pFCnoY9P5UGzBaS3I19RZ68r9epk2xKfQVF2AjCZEzvAnZsC8bZAgzhVy
         gcD6tkQL33kfg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:48 +0200
Message-Id: <b1b1f23a5f524b5af9dcfe646fdd68bf44be294d.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 7/8] power: bq25890: support IBAT compensation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add configuration for compensation of IBAT measuring resistor in series
with the battery.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index cb57125ea988..80ff767b2422 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -83,6 +83,8 @@ struct bq25890_init_data {
 	u8 boostf;	/* boost frequency		*/
 	u8 ilim_en;	/* enable ILIM pin		*/
 	u8 treg;	/* thermal regulation threshold */
+	u8 rbatcomp;	/* IBAT sense resistor value    */
+	u8 vclamp;	/* IBAT compensation voltage limit */
 };
 
 struct bq25890_state {
@@ -258,6 +260,8 @@ enum bq25890_table_ids {
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
+	TBL_VBATCOMP,
+	TBL_RBATCOMP,
 
 	/* lookup tables */
 	TBL_TREG,
@@ -299,6 +303,8 @@ static const union {
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
+	[TBL_VBATCOMP] ={ .rt = {0,        224000, 32000} },	 /* uV */
+	[TBL_RBATCOMP] ={ .rt = {0,        140000, 20000} },	 /* uOhm */
 
 	/* lookup tables */
 	[TBL_TREG] =	{ .lt = {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
@@ -648,7 +654,9 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		{F_BOOSTI,	 bq->init_data.boosti},
 		{F_BOOSTF,	 bq->init_data.boostf},
 		{F_EN_ILIM,	 bq->init_data.ilim_en},
-		{F_TREG,	 bq->init_data.treg}
+		{F_TREG,	 bq->init_data.treg},
+		{F_BATCMP,	 bq->init_data.rbatcomp},
+		{F_VCLAMP,	 bq->init_data.vclamp},
 	};
 
 	ret = bq25890_chip_reset(bq);
@@ -859,11 +867,14 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 		{"ti,boost-max-current", false, TBL_BOOSTI, &init->boosti},
 
 		/* optional properties */
-		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg}
+		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
+		{"ti,ibatcomp-resistance", true, TBL_RBATCOMP, &init->rbatcomp},
+		{"ti,ibatcomp-clamp-voltage", true, TBL_VBATCOMP, &init->vclamp},
 	};
 
 	/* initialize data for optional properties */
 	init->treg = 3; /* 120 degrees Celsius */
+	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
 
 	for (i = 0; i < ARRAY_SIZE(props); i++) {
 		ret = device_property_read_u32(bq->dev, props[i].name,
-- 
2.20.1

