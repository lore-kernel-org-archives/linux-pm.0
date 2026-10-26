Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030486;
	b=09nFZaDxUUsG9/u1OFohHUohmfEvvIJlNbvu0WulIknJSkCsyPPq7QFM2Tw+uaXoznfm
	 mMA/oTCX44zAZGDBKuqtA9/m//QWtuyHhvGEXpkLefSnGUKGh7/4YMDsacQSY4aiCwhJi
	 IIlsBPjQqfqx0FtJkj7DzwYWpdnU/1StdfbqRunN1RY/rDTM6vxWAyA14/z3zaRIMj5u0
	 5qcxcG+rk0BUrR60MJaldUsNC7PPuCYUkptcy6fkjf7CR25t7ZiEvZ3uR5KU/SMWQ3VGs
	 DI5lrmkT/12syay1Q/o+40gsUAJN8eJsUK11TetK9vOKqbxY1o983/BvuA2/i9FHcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3ymnrBNdKiljDdwgY6MK3mYj3Z4/pYbQqDBb8t0BJco=;
	b=CYAB+xOFEp+aE5J5sjfNxPeAUG6Rc3m/kDMTFIumRchAamuLwxNgqGJgx/oa8bxwM1jC
	 4D3QTzDkSHZT8Ib7o5Qx+9e7LSWqBgjX5Gss06fvTdnKJARhptOKhC8jxwRFOTORkoaFy
	 c1NZgAMb8P31z91lJVpsRVpB92vGzUr0A+XMxUjPBm/p5a46KgrIYf8DdSqC8P+TUCDlQ
	 kXZWtdF4gkUVkP9uVrl1uMKP/IthnvdSsScR4QpLDshpVHybF6U23ewL57M3dGtlZhfSp
	 Hpj2cNou2s48xODGd4ZXDCIZFWJ+kd9OLomoNXSNjhBi3EngjZRdzFYmQssHcoEEfiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="NRA/3ho1";
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779B606A31F
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D779B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NRA/3ho1
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso480237166b.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030484; x=1793635284; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3ymnrBNdKiljDdwgY6MK3mYj3Z4/pYbQqDBb8t0BJco=;
        b=NRA/3ho1VkYXluT51itsNkGhX2Gabb7LiCt+Hjr3+9mWTqTTRTe/UICmvr0ko5eR/k
         5naWGkNyHYMQ3i27IWbhEPRdqM97PB3rHHQngBX/TdBfFxfenofyQDYpnCG48x8yCzIT
         nphiqeZPmJ5ssWd3lQZEZ2OU6cZf/lRvvxX1KLBfRxE7hXeoqyp97rD/HejegJbJPvrg
         ZRhZ2VAbr4st18rTsSUJbyxcKgaxHgIcHNFxxaooUpxl7EfkykgvdBZFMxJ+IFRNT3Mu
         PQjVXEAfGsmqAIEYyjXcFI2+YOkPHA2Z3AdxROX98Fq52e6bLT0U/JFg3oSogaLXl2rO
         pa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030484; x=1793635284;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ymnrBNdKiljDdwgY6MK3mYj3Z4/pYbQqDBb8t0BJco=;
        b=04LlT4ImwFOPGw9qJc/xocHxuDwgkp5i+7s4JPWE+96VpHivw8GIJc/11PvEit9kEv
         l0lfKmma4GlWVSGumhCSUaIm878X9FNmB21yFwxma9jdUXjouZ9aTGr+ksqijf0Zb1HP
         Pus4PuStubbhFSsIX0V90cbUUSfSQnnwgU3Yyc4in6l+kG1ZJ9nNVOLhkDuXh/yf/6TC
         Vm5P4mhP8Qx6soWzhTcWImicDqH9ALdVWL9+0GNXxD4Is7ZXywPzu+9GCyujU5lUCvTv
         teYB1gK6k4QJlQ4aTZXVKv2LxU2xDL0J2puaes42G3KEGj371061u2hmU17wr8hZZeCm
         eyng==
X-Forwarded-Encrypted: i=1; AKwUvBwrqGOOJSnNeVQPDDcxs2zSivq7jCZg/4recPMXgjhbm8iRxsb96rEhQSOQXNJzw/v3iN56udwXlA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK4gmjWeST/eWlzSjeuDATrJtEKzmJWPWN7Qf3QiU3PLrLTXgN2
	W65MWutM8BGpmfbcemDOYXFKbBiRVOV+YaihIpv0Ru/t5HoWyNUZw/e2KdW1xHxVa4Q=
X-Gm-Gg: AYBFou1Zpbyn7GEgkn1IbnTdGWDdORZxa3/aQ/H5p7+oipSLJmgGCBeW0VitJ92j3Uv
	NUjFs0kJ3qRX4rrvIScRUCnOvDXbyoShlmBHoWzWZcdp5dyWwyTv4QNIT4Rrz+sucw3xLsneTwu
	D2Hu5H/APq0NmKVk4NEroves9zoHa/+pBH7O87wg1fBiJC0Sx8UbnC7biZ53aFCjryTWrt+uc1s
	PpilOxwG8tjJtYROmhPs1zLfTgmE32qKtiWek9ge7FJqHu/w/VNmG/FAWq6hquxqIBYed/I4eEl
	NELmWJqhPtxR284w4AVgayKvUAp67cK/KLPFvrcDOUnVWt/jEG+ozK5W/6R8FR3NxlLdd0B3iVW
	4J6crmD62I40rHf+sPTga6SXej6nrBJi6qRurQxr1NfCQyJigWBZASOJ9Dg4jY0muHpLDLWTA2T
	1grJ51xJjoi+mawd7cGEeGZYTpBQ5gsj2+ideos3tyv8OAkAiyuw9VO6xzRJX4IHdyeUDo8bMEV
	P7O+Gx/uUgtJn7rZ1K9b4LOGDRWb2MWrGi1K9laASen3mowiz2xO/igvGYxBNKxZilvCjVqfUBo
	8eExiwd4rcP2te+zjy0PoDj7b9mZQfcZJBvc
X-Received: by 2002:a17:907:100c:b0:c49:4450:6248 with SMTP id a640c23a62f3a-c4944507cccmr269354066b.16.1793030484097;
        Mon, 26 Oct 2026 09:01:24 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 00/15] thermal/drivers/samsung: acpm-tmu: Fixes and
 cleanups for GS101 TMU
Date: Mon, 26 Oct 2026 16:01:17 +0000
Message-Id: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAE5532oC/x3LQQqAIBBA0avErBtwJEq6SrSwHGsWVmhFEN49a
 fn4/BcSR+EEffVC5FuS7FsB1RXMq90WRnHFoJVuSVGDdj4CnuFCLw8nNJ0xjrSePDGU6Yj8h/I
 MY84f25NX02AAAAA=
X-Change-ID: 20261014-acpm-tmu-fixes-8788d122bf1e
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=2074;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=I/JMyWiRNIubE6cFu1pbLVDJyCCuA18f15y27xl2iK0=;
 b=R0jk61V3qMv0AjCuKodXZM/4F7Skr+tAD9gSsK7jMggcOhEIu3b3xJNKfFwX7jqgduBv21Dbv
 o2MrKlbxi1ZCgdxkUO6i50DEVapod3/A/6gmjJSXeigOqsylkvVv8Z2
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Hi,

The series is structured with fixes first (patches 1-10) followed by
cleanups (patches 11-15), so the fixes can be picked up for the -rc
phase if desired. Patches 11-12 are placed immediately after the fixes
in case it is also preferred to take the driver and module renames
before v7.4 is released.

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (15):
      thermal/drivers/samsung: Select REGMAP_MMIO for EXYNOS_ACPM_THERMAL
      thermal/drivers/samsung: Depend on PM for EXYNOS_ACPM_THERMAL
      thermal/drivers/samsung: acpm-tmu: Fix acpm_tmu_resume() error handling
      thermal/drivers/samsung: acpm-tmu: Disable IRQ across system suspend/resume
      thermal/drivers/samsung: acpm-tmu: Implement .change_mode() callback
      thermal/drivers/samsung: acpm-tmu: Rely on devres for probe error and remove teardown
      thermal/drivers/samsung: acpm-tmu: Return -ENODATA when sensor is disabled
      thermal/drivers/samsung: acpm-tmu: Annotate lockless sensor->enabled access
      thermal/drivers/samsung: acpm-tmu: Fix IRQ locking and error handling
      MAINTAINERS: Use linux-pm mailing list for Samsung Exynos ACPM thermal driver
      thermal/drivers/samsung: acpm-tmu: Rename platform driver to "exynos-acpm-tmu"
      thermal/drivers/samsung: Drop redundant composite object in Makefile
      thermal/drivers/samsung: acpm-tmu: Disable regmap locking for MMIO INTPEND reads
      thermal/drivers/samsung: acpm-tmu: Clean up probe error logging
      thermal/drivers/samsung: acpm-tmu: Simplify pm_runtime_resume_and_get() error checks

 MAINTAINERS                        |   2 +-
 drivers/thermal/samsung/Kconfig    |   2 +
 drivers/thermal/samsung/Makefile   |   3 +-
 drivers/thermal/samsung/acpm-tmu.c | 232 +++++++++++++++----------------------
 4 files changed, 98 insertions(+), 141 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261014-acpm-tmu-fixes-8788d122bf1e

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

