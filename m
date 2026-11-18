Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009912;
	b=OwoXto4gAIXVCbEf7M9Q9nEjQVHv4RkzT4CkFTN1iSj24CmSxjHNgMpOimEGBevjKuAv
	 cjMBEra1lvjn0+awi3J6Fzm2pTL7TWjIIhLMrxZmg33oa42x5Pv9zvOy4nxNEB2s1CuJO
	 RpmHNmGs5RIYK0XxqCWFpmiltIVT4ukU1h5n5L/gG14L7cIxumy8p9KEjHNAJr9DBTLyZ
	 EVnNPYyGrY7059OezZqz72+oOB8jijDFc4TSlGMvqlJzIFAsR0tbLvJgNfzypkkCKTxsB
	 Tv5xup7H8Oe65lJDxVJ4RUthPohAC7QbxK86bncIAAoNOPTKb6WwKXh2WMApYkgKY3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=HUF/PiY/f+/s1GZtbGWRhctQRnBXulbhgqm2mv2gHGQ=;
	b=q0NQ+QuZoF0k8sj8pRPhKfIDEvGnLOMShg0Ngjm/Kt+gqg1OEhnT6kNHKMnvHJxmwobs
	 NxP/B2guFcK5ad/yUwyXYf1ylY5LU79gFz+TGNzkCkFv+AXXOmg+5oI+vN0arqxvlyVXd
	 gmvzeillGEA0G+8g9CKeWxqS9Wy8dpRXzM4lGzL8IztJhv30sMazMuQxtMbg8H5gw8IoS
	 5PtRxSxZtpoBLC7xwOs2o31HfCB3+KCC06urj8gdVt+wHo5XqCG3Kw10pYkvaHh2f1Sxn
	 5Yew85J7pTLML562/kKPo/csheftFMhNBmK/Q7ygSvddhiDw67pf8TRRv1QyuzO3dyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q6Hk7fXm;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15F606A325
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C15F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q6Hk7fXm
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7804705e9.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795009909; x=1795614709; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HUF/PiY/f+/s1GZtbGWRhctQRnBXulbhgqm2mv2gHGQ=;
        b=q6Hk7fXmsBsuxdjkDkBlv44AT1bT0hm6ntzIs4Gw0Cae8Yhikcl8UhS+ywrJYx+AvQ
         K5ol+N/H/5j8wdixMc4x9TyNrNHRmu/Wdfh1uS5O6eZ3b+hPsl9AGYXkxeaEJa3qfakk
         TeknNRDyFdwkE3qpeNvSGXkRXqKINsVq8/t3CKi0G5GY8CTsJR3mgiBArlSylRFFhLoa
         JlKU0WlosAiOkF+cc17Mqd0KTNOk+2uzGmbRRyyIgszoQD3GOAtn2EitFWGZTSeS7V+d
         qpnI7LvKalvqxTx1y7DvC88do/03arE2+1fmeEu+aJJL6HaXD0qVH/0FaGXoxVJLoGBe
         h2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009909; x=1795614709;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HUF/PiY/f+/s1GZtbGWRhctQRnBXulbhgqm2mv2gHGQ=;
        b=S7t1Xybeix/t0HdP/E9lO2DVPWc8Wlnkf2n7AScYPjWP1DSF0y2OdYwLjijTq8Py0/
         8Wk+c2zq+SFiv3P/kpjPGPBN0p+ta0wYA5eSNBvz8OYeqid07lOSFZzjXg1jSv9smwrm
         IiyCemJ8Fe9A+UpNKl/Tf8tmpv1uqdGKS5nNUR4TH/USqROccLUU51OLR01Pn1sdSVi8
         GIBWk7uj16Llsjds/ENR0TsLsdWjcYXZDZ1dRwF3rlULH4wu02i+0nUyWefgnRufunER
         ceKpAqimkn1C8NWeCpykT1Y/ASqt7nIdP+ZulhrAEeGlGOe0hT+Qodlx8uUMoAUrwJY+
         n0ZQ==
X-Forwarded-Encrypted: i=1; AL+hErFVEetcJE3xsCbmymC56BIjfO7cPt45mxmJp0yGzCGDMUNqnmBONrCQyj2eSUUCySOuu+1l/szRDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dMi0K4kjCpQnbrpCfbj7mGdc28rgitheRzbRDh9PKlJWmmf48
	hyElJvyPMVrrTqxd7Uol4DnHuhyEK8rMbczihG9hjmuOLkKgY9m2P8RNVIMkAQ4VZdQ=
X-Gm-Gg: AYBFou1f+agAME76zTMEr+w6oAwssiQU6hH78f8fYSjD45s1FSO6bHcWN/Q4qkQkYpu
	fQwllQiGZcY3BtWfc4rzt7G81KZeWVVa3X7Xq+SHEepIvyuefz02lxJjcW0tb4LQbf08nmJSgix
	oXVsaCZR8bJPJpmvArkHgPnRLPbP+I0tlzrHLITSTNFkeGXyNN6Y9bP5gPWw5RIJsRVLQSQp2OB
	soa5dzxhGXFGJet+8St1HoTiON8vRsjTOtaXc0kr8Czc/7pt5PbVSbsg+oyUZIXogIUxbNFfkVb
	02yWcVAZZTgWMfkXGulH2oDcTWETHreh83GbbjUsT3KjPLbqFv1NZtbCRFyVBInQSTu0fWwdmLX
	f0kMhs6/uhoAFIp7Z84OBXTPRImKPrh8LvxFInynnXtfWNr2C2gy9Ln9tfavEUyOlxyJvAg+Kd4
	VWEvtmstJ0xRGsdjcVjSgZzoZFeAwKAZF+6+xcvbOoVTXJHgTXaNKjq5Chl8ybz+0X7NAFXulvL
	rIFE5hIk8jSHZ/+WdTsP/yzgxuoRHQUj2ZmB9Zl8KVZ2SHD++kE5YR/51pc2R6xstSXULNOfroS
	FOIP0AXGJx0Ba77UFq8Lmoy38PpQTh21aLJ8bBK/u5k5bQvRyHpVWih753hBcSimT2fSJRIZArc
	xqqH7k7tUD5/ASwhRqthluBg=
X-Received: by 2002:a05:600c:81c5:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4bb7da38bd0mr49500135e9.24.1795009909409;
        Wed, 18 Nov 2026 05:51:49 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:80a3:e955:3785:90b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm208544775e9.10.2026.11.18.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:51:48 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 0/3] thermal: samsung: acpm-tmu: Add Exynos850 support
Date: Wed, 18 Nov 2026 13:51:44 +0000
Message-Id: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dswMCrSsvIdhUegATYQ2LRAN4
 e5W9i7fS/77u4gcLEdRZ7sIvNlo3Zwgv2SiG/U8MFiTWOSYl0QkQXd+gmVagWWBEFfvXVjAELJ
 CkhWpVqStD9zb99l9NolHGxcXPufNRj97FrFC9ae4ESCo3phCtuXtrvvHy846uKsLg2iO4/gCF
 61vA7sAAAA=
X-Change-ID: 20261118-acpm-tmu-e850-support-d10e9018719b
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, 
 Thomas Turner <tturner@lineageos.org>, 
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

This series adds support for the Thermal Management Unit found on
the Samsung Exynos850 SoC to the existing acpm-tmu driver.

The acpm-tmu driver was recently introduced to support a hybrid thermal
architecture where hardware management is shared between the kernel and
the ACPM firmware. 

However, the distribution of responsibilities between the Application
Processor and the firmware varies depending on the SoC:

1. GS101 (Existing):
   The ACPM firmware handles sensor initialization, threshold configuration,
   and temperature reading via ACPM IPC. The kernel only uses MMIO to read
   the interrupt pending registers.

2. Exynos850 (This series):
   The firmware implements a much smaller subset of TMU IPC commands
   (temperature readings, TMU suspend/resume, basic TMU init).
   The driver should use direct MMIO register access to support the
   remaining functionality.

In this series the patch 2/3 prepares the acpm-tmu driver by moving the
hardcoded GS101 IPC calls into SoC-specific callbacks: tz_control,
tmu_init, tmu_update_thresholds, and tmu_check_and_clear_irqs.
The patch 3/3 implements actual Exynos850 support.

Tested with:

tmu_top: thermal-sensor@100a0000 {
	compatible = "samsung,exynos850-tmu-top";
	reg = <0x10070000 0x800>;
	interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
	clocks = <&cmu_peri CLK_GOUT_BUSIF_TMU_PCLK>;
	samsung,acpm-ipc = <&acpm_ipc>;
	#thermal-sensor-cells = <1>;
};
and corresponding thermal zones.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Changes in v2:
- rebased;
- reworked defines and hardcoded values a bit;
- removed efuse_value from acpm_tmu_sensor struct;
- regmap renamed to "exynos850_tmu_regs" from "e850_tmu_regs";
- checked ret value from regmap_read/update_bits calls;
- dev_err() -> dev_err_ratelimited() and return error if clearing
  irq failed in exynos850_handle_irqs();
- exynos850_tmu_update_thresholds() tries to restore sensor state
  if failed;
- Link to v1: https://lore.kernel.org/r/20260709-acpm-tmu-e850-support-v1-0-9fdd58b634af@linaro.org

---
Alexey Klimov (3):
      dt-bindings: thermal: gs101-tmu: add Exynos850 compatible
      thermal: samsung: acpm-tmu: refactor SoC-specific operations into driver data
      thermal: samsung: acpm-tmu: add Exynos850 support

 .../bindings/thermal/google,gs101-tmu-top.yaml     |  26 +-
 drivers/thermal/samsung/acpm-tmu.c                 | 588 ++++++++++++++++++++-
 2 files changed, 577 insertions(+), 37 deletions(-)
---
base-commit: 7cfbf79c66c63e807ea452abf0546e6f6d6833a6
change-id: 20261118-acpm-tmu-e850-support-d10e9018719b

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>

