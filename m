Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAF399CE9
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788675544; cv=none; b=qNkt+Jj6Fpau2iEcokWfgrRbwLjiM4oJJGTSfEWocDeIdeFqmueLQKyJZMSjQGlQDn8oy8Mti0OMybLUmzYxXU4nTIjoEBlLwdzRS58u4U2hOCN/CDbhUKFN0fzbNaRk6psPLvZf7b6RDvdFczwg+UCqIHLepAH9nKTtxjsnKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788675544; c=relaxed/simple;
	bh=YrTo+zdkKpV5+yJvFwK8zA6/u2dpSvDVFjumOIdiThw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE/i6IEtH27gEE1x6fSZrOMUdRj6Nmzq6G6LYmsveIsGZj9m8aqSyHKzSt7YiYBizGLjvUPqm3JpBDF/Hj2cIWy7f9xtgT2W1Fn6tCu3Qo1x0CAQ2RtUfaXuSo7GjHC16JClR2IJtFeuh+X9sBp8AksN4fw/1K72jAW9+MsEiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gsb0OBvW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsb0OBvW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1921772a91.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788675542; x=1789280342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P29HLotgsQWEFXe03chzciCUSFMzhS7FgdZp0wCdfRQ=;
        b=Gsb0OBvWZG5hgVnCleCwk7SOind03/0P5yIBjOZlwk3tdqZ9VRFGrw5VNEYXB7D8lo
         S+eZ3CZKusS1w6z2fZwAHgeG/fHZOS94pjpjrXVlSjtGHMnl2fMnKmDGW0KIXgAAyr+V
         kh6OQ4TY1DzFWgAusyAyzsJa39WE85etLpowMGs/01n3Ay1hiV/yLyQbnaE51C+G0+we
         W6xhQpvByD+UoNlaPDZ6x7IPjgVljha/1KWJngM/bcqoignSu7uzO/C5VQkUK7bH7GFY
         iiQ6ulUOy1b8vzIevMETXYSsLrFNYRFYHHD84km2AI3j95iPlQY5/q/ZCiEz3HwJhXYi
         E3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788675542; x=1789280342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P29HLotgsQWEFXe03chzciCUSFMzhS7FgdZp0wCdfRQ=;
        b=nFVVrGzsezAOALLKNA5O3re2R4LaqMObhHfqS6/IKpqT0a1iB1Z/KnTvo6n1Hjuwps
         ebTUHfhtTrx4Qdt5z19gk9tnMC1tEGkHf8W4JhJ+ZB67RAq+ttF8fDJAQpvfu0VqQglA
         5tHoZw3B7gazwS/Z2FVLsoN4Y1h56xYNLmgur0Vhx9tX3+s3EUA9jUVM8V5yLKBK3cc/
         1Nz2lZTc3KMi8RiooXS0YLvUldj5ax0/kLmjelNVDJ0QrYKXY0To+klRosWMdAl1kjK/
         sBk3MQiBNRr0OTLbwKeCSS9tYczS6HyR3N0yEEQ1UU/UPHvSoqQT0IozWEtToTBQqlbN
         tguA==
X-Forwarded-Encrypted: i=1; AKwUvBzms9tvXP212uJxrpyia7wc4pD205a90nAaABs+wFG5vVDV6YqMRBYKMqWEe44SxZBKpiJgxLKKiQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kueWp4sAKIUg6F8QFLvi0H85wWYlktp6dowZ4tlkEEUhVTzYVW
	fXy7/INZv0153J5GZQa8PaT9UjT+eKe1eUKRE+x9EkUvNG6aw6xpC/xu
X-Gm-Gg: AYBFou3hkxJB7cIUDB7Su3GLBsDoPKbV3V/zOcoHzJwQKJotmOTri/lNaTQEZj2sZMf
	0bTMwNljKhjJL2CU1OKl2SkA6YowwiDb1jvJbvkJc10m0cA/3tiaThbv4PfSrDFD5m3Yu76Jq6P
	gd2rnpgv4QYriDVyV6B3FgCMSo4I1Wd6+RKpgBcZlRmAUg50QcTkz+vkhjwWWfbW2wYPHCnKNKf
	SOh178qOh08l2xX6nWkVQc1HJni/ot/bLxUDWP9Q19I2wIIoJkzI1uHRG7AiXFjmf76v80GmIeF
	j8V3rFHvX8DW1Ur2+JJ/1P7j/mNMK7NTvxexNGtYRmp2tWFJQHtBWLsidTqwsz8RMc+T2SJRZXz
	XnJtwctS2t2JLa+TWRW2aaandcDDqXhcyPHZ5UETveOER15n2Q4an9O1SjE1cv2ugf1PpKCx/sN
	X/Xcy3zisjkk7vXOzE/PI8LoqlaTtoSDYtqK4Ww9WjGAkvRbxLTrQrlfNJw2c=
X-Received: by 2002:a17:90b:2f87:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-39b261e75femr24578243a91.16.1788675542370;
        Sat, 05 Sep 2026 23:19:02 -0700 (PDT)
Received: from gmail.com ([58.84.62.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm18280405eec.12.2026.09.05.23.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:19:02 -0700 (PDT)
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
Subject: [PATCH 4/5] devfreq: Use %pe to print error pointers symbolically
Date: Sun,  6 Sep 2026 11:47:53 +0530
Message-ID: <20260906061755.5103-5-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906061755.5103-1-sumeet4linux@gmail.com>
References: <20260906061755.5103-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
to dev_err(). The %pe format specifier prints a symbolic error name (e.g.
-ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled, otherwise it falls back
gracefully and prints the raw integer value. This makes messages more
readable without any functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/devfreq/imx-bus.c         | 4 ++--
 drivers/devfreq/imx8m-ddrc.c      | 3 +--
 drivers/devfreq/mtk-cci-devfreq.c | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 49798f542d68..dba76d8b9e5a 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -75,8 +75,8 @@ static int imx_bus_init_icc(struct device *dev)
 	priv->icc_pdev = platform_device_register_data(
 			dev, icc_driver_name, -1, NULL, 0);
 	if (IS_ERR(priv->icc_pdev)) {
-		dev_err(dev, "failed to register icc provider %s: %ld\n",
-				icc_driver_name, PTR_ERR(priv->icc_pdev));
+		dev_err(dev, "failed to register icc provider %s: %pe\n",
+				icc_driver_name, priv->icc_pdev);
 		return PTR_ERR(priv->icc_pdev);
 	}
 
diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 52beeb5b7d65..28d7c595fa17 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -340,8 +340,7 @@ static int imx8m_ddrc_check_opps(struct device *dev)
 	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
 		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
 		if (IS_ERR(opp)) {
-			dev_err(dev, "Failed enumerating OPPs: %ld\n",
-				PTR_ERR(opp));
+			dev_err(dev, "Failed enumerating OPPs: %pe\n", opp);
 			return PTR_ERR(opp);
 		}
 		dev_pm_opp_put(opp);
diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 4c22be728f6a..bda788909887 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -364,8 +364,8 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 					       passive_data);
 	if (IS_ERR(drv->devfreq)) {
 		ret = -EPROBE_DEFER;
-		dev_err(dev, "failed to add devfreq device: %ld\n",
-			PTR_ERR(drv->devfreq));
+		dev_err(dev, "failed to add devfreq device: %pe\n",
+			drv->devfreq);
 		goto out_remove_opp_table;
 	}
 
-- 
2.43.0

