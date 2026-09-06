Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E843128B8
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788675495; cv=none; b=p6XeRUfv5laKCpfYlAq+LxogBSIkUfki00Jw8DyUsZdJhn9n1THBeachHMPp1ShshujvfJrjNo2JpgXs7Z7CmX7VdsjHfcprG79B+t/Gg2Oc+4S+S22GlB/SzuitCBPmy4HRURq/K/gM4q3uhIfDB+Sfi5d/ZtJTFzbz+cOfSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788675495; c=relaxed/simple;
	bh=xJ/1fdf2VHcAZoRO8dB70h+8smMnxhwjaZxtxBrqS3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5Xlbr4mxWHqBPptys4fm38rKMNuj0573mjJ80OhtxaVuA/7oSAKF85NHEaJTNuOei1Lj+tqQjx1e9vA32hTuYYVydODRr6TLxo5kXCDHe4aOtn51/fpFPSfIP8JfQjBSpn7/lqoDX84IJRLTE80kvFP10lwm6iG7snPAxmotS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOlv7tS2; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOlv7tS2"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so2621097a12.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 23:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788675492; x=1789280292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LOZ87VM/gxx5gotZR4qRLft5D8wWY/6G46t9t21bw8=;
        b=mOlv7tS2XWt/kbXh5VhCrrMHo6JgR+ck5xw3sp52fmgmhltGg3VahV+VZyR9HMKVmO
         QQTmBgWCfFLkKCx7QuBhYWHMVO1yE2EqD8aLOLRgiFEABeV5vVUn/Drn/0AvhspxYuii
         Vxua7AHD/G8JR9YwSPdm4AGdFxO7CS4SuQ8nV8Zp3Zq9uWK9P43qHNPc77vdpyW5Ef6K
         DnTJgo1ScEMvHycfTy1fB1C6whkzVy+Tb31OPeSYseF7cp3G8czQG/APEKSll5BMJ7Cw
         Wcozx4+jbOqNUaLpN2f0g36VrmuGd1NZkJ8bhCSbvS+JgoZAhiRTNZkx+qYMrHLYhw8b
         rEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788675492; x=1789280292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LOZ87VM/gxx5gotZR4qRLft5D8wWY/6G46t9t21bw8=;
        b=XmcgLT3ySlz//vTrjA19Bhe6aelPYfSZBWdGl7lm9kTlfGpyg7yRyT+5HjGadHmgcc
         wCYpXkHHmE569q6pLdV1awJx2gkHH4qIHRUaeNFE2+38S5tueBSuInhfztjgoWYtpp5m
         UriP3xLvkuMvJwLtnH3g0onxhrdrf4bkY5Y8qKDZSehIc3omDTX3qw7RUtTwcbssBAOA
         KJonDLAhVP0P4D4K61tqGaokg9cWRbhHo3nO4iZB3Kr29ACbrpKrc07Pi2yFEFLXh479
         4BXmPH4LYPrlSL+EuqgAupz9npJNe+OhMY/8tD8S0gmUfTDNOo8FNAmLFhZvqDA9e/97
         5kyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBcshJaYfkeITNUvUIhsC53k4569xXaUhgHGABvw/iSTBTbzY7j8A3rUzfEJAWQgZA2lZTW5nJGw==@vger.kernel.org
X-Gm-Message-State: AFuF++mWorOEKTKlfHm+rjsnP/0jazTjMKfFtPDhh5ADfc39Iz9VF15X
	I3fervtwbynvusH1Ce9hfNzRkG0C1zLLENWxcHGWhWLTqRdRe01ivX7u
X-Gm-Gg: AYBFou01lnk5mskAZw80io1FfCb9hAnd/qgza25WT3a2X+RiiEZDL5r5LEwqhbquceY
	VcnkaThjOw/9UwQ46pcLZihmlTMZAVR2mxrjlE4svVH9E2GpumhoQPrdw/nQGIyo/N7wsn/xysy
	cjR7aDS+AbLMhXSJ0u4bkRjVvsX+QO52S/JLSNGeGPjJScafsnPnVy0sNIXcNhgn7PEcWwPxip6
	exE1HOh/YaGmhsTFPv6Z/l2EuyhjvVnP29b3Lg2agxXJfdjVpxL4ThokVVSpDSxEM7egA9FbaaP
	Omtfl6gCAgaeZGS2l65X6PWazxwxtoKzJqL9AyhXpezVgnZLTFgYG6eQiOhHvys7SzTKS5Qy578
	kWWLwpIezrx9HJWY4Hbh+nM0YLXsS7MPV7toyj7m1LcD0+bWmMvAgU2G0HwW+gmYosO1iIOk4ed
	RJcstiWKcJchHR5KgSjfq1cIj9dpvANgyOJT+ffZASkMczXHj27+TDxD7+OgO3
X-Received: by 2002:a05:6a20:9c11:b0:3d2:3e73:29eb with SMTP id adf61e73a8af0-3da39bb596fmr24951780637.1.1788675491987;
        Sat, 05 Sep 2026 23:18:11 -0700 (PDT)
Received: from gmail.com ([58.84.62.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm18280405eec.12.2026.09.05.23.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:18:11 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	amit.kachhap@gmail.com,
	daniel.lezcano@kernel.org,
	thara.gopinath@gmail.com,
	talel@amazon.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	mmayer@broadcom.com,
	viresh.kumar@linaro.org,
	sumitg@nvidia.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sven@kernel.org,
	j@jannau.net,
	marcan@marcan.st,
	casey.connolly@linaro.org,
	sre@kernel.org,
	wens@kernel.org,
	t.schramm@manjaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH 0/5] PM: Use %pe to print error pointers symbolically
Date: Sun,  6 Sep 2026 11:47:49 +0530
Message-ID: <20260906061755.5103-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is a cleanup for subsystems under power management
(linux-pm) that converts several instances of error pointer printing
to use the `%pe` format specifier instead of explicitly casting with
`PTR_ERR()`.

Currently, many drivers use `PTR_ERR()` paired with `%ld` or `%li` to
print error codes returned as pointers. By switching to `%pe` and passing
the error pointer directly, the logging subsystem will automatically
print the symbolic error name (e.g., `-ENOMEM`, `-EPROBE_DEFER`) when
`CONFIG_SYMBOLIC_ERRNAME` is enabled, and gracefully fall back to the
numeric value otherwise.

This change significantly improves the readability of kernel logs and
dmesg traces during debugging, without introducing any functional changes
or side effects.

The cleanup has been applied across the following PM subsystems/drivers:
* powercap (intel_rapl_msr, intel_rapl_tpmi)
* thermal (core, cpufreq_cooling, devfreq_cooling, mmio, etc.)
* cpufreq (bmips, cppc, qoriq, s3c64xx)
* devfreq (imx-bus, imx8m-ddrc, mtk-cci)
* power/supply (various battery and charger drivers)


Sumeet Pawnikar (5):
  powercap: intel_rapl: Use %pe to print error pointers symbolically
  thermal: Use %pe to print error pointers symbolically
  cpufreq: Use %pe to print error pointers symbolically
  devfreq: Use %pe to print error pointers symbolically
  power: Use %pe to print error pointers symbolically

 drivers/cpufreq/bmips-cpufreq.c            | 4 ++--
 drivers/cpufreq/cppc_cpufreq.c             | 4 ++--
 drivers/cpufreq/qoriq-cpufreq.c            | 4 ++--
 drivers/cpufreq/s3c64xx-cpufreq.c          | 5 ++---
 drivers/devfreq/imx-bus.c                  | 4 ++--
 drivers/devfreq/imx8m-ddrc.c               | 3 +--
 drivers/devfreq/mtk-cci-devfreq.c          | 4 ++--
 drivers/power/reset/macsmc-reboot.c        | 4 ++--
 drivers/power/supply/axp20x_battery.c      | 4 ++--
 drivers/power/supply/cpcap-charger.c       | 4 ++--
 drivers/power/supply/cw2015_battery.c      | 4 ++--
 drivers/power/supply/intel_dc_ti_battery.c | 2 +-
 drivers/power/supply/qcom_smbx.c           | 2 +-
 drivers/powercap/intel_rapl_msr.c          | 4 ++--
 drivers/powercap/intel_rapl_tpmi.c         | 4 ++--
 drivers/thermal/cpufreq_cooling.c          | 4 ++--
 drivers/thermal/devfreq_cooling.c          | 4 ++--
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c   | 4 ++--
 drivers/thermal/thermal_mmio.c             | 3 +--
 drivers/thermal/uniphier_thermal.c         | 3 +--
 20 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.43.0

