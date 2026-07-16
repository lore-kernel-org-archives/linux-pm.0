Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6438370AFD
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222292; cv=none; b=Phka/hf6aobvPQ8ZNDkFE4oQm/a9C5DzodJUKynCGELlE6Cj2qXW0zNZ8Qc1w2kwrG94dU6Lf7GQE6mZ5uYXpg+JhkBTBfxMODOdX10kcb7AgGMoUJDA88la9joV3ILnYpxf+9ndq9XtZbrKD7hk55WGYR/SofAJGhORqMypcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222292; c=relaxed/simple;
	bh=iLUDkY4SFCq9gFI8/CTxjIMroozhOs4ZSJ3zk3UDbiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9ko5lzOSnQEnbthpqCqRXe0joEYPDeOHTJX2GIEWbtYzojIavcXTdaeQpkyHmiVdhjgWUeSMyY93WeZg3KUEWeAWdGnXWX5wDYIFz9Lcrp0/Gt7S0SNVQHsGN7d0rArMmre7Q+WxFQRR0Qs12XjSEMLW9wTGqoHoslZLouccJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKhxfcIi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKhxfcIi"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so79497805ad.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784222281; x=1784827081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HFJ+p81BjdB00DrwvkVTq99s5PhB9C18F6cOkBhmFnM=;
        b=MKhxfcIiziecQpQwB92bvU386g2dfkXlqpklwEOykx7l1YqfG3aTLz+laVqPYFeZ8m
         7XJEsWW9sicDotJt233ebICFqux0iXVs3KyfCxm+kmfFHxbVcFPIKQ0MQdKXkadPorwX
         lVs4vX3kc8hNKJMsTxS0jroCki00738DNpXfwWvkht9NZLBWQzaLJi5O5Mzz4ekLJNjf
         tQAxaZQ3KyDIFMnOjzeEPYMarVkbZ/2cGwDzqwrhTXdjOG2VqCWWPLWPrAd9RmM49ILO
         ASVX3wH9nKDW8srYOLmu30QeJmThH9RUrbCBP6lzvG/hlLS6ZFytyiQDDb21ykEu55tT
         0WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222281; x=1784827081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFJ+p81BjdB00DrwvkVTq99s5PhB9C18F6cOkBhmFnM=;
        b=fJgCVV1lxCgDGUp9tZGD8oQV0jf5jAuwLp43Nbd/ALh4ikLgE+e3OoYHQ1m/EKXrfI
         sBz4sJF/5P07EYBXY0vsAhm6hLbHbdDWEdXzVvrp70z1EQ2DwZ63lacfE1PP/ebkHR9f
         +IaMrmFQKoeLpd42kJVwPmGv5lXmgy8KAPBpXwzbodqLX1Ug3ABjls1ItPQf/C3veXmk
         c3IRxZCrlM5Q6ji7iswQQ9E7ycovrcKglFRCirMky51OsUUsp6QBMjPrbgkP6hf7cGSh
         LAQXSMF9cRsRq4B2DsxD+1ntIGmAjtmIhgEU+b1Mk6bIUGRiLU5n8LpzGfr0O5mh0uTP
         y3zA==
X-Gm-Message-State: AOJu0Yx0R2Q86pAUo43D9UbdWiAmqFdogFnRRtffXd9PQT7wbNXNO8MZ
	cAZeRJmrijItZ3gC0AJQymHfMXDcdqum0W+ZibegfUX9IRFTw7ZTx+Ud
X-Gm-Gg: AfdE7cmCpqd5C4bydorwZeSvTHTy6zNqHT05ROOGjHm8cNL+3d+PMCZ9S0soPkP9dvv
	kNTrCFNsrIU3PyP96OFX7HuzzkYLS03qW9u4Pt08506U97Qzb5o9+JLgntdWOeB/hUoy4gcs9Ro
	IBKUQxtePU8qo1x9EERYDLptdxoDZ+K9W68SJlWmLm9DxqY7b+OULYfQiuAHNJLILMCf60x2nRt
	PxvxFdv9l/T++2XzvdHCI3X+mRvQAeN3dueVYTj8GBwWDdWfdQ5hyUORvFaexthGImW5IFQh7QP
	NbJTZybH/D7Hc0ZGLNcsFlnkJ2j7RG20gnrC2Hs1BRRolOUpUMBZTr59oMOWTSL2CrRg+7P9IJY
	1jXsTb1PICz0F+eA7shLORMmK6KfC+YZhBVW5kHddmLg0hKCpb0Qp6zoSfHGWwkVL8r495cjnPK
	sPpFS5x3QS8l//e5fISF5c8cJW2HUDO1r7lQ==
X-Received: by 2002:a17:903:19ec:b0:2c2:be43:39bc with SMTP id d9443c01a7336-2cf03cef84dmr84481775ad.22.1784222280297;
        Thu, 16 Jul 2026 10:18:00 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055de44sm22917255ad.51.2026.07.16.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:17:59 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-pm@vger.kernel.org (open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS),
	mfd@lists.linux.dev (open list:MULTIFUNCTION DEVICES (MFD)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 3/3] soc: mediatek: pwrap: add MT6589 PWARP and MT6320 PMIC support
Date: Fri, 17 Jul 2026 02:17:33 +0900
Message-ID: <20260716171733.300885-4-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716171733.300885-1-akkun11.open@gmail.com>
References: <20260716171733.300885-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for MediaTek MT6589 PWRAP and MT6320 PMIC which are used
together.

Since the PWRAP Bridge hardware on MT6589 is identical to the one on
MT8135, refactor the existing register definitions:
- Rename the MT8135-specific "PWRAP_MT8135_BRIDGE_" prefix to a generic
  "PWRAP_BRIDGE_" prefix to reflect that they are shared across SoCs.
- Add the full set of PWRAP Bridge registers to match the hardware
  specification, rather than defining only a subset of them.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 292 +++++++++++++++++++++------
 1 file changed, 235 insertions(+), 57 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 0bcd85826375..3a5b007d60f5 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -17,15 +17,31 @@
 #define PWRAP_POLL_DELAY_US	10
 #define PWRAP_POLL_TIMEOUT_US	10000
 
-#define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
-#define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
-#define PWRAP_MT8135_BRIDGE_INIT_DONE3		0x14
-#define PWRAP_MT8135_BRIDGE_WACS4_EN		0x24
-#define PWRAP_MT8135_BRIDGE_INIT_DONE4		0x28
-#define PWRAP_MT8135_BRIDGE_INT_EN		0x38
-#define PWRAP_MT8135_BRIDGE_TIMER_EN		0x48
-#define PWRAP_MT8135_BRIDGE_WDT_UNIT		0x50
-#define PWRAP_MT8135_BRIDGE_WDT_SRC_EN		0x54
+/* MT6589 and MT8135 specific PWARP Bridge registers */
+#define PWRAP_BRIDGE_IARB_INIT		0x0
+#define PWRAP_BRIDGE_IORD_ARB_EN	0x4
+#define PWRAP_BRIDGE_IARB_STA0		0x8
+#define PWRAP_BRIDGE_IARB_STA1		0xc
+#define PWRAP_BRIDGE_WACS3_EN		0x10
+#define PWRAP_BRIDGE_INIT_DONE3		0x14
+#define PWRAP_BRIDGE_WACS3_CMD		0x18
+#define PWRAP_BRIDGE_WACS3_RDATA	0x1c
+#define PWRAP_BRIDGE_WACS3_VLDCLR	0x20
+#define PWRAP_BRIDGE_WACS4_EN		0x24
+#define PWRAP_BRIDGE_INIT_DONE4		0x28
+#define PWRAP_BRIDGE_WACS4_CMD		0x2c
+#define PWRAP_BRIDGE_WACS4_RDATA	0x30
+#define PWRAP_BRIDGE_WACS4_VLDCLR	0x34
+#define PWRAP_BRIDGE_INT_EN		0x38
+#define PWRAP_BRIDGE_INT_FLG_RAW	0x3c
+#define PWRAP_BRIDGE_INT_FLG		0x40
+#define PWRAP_BRIDGE_INT_CLR		0x44
+#define PWRAP_BRIDGE_TIMER_EN		0x48
+#define PWRAP_BRIDGE_TIMER_STA		0x4c
+#define PWRAP_BRIDGE_WDT_UNIT		0x50
+#define PWRAP_BRIDGE_WDT_SRC_EN		0x54
+#define PWRAP_BRIDGE_WDT_FLG		0x58
+#define PWRAP_BRIDGE_DEBUG_INT_SEL	0x5c
 
 /* macro for wrapper status */
 #define PWRAP_GET_WACS_RDATA(x)		(((x) >> 0) & 0x0000ffff)
@@ -100,6 +116,24 @@ enum dew_regs {
 	PWRAP_DEW_CIPHER_MODE,
 	PWRAP_DEW_CIPHER_SWRST,
 
+	/* MT6320 only regs */
+	PWRAP_DEW_CIPHER_IV0,
+	PWRAP_DEW_CIPHER_IV1,
+	PWRAP_DEW_CIPHER_IV2,
+	PWRAP_DEW_CIPHER_IV3,
+	PWRAP_DEW_CIPHER_IV4,
+	PWRAP_DEW_CIPHER_IV5,
+
+	/* MT6320 and MT6397 only regs */
+	PWRAP_DEW_EVENT_OUT_EN,
+	PWRAP_DEW_EVENT_SRC_EN,
+	PWRAP_DEW_EVENT_SRC,
+	PWRAP_DEW_EVENT_FLAG,
+	PWRAP_DEW_MON_FLAG_SEL,
+	PWRAP_DEW_EVENT_TEST,
+	PWRAP_DEW_CIPHER_LOAD,
+	PWRAP_DEW_CIPHER_START,
+
 	/* MT6323 only regs */
 	PWRAP_DEW_CIPHER_EN,
 	PWRAP_DEW_RDDMY_NO,
@@ -142,16 +176,34 @@ enum dew_regs {
 	PWRAP_DEW_RG_WDATA_MASK,
 	PWRAP_DEW_RG_SPI_RECORD_CLR,
 	PWRAP_DEW_RG_CMD_ALERT_CLR,
+};
 
-	/* MT6397 only regs */
-	PWRAP_DEW_EVENT_OUT_EN,
-	PWRAP_DEW_EVENT_SRC_EN,
-	PWRAP_DEW_EVENT_SRC,
-	PWRAP_DEW_EVENT_FLAG,
-	PWRAP_DEW_MON_FLAG_SEL,
-	PWRAP_DEW_EVENT_TEST,
-	PWRAP_DEW_CIPHER_LOAD,
-	PWRAP_DEW_CIPHER_START,
+static const u32 mt6320_regs[] = {
+	[PWRAP_DEW_EVENT_OUT_EN] =	0x0000,
+	[PWRAP_DEW_DIO_EN] =		0x0002,
+	[PWRAP_DEW_EVENT_SRC_EN] =	0x0004,
+	[PWRAP_DEW_EVENT_SRC] =		0x0006,
+	[PWRAP_DEW_EVENT_FLAG] =	0x0008,
+	[PWRAP_DEW_READ_TEST] =		0x000a,
+	[PWRAP_DEW_WRITE_TEST] =	0x000c,
+	[PWRAP_DEW_CRC_EN] =		0x000e,
+	[PWRAP_DEW_CRC_VAL] =		0x0010,
+	[PWRAP_DEW_MON_GRP_SEL] =	0x0012,
+	[PWRAP_DEW_MON_FLAG_SEL] =	0x0014,
+	[PWRAP_DEW_EVENT_TEST] =	0x0016,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0018,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x001a,
+	[PWRAP_DEW_CIPHER_LOAD] =	0x001c,
+	[PWRAP_DEW_CIPHER_START] =	0x001e,
+	[PWRAP_DEW_CIPHER_RDY] =	0x0020,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0022,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x0024,
+	[PWRAP_DEW_CIPHER_IV0] =	0x0026,
+	[PWRAP_DEW_CIPHER_IV1] =	0x0028,
+	[PWRAP_DEW_CIPHER_IV2] =	0x002a,
+	[PWRAP_DEW_CIPHER_IV3] =	0x002c,
+	[PWRAP_DEW_CIPHER_IV4] =	0x002e,
+	[PWRAP_DEW_CIPHER_IV5] =	0x0030,
 };
 
 static const u32 mt6323_regs[] = {
@@ -386,6 +438,22 @@ enum pwrap_regs {
 	PWRAP_EINT_STA1_ADR,
 	PWRAP_SWINF_2_WDATA_31_0,
 	PWRAP_SWINF_2_RDATA_31_0,
+	PWRAP_DVFS_ADR0,
+	PWRAP_DVFS_WDATA0,
+	PWRAP_DVFS_ADR1,
+	PWRAP_DVFS_WDATA1,
+	PWRAP_DVFS_ADR2,
+	PWRAP_DVFS_WDATA2,
+	PWRAP_DVFS_ADR3,
+	PWRAP_DVFS_WDATA3,
+	PWRAP_DVFS_ADR4,
+	PWRAP_DVFS_WDATA4,
+	PWRAP_DVFS_ADR5,
+	PWRAP_DVFS_WDATA5,
+	PWRAP_DVFS_ADR6,
+	PWRAP_DVFS_WDATA6,
+	PWRAP_DVFS_ADR7,
+	PWRAP_DVFS_WDATA7,
 
 	/* MT2701 only regs */
 	PWRAP_ADC_CMD_ADDR,
@@ -394,6 +462,24 @@ enum pwrap_regs {
 	PWRAP_ADC_RDATA_ADDR1,
 	PWRAP_ADC_RDATA_ADDR2,
 
+	/* MT6589 only regs */
+	PWRAP_CIPHER_IV0,
+	PWRAP_CIPHER_IV1,
+	PWRAP_CIPHER_IV2,
+
+	/* MT6589 and MT8135 only regs */
+	PWRAP_CSHEXT,
+	PWRAP_EVENT_IN_EN,
+	PWRAP_EVENT_DST_EN,
+	PWRAP_RRARB_INIT,
+	PWRAP_RRARB_EN,
+	PWRAP_RRARB_STA0,
+	PWRAP_RRARB_STA1,
+	PWRAP_EVENT_STA,
+	PWRAP_EVENT_STACLR,
+	PWRAP_CIPHER_LOAD,
+	PWRAP_CIPHER_START,
+
 	/* MT7622 only regs */
 	PWRAP_STA,
 	PWRAP_CLR,
@@ -422,38 +508,9 @@ enum pwrap_regs {
 	PWRAP_DVFS_STEP_CTRL2,
 	PWRAP_SPI2_CTRL,
 
-	/* MT8135 only regs */
-	PWRAP_CSHEXT,
-	PWRAP_EVENT_IN_EN,
-	PWRAP_EVENT_DST_EN,
-	PWRAP_RRARB_INIT,
-	PWRAP_RRARB_EN,
-	PWRAP_RRARB_STA0,
-	PWRAP_RRARB_STA1,
-	PWRAP_EVENT_STA,
-	PWRAP_EVENT_STACLR,
-	PWRAP_CIPHER_LOAD,
-	PWRAP_CIPHER_START,
-
 	/* MT8173 only regs */
 	PWRAP_RDDMY,
 	PWRAP_SI_CK_CON,
-	PWRAP_DVFS_ADR0,
-	PWRAP_DVFS_WDATA0,
-	PWRAP_DVFS_ADR1,
-	PWRAP_DVFS_WDATA1,
-	PWRAP_DVFS_ADR2,
-	PWRAP_DVFS_WDATA2,
-	PWRAP_DVFS_ADR3,
-	PWRAP_DVFS_WDATA3,
-	PWRAP_DVFS_ADR4,
-	PWRAP_DVFS_WDATA4,
-	PWRAP_DVFS_ADR5,
-	PWRAP_DVFS_WDATA5,
-	PWRAP_DVFS_ADR6,
-	PWRAP_DVFS_WDATA6,
-	PWRAP_DVFS_ADR7,
-	PWRAP_DVFS_WDATA7,
 	PWRAP_SPMINF_STA,
 	PWRAP_CIPHER_EN,
 
@@ -569,6 +626,98 @@ static const int mt2701_regs[] = {
 	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
 };
 
+static const int mt6589_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_SIDLY] =			0xc,
+	[PWRAP_CSHEXT] =		0x10,
+	[PWRAP_CSHEXT_WRITE] =		0x14,
+	[PWRAP_CSHEXT_READ] =		0x18,
+	[PWRAP_CSLEXT_START] =		0x1c,
+	[PWRAP_CSLEXT_END] =		0x20,
+	[PWRAP_STAUPD_PRD] =		0x24,
+	[PWRAP_STAUPD_GRPEN] =		0x28,
+	[PWRAP_STAUPD_MAN_TRIG] =	0x2c,
+	[PWRAP_STAUPD_STA] =		0x30,
+	[PWRAP_EVENT_IN_EN] =		0x34,
+	[PWRAP_EVENT_DST_EN] =		0x38,
+	[PWRAP_WRAP_STA] =		0x3c,
+	[PWRAP_RRARB_INIT] =		0x40,
+	[PWRAP_RRARB_EN] =		0x44,
+	[PWRAP_RRARB_STA0] =		0x48,
+	[PWRAP_RRARB_STA1] =		0x4c,
+	[PWRAP_HARB_INIT] =		0x50,
+	[PWRAP_HARB_HPRIO] =		0x54,
+	[PWRAP_HIPRIO_ARB_EN] =		0x58,
+	[PWRAP_HARB_STA0] =		0x5c,
+	[PWRAP_HARB_STA1] =		0x60,
+	[PWRAP_MAN_EN] =		0x64,
+	[PWRAP_MAN_CMD] =		0x68,
+	[PWRAP_MAN_RDATA] =		0x6c,
+	[PWRAP_MAN_VLDCLR] =		0x70,
+	[PWRAP_WACS0_EN] =		0x74,
+	[PWRAP_INIT_DONE0] =		0x78,
+	[PWRAP_WACS0_CMD] =		0x7c,
+	[PWRAP_WACS0_RDATA] =		0x80,
+	[PWRAP_WACS0_VLDCLR] =		0x84,
+	[PWRAP_WACS1_EN] =		0x88,
+	[PWRAP_INIT_DONE1] =		0x8c,
+	[PWRAP_WACS1_CMD] =		0x90,
+	[PWRAP_WACS1_RDATA] =		0x94,
+	[PWRAP_WACS1_VLDCLR] =		0x98,
+	[PWRAP_WACS2_EN] =		0x9c,
+	[PWRAP_INIT_DONE2] =		0xa0,
+	[PWRAP_WACS2_CMD] =		0xa4,
+	[PWRAP_WACS2_RDATA] =		0xa8,
+	[PWRAP_WACS2_VLDCLR] =		0xac,
+	[PWRAP_INT_EN] =		0xb0,
+	[PWRAP_INT_FLG_RAW] =		0xb4,
+	[PWRAP_INT_FLG] =		0xb8,
+	[PWRAP_INT_CLR] =		0xbc,
+	[PWRAP_SIG_ADR] =		0xc0,
+	[PWRAP_SIG_MODE] =		0xc4,
+	[PWRAP_SIG_VALUE] =		0xc8,
+	[PWRAP_SIG_ERRVAL] =		0xcc,
+	[PWRAP_CRC_EN] =		0xd0,
+	[PWRAP_EVENT_STA] =		0xd4,
+	[PWRAP_EVENT_STACLR] =		0xd8,
+	[PWRAP_TIMER_EN] =		0xdc,
+	[PWRAP_TIMER_STA] =		0xe0,
+	[PWRAP_WDT_UNIT] =		0xe4,
+	[PWRAP_WDT_SRC_EN] =		0xe8,
+	[PWRAP_WDT_FLG] =		0xec,
+	[PWRAP_DEBUG_INT_SEL] =		0xf0,
+	[PWRAP_DVFS_ADR0] =		0xf4,
+	[PWRAP_DVFS_WDATA0] =		0xf8,
+	[PWRAP_DVFS_ADR1] =		0xfc,
+	[PWRAP_DVFS_WDATA1] =		0x100,
+	[PWRAP_DVFS_ADR2] =		0x104,
+	[PWRAP_DVFS_WDATA2] =		0x108,
+	[PWRAP_DVFS_ADR3] =		0x10c,
+	[PWRAP_DVFS_WDATA3] =		0x110,
+	[PWRAP_DVFS_ADR4] =		0x114,
+	[PWRAP_DVFS_WDATA4] =		0x118,
+	[PWRAP_DVFS_ADR5] =		0x11c,
+	[PWRAP_DVFS_WDATA5] =		0x120,
+	[PWRAP_DVFS_ADR6] =		0x124,
+	[PWRAP_DVFS_WDATA6] =		0x128,
+	[PWRAP_DVFS_ADR7] =		0x12c,
+	[PWRAP_DVFS_WDATA7] =		0x130,
+	[PWRAP_CIPHER_KEY_SEL] =	0x134,
+	[PWRAP_CIPHER_IV_SEL] =		0x138,
+	[PWRAP_CIPHER_LOAD] =		0x13c,
+	[PWRAP_CIPHER_START] =		0x140,
+	[PWRAP_CIPHER_RDY] =		0x144,
+	[PWRAP_CIPHER_MODE] =		0x148,
+	[PWRAP_CIPHER_SWRST] =		0x14c,
+	[PWRAP_CIPHER_IV0] =		0x150,
+	[PWRAP_CIPHER_IV1] =		0x154,
+	[PWRAP_CIPHER_IV2] =		0x158,
+	[PWRAP_DCM_EN] =		0x15c,
+	[PWRAP_DCM_DBC_PRD] =		0x160,
+};
+
 static const int mt6765_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1301,6 +1450,7 @@ static const int mt8186_regs[] = {
 };
 
 enum pmic_type {
+	PMIC_MT6320,
 	PMIC_MT6323,
 	PMIC_MT6331,
 	PMIC_MT6332,
@@ -1314,6 +1464,7 @@ enum pmic_type {
 
 enum pwrap_type {
 	PWRAP_MT2701,
+	PWRAP_MT6589,
 	PWRAP_MT6765,
 	PWRAP_MT6779,
 	PWRAP_MT6795,
@@ -1750,6 +1901,7 @@ static int pwrap_common_init_reg_clock(struct pmic_wrapper *wrp)
 	case PWRAP_MT8173:
 		pwrap_init_chip_select_ext(wrp, 0, 4, 2, 2);
 		break;
+	case PWRAP_MT6589:
 	case PWRAP_MT8135:
 		pwrap_writel(wrp, 0x4, PWRAP_CSHEXT);
 		pwrap_init_chip_select_ext(wrp, 0, 4, 0, 0);
@@ -1834,6 +1986,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 0x2, PWRAP_CIPHER_IV_SEL);
 
 	switch (wrp->master->type) {
+	case PWRAP_MT6589:
 	case PWRAP_MT8135:
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_LOAD);
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_START);
@@ -1866,6 +2019,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 		pwrap_config_cipher(wrp, wrp->slave->comp_dew_regs);
 
 	switch (wrp->slave->type) {
+	case PMIC_MT6320:
 	case PMIC_MT6397:
 		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD],
 			    0x1);
@@ -1960,13 +2114,13 @@ static int pwrap_mt8135_init_soc_specific(struct pmic_wrapper *wrp)
 	/* enable pwrap events and pwrap bridge in AP side */
 	pwrap_writel(wrp, 0x1, PWRAP_EVENT_IN_EN);
 	pwrap_writel(wrp, 0xffff, PWRAP_EVENT_DST_EN);
-	writel(0x7f, wrp->bridge_base + PWRAP_MT8135_BRIDGE_IORD_ARB_EN);
-	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS3_EN);
-	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS4_EN);
-	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_UNIT);
-	writel(0xffff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_SRC_EN);
-	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_TIMER_EN);
-	writel(0x7ff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INT_EN);
+	writel(0x7f, wrp->bridge_base + PWRAP_BRIDGE_IORD_ARB_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_BRIDGE_WACS3_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_BRIDGE_WACS4_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_BRIDGE_WDT_UNIT);
+	writel(0xffff, wrp->bridge_base + PWRAP_BRIDGE_WDT_SRC_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_BRIDGE_TIMER_EN);
+	writel(0x7ff, wrp->bridge_base + PWRAP_BRIDGE_INT_EN);
 
 	/* enable PMIC event out and sources */
 	if (pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_EVENT_OUT_EN],
@@ -2110,7 +2264,8 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 			return ret;
 	}
 
-	if (wrp->master->type == PWRAP_MT8135)
+	if (wrp->master->type == PWRAP_MT8135 ||
+		wrp->master->type == PWRAP_MT6589)
 		pwrap_writel(wrp, 0x7, PWRAP_RRARB_EN);
 
 	pwrap_writel(wrp, 0x1, PWRAP_WACS0_EN);
@@ -2131,8 +2286,8 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 1, PWRAP_INIT_DONE1);
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
-		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE3);
-		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE4);
+		writel(1, wrp->bridge_base + PWRAP_BRIDGE_INIT_DONE3);
+		writel(1, wrp->bridge_base + PWRAP_BRIDGE_INIT_DONE4);
 	}
 
 	return 0;
@@ -2186,6 +2341,14 @@ static const struct pwrap_slv_regops pwrap_regops32 = {
 	.regmap = &pwrap_regmap_config32,
 };
 
+static const struct pwrap_slv_type pmic_mt6320 = {
+	.dew_regs = mt6320_regs,
+	.type = PMIC_MT6320,
+	.regops = &pwrap_regops16,
+	.caps = PWRAP_SLV_CAP_SPI | PWRAP_DEW_DIO_EN |
+		PWRAP_SLV_CAP_SECURITY,
+};
+
 static const struct pwrap_slv_type pmic_mt6323 = {
 	.dew_regs = mt6323_regs,
 	.type = PMIC_MT6323,
@@ -2248,6 +2411,7 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 };
 
 static const struct of_device_id of_slave_match_tbl[] = {
+	{ .compatible = "mediatek,mt6320", .data = &pmic_mt6320 },
 	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
 	{ .compatible = "mediatek,mt6331", .data = &pmic_mt6331 },
 	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
@@ -2277,6 +2441,19 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
 	.init_soc_specific = pwrap_mt2701_init_soc_specific,
 };
 
+static const struct pmic_wrapper_type pwrap_mt6589 = {
+	.regs = mt6589_regs,
+	.type = PWRAP_MT6589,
+	.arb_en_all = 0x1ff,
+	.int_en_all = 0x7ffffffd,
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = pwrap_mt8135_init_soc_specific,
+};
+
 static const struct pmic_wrapper_type pwrap_mt6765 = {
 	.regs = mt6765_regs,
 	.type = PWRAP_MT6765,
@@ -2446,6 +2623,7 @@ static const struct pmic_wrapper_type pwrap_mt8186 = {
 
 static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
+	{ .compatible = "mediatek,mt6589-pwrap", .data = &pwrap_mt6589 },
 	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
 	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
 	{ .compatible = "mediatek,mt6795-pwrap", .data = &pwrap_mt6795 },
-- 
2.54.0

