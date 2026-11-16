Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854802;
	b=A9DNzUbP71Xd1fWtt3wAQEbv0mCcBh6eYtTCTghXL436mHjP0hRHQP0ATtDrcrncXEf9
	 qpztJsnh5Li/hSoMB1a9/gYwAZs38bWfu/UQoLsDfhhf8Kv+QzVV8LJL8j78dGWTTi+qk
	 RkB7/MF67MSOw/oJgLxXT/QfPOSoGoBjoN+LcsvJY5p2PjU1FAJHjtdl47b7U9agS0EBa
	 CDUSBt2mhkJwPJKQsLRQDNDWjeSyQ46ulOLp7tGO9n0LCzbnSJNV76aEn1tSQrbGYFYk3
	 3hhXU+N3i/vcXtdLY5F4q5bY5I7OswMM8NUEIt97dc0xvQY6ZfnhpYxVk5aVefegaQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=tFzDEYw+EnooXYdZM/QgeJxwD9oyUj/5EK6tkUOx56g=;
	b=DpjX9fdLR/NafG9YRFtAQyjn/kcezEwGWWdYA+CmfZ/H7X3GQW4ctOsYqosnnmwjoHz/
	 uJ7qIWF2v1cN7+uyzeBISc0moq1UkvhUw0qavZ1FINhT+ja06aERB+xRPoxTk3uZc3Bkr
	 v2MES2t1eCcPEspZ0jPr3zBlSdobLR/DImKJ4+IIjbbA/txvtKfxdEic7HIFTVu6h5prj
	 j7Rlx17tb9VuPCxLYYU+j8oh0sDA5WbcX30wRUSCqGzfMnuBMYahOu0VQ8/0ZFaLR1saF
	 nOS3fXcN4DOwPFE5xMjR1KxcIE/oDGpyKPhaOm9JTB5y62dLjDyE2MLT9er9EoVmYPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LH2NaDId;
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85E606A332
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 18:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C85E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LH2NaDId
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-51cddc2451aso1328852b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854800; x=1795459600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFzDEYw+EnooXYdZM/QgeJxwD9oyUj/5EK6tkUOx56g=;
        b=LH2NaDIdv753SjJEeUr7ecK4bF/cc+zRWr1U26KYqgTiyD06NGMXCrAMQXdGBkEp9d
         fcQZjAzFzFiaTeDl7IZ615eUklx4vwO2lOFxDx8S6r12V3b9HeY3MtplnQC4rNrbr6Zo
         yARNzQB1HjTxhtRoRK68WqF2fIHw5/zuRnAWVSZm7PJLnzVj40TO8aWwLytLjmSag67D
         VIPWP7Bp3wbPmYlNuEBUjiuj9eXTBe7FSNpiVfajXs6SwzFaxhLoo4zwahGwci3pYG2p
         soVGU7w+mKiLJr7bQduw1oWIVaBp608WOhOq8LEJFb4vPn5q+OqqzuGkgfWYIMJzJyTv
         bqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854800; x=1795459600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFzDEYw+EnooXYdZM/QgeJxwD9oyUj/5EK6tkUOx56g=;
        b=DXJOL3Vio+fd1WHIR+iyGAa88M7aAeOXmQf7kDGJ4ePscvf5nK5y4KArnLTlquXzou
         UbouOwhVLftNiPHeZhf9OOiFM2RGBUrDFzbfMvxWFu/aZe6FPHh4aCQkTiAI2NZvN58l
         s6EVN61KAGnD+6I+Y9E6P+ZdXmW4EN7WIBDRGWWy2SksYQIfx3GZYQtvxwBcw2XE6+D0
         v8AKkcCFgYpmtFwMT0jxeazexexUfR28j97G44UntLNMC+2nFoTcxkM0iZriHVVvc4Aw
         Orh2ezw8kgjOzj1dBGKNHPljP8zIfgRx1xSpb1nHQCHLM8ZeDtLdk/4pc/oA01pC1SAQ
         bFLw==
X-Gm-Message-State: APuU4Z/qj0y3CXijduAsE/xCpwmdKV58g4p8QGKEm/b2AvYIOqZIPftV
	ZsiCDwMA38QBaDmoPD4jQb1JILFHGEcixsc5hWKlCckltrUpKCbg22Zm
X-Gm-Gg: AYBFou00DtkRH2Vjseca7lJjQd/WnB3vQzS/V0wywdIGTDyI5WyOiiCNzWjuKSYozmh
	SK7IdS5b7QVBLMPVhcn7ryvGJ0LQgdfOVAi8pqWhjDr1pgHToireFtsQD9+wel/vkdcadvdpcaH
	mdhmxkR9hvk2RXEQi7jXyX458Uj+IqmU3yiuwYkIoZIYbVCDU5Qs3A0u0y6fpXbNwL05m+QGPQm
	WzYGBY/3jrzDdITEXEmwj1WNZpOf+Juwcj+6BWIYuDk4cHXkJVBEAdtTPzw7kSZA1Oj5Hsih9tK
	KHF8/2WCDnH2Jff1rMwnekZI963AdZ9AYhky9xOdz9gwc47BI1KE2gAZIMehnIly5yr7D6rLPqu
	qIoLlrkAMpySPWQ3rGhqSlmRSpsNhRnZpTqB/p0Ay3MPp1kUIR4xUEbrLpH4u55fBM3jit0KOg5
	URvEFfA+FRuVt01461Ao9ANBH2q97GCVRS7u55y/MTT4MDrMd1Qwm1NZxkv7vwz4ti3NJCWg2/K
	AHhP2i5jRYtlL7+uaSlyN9N+ynuXhJja+v1m3rwuYniVhXGujvPVrGLogvHb1sCbLjXtXjt01O1
	Tyac8IewNe9CH2OKIcow3VEkvcZXTyyeydxT0ovNphbxk7Pd+61noQF3tIcc2PzA66FNUk4BHOZ
	IrSFYiHSfoJdRWJW8AHE=
X-Received: by 2002:a05:6808:4fd2:b0:4df:5cd0:89c1 with SMTP id 5614622812f47-56e63ba5727mr9976924b6e.23.1794854800435;
        Mon, 16 Nov 2026 10:46:40 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe242b670sm7210735fac.17.2026.11.16.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:46:39 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 16 Nov 2026 12:46:33 -0600
Subject: [PATCH v3 1/2] rtc: mt6397: rename the write trigger register
 offset
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-1-179145eb7e89@gmail.com>
References: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
In-Reply-To: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794854794; l=1817;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=df32cdCXYqRXb7AgGz4g+i9owLPH2NyaDIX+9W0kTJ8=;
 b=YXj0OOXR/Ek7mAgVNZ2ePkshYGmwdQh66wpXgUVRUARhBWhlo4xL7c+hw4g+ulZz6PAARMwLB
 rVWKea1gZoeASnjj2zRQPwTaWnyl9lPPgcWMM+sqyHTCH5hZTlMhQwv
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

struct mtk_rtc_data holds the offset of the register that commits RTC
writes, in a member called wrtgr after the register's datasheet name.
Call it write_trigger_reg, so that the next member, the control
register's offset, can be named the same way.

No functional change.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/rtc/rtc-mt6397.c       | 7 ++++---
 include/linux/mfd/mt6397/rtc.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index ab402f9f85c3..5afdb707a5b5 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -22,7 +22,8 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 	int ret;
 	u32 data;
 
-	ret = regmap_write(rtc->regmap, rtc->addr_base + rtc->data->wrtgr, 1);
+	ret = regmap_write(rtc->regmap,
+			   rtc->addr_base + rtc->data->write_trigger_reg, 1);
 	if (ret < 0)
 		return ret;
 
@@ -411,11 +412,11 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
 			mt6397_rtc_resume);
 
 static const struct mtk_rtc_data mt6358_rtc_data = {
-	.wrtgr = RTC_WRTGR_MT6358,
+	.write_trigger_reg = RTC_WRTGR_MT6358,
 };
 
 static const struct mtk_rtc_data mt6397_rtc_data = {
-	.wrtgr = RTC_WRTGR_MT6397,
+	.write_trigger_reg = RTC_WRTGR_MT6397,
 };
 
 static const struct of_device_id mt6397_rtc_of_match[] = {
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
index f4da579ec638..44d2b2cb1ff7 100644
--- a/include/linux/mfd/mt6397/rtc.h
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -71,7 +71,7 @@
 #define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
 
 struct mtk_rtc_data {
-	u32                     wrtgr;
+	u32                     write_trigger_reg;
 };
 
 struct mt6397_rtc {

-- 
2.56.0

