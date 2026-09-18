Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4E439F90
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707487; cv=none; b=oewkjRBFm200AGkdT4ZwmTC8ulirHuD/qWLzBLgKShsWFCdTrcxizvknWE0XmmxbHfEb7TsOv12lHi0pkr1H3qfiLrwnpPVGfh5e7ycfBVG3l5kj//Pj96z6ZKFe8rkW0MfXveeFZY3fBjJhxnLxlq7EOvXeJZeQp4F54fnh9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707487; c=relaxed/simple;
	bh=1ZbFpDNmPpKPUw8gavi59S7TugQ/2BR2pAG4PVbmBvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuSneU6WI/+KCLMltA353BjA/3DFKMdzcrl68hYkiSFNLGKVgqHc7Li5I7iFJCycM3GF09nPLRlcQcKqngCC5PkEbahMHp6APMJhHim0HgWn286UKDOYR7KgCPqXDxf4+Ml7sEj6zSXmh8C2dkG4t7hi1s3zufCvJzGWVUAbh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKfTiUgp; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKfTiUgp"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4bfec71901fso172324b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 21:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789707483; x=1790312283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2vctS1HDPIT/X25n9pLYfCPg6VUQlM6OzxcQLhiTME=;
        b=RKfTiUgpbGI2O95h6oM/71226s4gw5TNrgZAf29hi7Z/cyF3vo9nkZOJRIrT3KL+EK
         A3r9Ied19wveBX3OaRta3F9acrNxg6VNw10rpD+4Fw2MRk5DqiJhwOrOlyNvSklWIAuZ
         01mIBe1w6v9aTN68pTG7mjUT803swR+ZZbUxYkrprXUQeXJcj4aDRy4SdziFb/fEJ1l9
         +ctEbtICOrH0id1U2UAKulvCH20YAaTqIdiIbnbbdUmo02k+rV7Sx/VkYHPG/bLWOrDc
         aIrs4YSJomC857wzzWAsXjEQ2O5A4zouplWaDWPHUCCn7TBI6Lh4hxeUFLQtX0tTO2V/
         vn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789707483; x=1790312283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2vctS1HDPIT/X25n9pLYfCPg6VUQlM6OzxcQLhiTME=;
        b=1ttd+35SpTcqXdazBq4Lo781NQILYkEVvzhlgTPKDzTldhx2DzJD6VOECOgJUlwSga
         1kjZtP33ljQ+Mv6lbM6NzE6xbRUUn+C6esP67isjl2rul018UVdDf8M+keyqKW4T5UJL
         iNXNiy3hXIbCC/gemyKYrIpl6fKl+Gl3yMOlm1UOp63hjM+O/JTPMF+ZbHURUvaf9rAS
         CSrLZ9OxpWw1zKN0cJ6+WiGVKIHsTLNr7x2G7SgdOdcrchISktEEu+2uwhUoEr14Deps
         GQZe+D5WoBfseoLF6594KjYUyatX3I9nhALq3cKWaOunzf/lLrFTeathPTg+P++mR9kG
         hQgg==
X-Gm-Message-State: AFuF++mtS8Wu8zg01cHquwpMygFjSkx8d/sUSUiM9tL9EMvhCmtuT/9b
	8hL4SwysDL/4rqNjrYbxtl5A9fmnbW6bJ6wTPCWyiCUId8wTjlqipLsp
X-Gm-Gg: AYBFou3BHxvvTtnLN64XDNGWnDaoKodvCzLN1ey6Bo8NRliQ8lQLZIUNuee4jvwAXTi
	En0ykHmBNLT3Xk4nrVtDmgfiQrc3x0QLRLtXGWjJU78W6TSyqhW8ldntMAAJZ1EkUkskycbz0PT
	TRjDlNy+0/P53MwlUokT+r1ftS99AO3Gg7B/bfI+tPthY/RjtxZca7vhU6zQHuhJpW7X3ulgb7q
	xrMq6FBxwnF/gDTfnIB9uv2fNwqWbbmby9QdASvKpp0eGkKyYGggxBiuv1699RlnIuIXPgZa/a9
	KWp3ixwKzvmem1xoXSgc0g7Lw2XqCjxzRiAsR4RIQVu42esanzR7NEI+vhCTBISUmXTDfuEISuq
	pSUgJqSNZQ0egMo4yMVHJ6/hs0uThjtxoRtm+aL96pjdBx4USIwPwoDLj18K3mhbXMg2Njr5fG5
	jJ4r+GH+JgVgoCIasjEZa0UmAkv+qYB7zkWpP55LjspxMs3ScAXKb75nJrL+4iYIiTWw==
X-Received: by 2002:a05:6820:198e:b0:6ba:1356:2038 with SMTP id 006d021491bc7-6ca9dc81d82mr1247500eaf.65.1789707483400;
        Thu, 17 Sep 2026 21:58:03 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48739da0d0dsm256318fac.12.2026.09.17.21.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 21:58:02 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Thu, 17 Sep 2026 23:57:47 -0500
Subject: [PATCH 2/2] rtc: mt6397: expose the spare bytes of the alarm
 registers as nvmem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-2-558b8f95cfbc@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789707469; l=5079;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=1ZbFpDNmPpKPUw8gavi59S7TugQ/2BR2pAG4PVbmBvQ=;
 b=kj88aZa+h4fhuHQwM8Bk8GTy18OwBUHg5C5G/Eakbrvp92M6E9GMdVV5SYpbTN1UoeBxPc9GB
 pvRQ/rrqw2PDudl5VHFcBTBuqsjCkWZg2xKtUjEWDMv3azffj7wA3JR
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Each alarm field lives in the low bits of its register and the driver
masks its writes accordingly, so the high byte of four of them is storage
the RTC never touches. MediaTek names these RTC_NEW_SPARE0 to
RTC_NEW_SPARE3 and gives the first to a fuel gauge, which is how its PMIC
battery drivers carry a state of charge over a reboot.

Offer all four as a battery-backed nvmem provider, so that a consumer does
not have to reach into this block behind the driver's back. Doing it here
is what makes it safe: a write lands under the same lock the alarm paths
take, so it can neither be lost inside mtk_rtc_set_alarm()'s
read-modify-write nor fire the write trigger in the middle of one.

The nvmem core does not range check a cell against the provider size, so
the callbacks check the offset themselves.

Tested on an MT6397; MediaTek's spare map for mt6323 matches, and the
alarm field masks are common to every compatible this driver binds.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/rtc/rtc-mt6397.c       | 91 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/mt6397/rtc.h |  7 ++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 3d857681f760..d6e156516aa6 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -4,6 +4,8 @@
 * Author: Tianping.Fang <tianping.fang@mediatek.com>
 */
 
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/mt6397/core.h>
@@ -243,10 +245,91 @@ static const struct rtc_class_ops mtk_rtc_ops = {
 	.set_alarm  = mtk_rtc_set_alarm,
 };
 
+/*
+ * The spare byte of each of these registers, in the order a board addresses
+ * them as RTC_NEW_SPARE0 to RTC_NEW_SPARE3.
+ */
+static const u32 mtk_rtc_spare_reg[] = {
+	RTC_AL_HOU, RTC_AL_DOM, RTC_AL_DOW, RTC_AL_MTH,
+};
+
+static int mtk_rtc_nvram_read(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct mt6397_rtc *rtc = priv;
+	u8 *buf = val;
+	u32 data;
+	int ret = 0;
+
+	if (offset >= ARRAY_SIZE(mtk_rtc_spare_reg) ||
+	    bytes > ARRAY_SIZE(mtk_rtc_spare_reg) - offset)
+		return -EINVAL;
+
+	mutex_lock(&rtc->lock);
+
+	while (bytes--) {
+		ret = regmap_read(rtc->regmap,
+				  rtc->addr_base + mtk_rtc_spare_reg[offset++],
+				  &data);
+		if (ret)
+			break;
+
+		*buf++ = FIELD_GET(RTC_SPARE_MASK, data);
+	}
+
+	mutex_unlock(&rtc->lock);
+
+	return ret;
+}
+
+static int mtk_rtc_nvram_write(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct mt6397_rtc *rtc = priv;
+	u8 *buf = val;
+	int ret = 0;
+
+	if (offset >= ARRAY_SIZE(mtk_rtc_spare_reg) ||
+	    bytes > ARRAY_SIZE(mtk_rtc_spare_reg) - offset)
+		return -EINVAL;
+
+	mutex_lock(&rtc->lock);
+
+	while (bytes--) {
+		ret = regmap_update_bits(rtc->regmap,
+					 rtc->addr_base + mtk_rtc_spare_reg[offset++],
+					 RTC_SPARE_MASK,
+					 FIELD_PREP(RTC_SPARE_MASK, *buf++));
+		if (ret)
+			goto out;
+	}
+
+	/*
+	 * None of it reaches the always-on domain until the write trigger,
+	 * which commits every pending alarm register at once -- so this runs
+	 * under the same lock the alarm paths take, rather than landing in
+	 * the middle of one of them.
+	 */
+	ret = mtk_rtc_write_trigger(rtc);
+out:
+	mutex_unlock(&rtc->lock);
+
+	return ret;
+}
+
 static int mtk_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
+	struct nvmem_config nvmem_cfg = {
+		.name = "mt6397_rtc_spare",
+		.word_size = 1,
+		.stride = 1,
+		.size = ARRAY_SIZE(mtk_rtc_spare_reg),
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.reg_read = mtk_rtc_nvram_read,
+		.reg_write = mtk_rtc_nvram_write,
+	};
 	struct mt6397_rtc *rtc;
 	int ret;
 
@@ -293,7 +376,13 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	rtc->rtc_dev->start_secs = mktime64(1968, 1, 2, 0, 0, 0);
 	rtc->rtc_dev->set_start_time = true;
 
-	return devm_rtc_register_device(rtc->rtc_dev);
+	ret = devm_rtc_register_device(rtc->rtc_dev);
+	if (ret)
+		return ret;
+
+	nvmem_cfg.priv = rtc;
+
+	return devm_rtc_nvmem_register(rtc->rtc_dev, &nvmem_cfg);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
index 27883af44f87..f4da579ec638 100644
--- a/include/linux/mfd/mt6397/rtc.h
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -49,6 +49,13 @@
 
 #define RTC_AL_SEC             0x0018
 
+/* The high byte of four of the alarms is spare, always-on storage */
+#define RTC_AL_HOU             0x001c
+#define RTC_AL_DOM             0x001e
+#define RTC_AL_DOW             0x0020
+#define RTC_AL_MTH             0x0022
+#define RTC_SPARE_MASK         GENMASK(15, 8)
+
 #define RTC_AL_SEC_MASK        0x003f
 #define RTC_AL_MIN_MASK        0x003f
 #define RTC_AL_HOU_MASK        0x001f

-- 
2.55.0

