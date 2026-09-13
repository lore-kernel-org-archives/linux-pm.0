Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285735BDAA
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311627; cv=none; b=I7AxTBXhmKHSqUoEqkvco8zLeCNS7pjP5UCZVe6DR6S9Sd4OJD85L0/MLO/V7jYTrthaHRdl+inGq6fHZA5hWwQ68XNlknnqn/wCc6Q/KXU+CprOcTAvlELOIbK0uY8usNatlZ4phubtG21b+lHFEIVUbecJaRTAacuA4vM2I3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311627; c=relaxed/simple;
	bh=Ac9hJRO3+NqcDPgpt7ObfLuM8SaCLFN2CkiLPShmu74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkQ6etqq/xF+CmhMzb75+5k5rpls6TfmPJttOmWJVDwEFjpOGM95WQNY3b4THyFLg6udzajznVPxYEIZpjJBNEXN1+Nm1Y1P0GaA4hltMchSTXvqJRWBMHqamebc6nEFxw3d4r40R5tso6wkVkm13faiSURnoHONayqfSjk6nCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBI+SSsw; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBI+SSsw"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso1277385a91.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311626; x=1789916426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlzyvIo8nOadqp8jqeYyZiaPQY3f0wl+9I9FZEmerIU=;
        b=CBI+SSswXkjg52r1YrtXIhJwNXP6vn5eEbr7iJQa1haJujnuQO2gQ1k7GgIy8Q0bvo
         7wmG/bytRTS+yZevML5ZZPa4P849LwzApwISD544/nPSVo8thrlCYhzJqXxOoNLSo5Jp
         PbtUgylTGapCpNN5HGfMRzAFQIf0DQu5n0+/9hg5FvIwlX2faMYGg2hZS/oPk1wRSUoK
         uxD9y4PSjaeXwA32ZWp/8EfUUgDkAeL0SLiUGpePoy+8VmuaZMbvsv8wROx1ulE8SuBW
         upc6JUJf0QluqGyzCHwCkclCfGI6UFt4Fs0CSvgaF4Z1sJP4t8xofxAYJeaUiicEjKTe
         7cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311626; x=1789916426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlzyvIo8nOadqp8jqeYyZiaPQY3f0wl+9I9FZEmerIU=;
        b=c38G7wcrifMausPn3gF+e8z99jz6xJFDB/4f7cJAHED90F/LXvrF0vbSQ8uPn3KO+2
         ugeqW5jpc0U3/g192PEdKRxfkaHj96FhupsLi/0FHrm20fBHmFOR+Vr2sa/C4QMMFnwo
         a4EH5FIBfyp6OFfwmhA8J6Bcdo1UNodaW8atMZ6ruZx67568mH87FIgSSZ9ITlGctbJm
         zLPJLwGJhlJ1VY4EfZetpfL49e2/PqdwaTUWj7+pK4AIorUfpcukbKwZgRx0oaNcSkO0
         iJFm8jgryEswO7+Cx8iOi01qFihAjYWrfTsgcQeCHj817i1lBT2zZF5SMPQdKjEhzGne
         gVRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBOPuTUBENIrpf2uK0/6Rksjqk9RYu88kQqI2QwcFWzqXqI4V4hRgyNCq8mq6f+tgCTkWQnfobuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nLVhwd84XeIpjzye3xxsCSvP5AZew0+BR1eZsEzwOgTM0bumkR
	UpGYu2Nbc7RXUeB5s8wsBoVwmubKCpZfXaiGGQHshqPN57m0U1GJgKt9
X-Gm-Gg: AYBFou1E9qNoFtVwPGHVPb86mnlwNYHJc6eiEM+MEdjYVOBxQGZF+4LqJzKA+5OG9I7
	lBXsyO2YXwxpScOXDYeZemfpO+VRARDM+b4OiuolP6B4uhqPctOF2DIHvRCSgE4gz/OWhR92KHF
	Op7hBwfj8Bh2qX/M/JmrPMsY4RSE28B52YNaK/M+MhzBASnH3BMO3GrSiWFJ7ww/970XhsaftVh
	QvYHZOukd2e8XJ76wvp1vfWCO7g44ylLC0Ch9HCnpkW2QAyqdrCtlKgH4VyBFoCPWRlUZKnqwpT
	fwJetLNz0+UK1RJ1CR66PjWY98VedPr19zlXTEb0sN4CGFfa1I5lPAmFy72YLj5MqOagg2UDQP6
	G6aUi3v9/gFr5g5QrxXBrI/FqbiSGiqghTgMmk8p4Y/0lR/68pcIXuef6hMXbtP/x6xuk3C5MyK
	T0JFJqFb8uANQE3XxD8te+CG5JtFcfo02DkKqvO0Yf1PMp9HZxOSw6OYJfLX03ZeF27R3rNPzkx
	GANoPGzU14=
X-Received: by 2002:a17:90b:580e:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-39d9bbe47a7mr25597954a91.3.1789311622706;
        Sun, 13 Sep 2026 08:00:22 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 08:00:21 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 9/9] thermal/drivers/exynos: Select thermal emulation support
Date: Sun, 13 Sep 2026 20:28:37 +0530
Message-ID: <20260913145905.9404-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145905.9404-1-linux.amoon@gmail.com>
References: <20260913145905.9404-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select THERMAL_EMULATION when EXYNOS_THERMAL is enabled, as the Exynos
TMU driver provides thermal emulation support.

This ensures the thermal emulation framework is enabled whenever the
Exynos TMU driver is built.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index e1e8035d24fb..7d5590f78185 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -4,6 +4,7 @@ config EXYNOS_THERMAL
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
 	default ARCH_EXYNOS
+	select THERMAL_EMULATION
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for Samsung Exynos series of SoCs. This driver initialises
-- 
2.55.0

