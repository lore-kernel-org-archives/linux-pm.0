Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A0394788
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240354; cv=none; b=dnNlKd0SiCMVZLb7WyF6L3r830YMcxgZ3Tg8hLc9YgwDpUE4+EVy87OcO3OUFzrQy4J7hj5ce5p/H2GueS476w3PzxKFySnA0oBsF5nYsY7FuPXT9z96fpWkx4GrP0gsLhUkzNwjOnJ02+BNqKMi8Z7Nye9qn+jt4Y4bVJV2H7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240354; c=relaxed/simple;
	bh=HR71RBZu/09n4yHrzzixKqkYtfz1HyNns5gTwWCUaXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P73L9BHEhxJDr9Zy3RX0qVtGBDJRUMT7JWpvAG1gqeAlRp86seB5IY/L2d2UF6D9G0mlQVEBYyYH61qoVInrQo1OZmPKXDFTW8//h3cVSNm9oGRok+37X4zNwvRxMa0u7avdNneFKXB1iC9ESg0kdyzJE787j2D3gOhhp1LajGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdAT0VMN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdAT0VMN"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso931206a91.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240352; x=1789845152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UabZ98vj5EdaCQmaHDWkq9sH/9g2g8pmLq50Cl5sxiU=;
        b=fdAT0VMNUuUL1nyM5RH81Xay6oNeM+XaucvaFIProyNr6WUNrpqhuMoRz2nt1I3P6+
         TPUej33ANAyvei3e8Ee4C89GdEexMB+PLnhwp84XGGGhpduytSge8uEQR1TCXhS6mPrg
         vJ9rteRiTl7HtiuTFcai7zprwZy65ksZPnCq2e3oS2BkX/4ZBup1aG/27ig2LNwJRdjN
         cy5eblnHORhgR+Q4TXARaHQBg1eFPDF+Ht8flhsPKIMNkPhqxMztRM0E66i6N86gOjXD
         sHc8iWV5B+sEg++m0wyz+wEERX9W9C4H7Cuo+5xaDKWvW3NPW3G7I9MHMLfXbJ9pGqBB
         h1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240352; x=1789845152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UabZ98vj5EdaCQmaHDWkq9sH/9g2g8pmLq50Cl5sxiU=;
        b=NN4XIWFCBJNK4eIUCFgyAjYGnS4OMs3kot4XFgKMxUuuqFv9IqjpBkcW8Ayw357F4O
         35/dIfb/xVyuwfMssgvOtZ3/I4idT23OeyWnIZt7NRb+GE6O9p2Il5PuT0hn1CXdJY7S
         sfz8t65EoNOmxbKy5quvG9STJ0pVMDSpFik/ETpYtYkxhXo/c/bcj0r0hjgoM/82iB0K
         Ya6MYxckNE2Rb9FN2S/opmENTAL/xSPuePsy/1mGeuevelKulljCFeT8TiBD2FapW+sj
         GyHedBPEAqMytuSetEumbepDxrkc91jDAyw8BTJiQO/x7E7p9OVJq2kr1JyOjhwJhaoO
         w9ww==
X-Forwarded-Encrypted: i=1; AKwUvByEDpagC54sPjDnU5DaF83AJW+qd9yRTlQbNxlJ8oCcOZ546ZAOW1LUPUBZqqO9E7wFAvwgVMDOZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mm5tQCwoQRro71O5tkCU9dnAz/x05hqeNbR8BcdqINj6O5p78g
	eoeLvrbUZLOyKfh4N27HdWBBu5jbvNT0dT7krxsh7OFYiU56QC6DH3uQ
X-Gm-Gg: AYBFou3Es/+MJoI7cQz8262vj6KauN1LPSlsxeflcno3oiWIAbCIU02GVjtmokCeNjI
	z04QemFBS+WsWtQ1YlLh+ZpNYMzRBO3vrC5atMOcKYvudMcdAGzWtZWQoxnfRMTM6wLYyvTA2Ja
	RI5u/JKQOZc8nukZgO6yy22KXBQcwONvdu7G4QmlmUAHlahPgW/Y7OPJtyA/op3M0zFV6Bumm2g
	rqqrwkSGILyET+TUhYS5GgtKr4J5u5i3NJx4wXOQgHewG6/H0Y/waHZ1yfqvZecsH/JZwCH+4iP
	3LJXZlXwszbnt90jUUVsK8x8GGv3hsb14Ya94Vqkb9EVwXmjzmO2kv3gCA+QJfEUi0wlVHg3tMz
	XxiETV5EEvPGbNGA50TFt081nr1f5A/xSfa5Wrj1hH7jDIpEXx1aoa9PljRLR4sWM2tollR+FwI
	8+AeubwoGFEHdRg8apIKcO3QKxZVR63oQszsUkl1sYtSFAWOhuG8jXoVs8Ggrbe3gtKIad
X-Received: by 2002:a17:90b:28d0:b0:398:9bd4:d18 with SMTP id 98e67ed59e1d1-39d9c3f2ba7mr19386123a91.23.1789240351619;
        Sat, 12 Sep 2026 12:12:31 -0700 (PDT)
Received: from gmail.com ([58.84.61.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm14722239c88.3.2026.09.12.12.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 12:12:31 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	krzk@kernel.org,
	amit.kachhap@gmail.com,
	daniel.lezcano@kernel.org,
	thara.gopinath@gmail.com,
	talel@amazon.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	mmayer@broadcom.com,
	viresh.kumar@linaro.org,
	sumitg@nvidia.com,
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
Subject: [PATCH v2 1/5] power: Use %pe to print error pointers symbolically
Date: Sun, 13 Sep 2026 00:41:51 +0530
Message-ID: <20260912191156.185448-2-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912191156.185448-1-sumeet4linux@gmail.com>
References: <20260912191156.185448-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace PTR_ERR() and %ld/%li with %pe and pass the original pointer
directly to dev_info(), dev_Warn and dev_dbg(). The %pe format specifier
prints a symbolic error name (e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME
is enabled, otherwise it falls back gracefully and prints the raw integer
value. This makes messages more readable without any functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/power/reset/macsmc-reboot.c        | 4 ++--
 drivers/power/supply/cpcap-charger.c       | 4 ++--
 drivers/power/supply/intel_dc_ti_battery.c | 2 +-
 drivers/power/supply/qcom_smbx.c           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/macsmc-reboot.c b/drivers/power/reset/macsmc-reboot.c
index 9fc36fa68676..7b8460a55e9d 100644
--- a/drivers/power/reset/macsmc-reboot.c
+++ b/drivers/power/reset/macsmc-reboot.c
@@ -221,8 +221,8 @@ static int macsmc_reboot_probe(struct platform_device *pdev)
 		if (IS_ERR(cell)) {
 			if (PTR_ERR(cell) == -EPROBE_DEFER)
 				return -EPROBE_DEFER;
-			dev_warn(&pdev->dev, "Missing NVMEM cell %s (%ld)\n",
-				 nvmem_names[i], PTR_ERR(cell));
+			dev_warn(&pdev->dev, "Missing NVMEM cell %s (%pe)\n",
+				 nvmem_names[i], cell);
 			/* Non fatal, we'll deal with it */
 			cell = NULL;
 		}
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 34a57dd5c3cf..d423a8bdc0c2 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -808,8 +808,8 @@ static void cpcap_charger_init_optional_gpios(struct cpcap_charger_ddata *ddata)
 		ddata->gpio[i] = devm_gpiod_get_index(ddata->dev, "mode",
 						      i, GPIOD_OUT_HIGH);
 		if (IS_ERR(ddata->gpio[i])) {
-			dev_info(ddata->dev, "no mode change GPIO%i: %li\n",
-				 i, PTR_ERR(ddata->gpio[i]));
+			dev_info(ddata->dev, "no mode change GPIO%i: %pe\n",
+				 i, ddata->gpio[i]);
 			ddata->gpio[i] = NULL;
 		}
 	}
diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
index cb6fa8d88b43..5819df23a543 100644
--- a/drivers/power/supply/intel_dc_ti_battery.c
+++ b/drivers/power/supply/intel_dc_ti_battery.c
@@ -349,7 +349,7 @@ static int dc_ti_battery_probe(struct platform_device *pdev)
 
 	chip->vbat_channel = devm_iio_channel_get(dev, "VBAT");
 	if (IS_ERR(chip->vbat_channel)) {
-		dev_dbg(dev, "devm_iio_channel_get() ret %ld\n", PTR_ERR(chip->vbat_channel));
+		dev_dbg(dev, "devm_iio_channel_get() ret %pe\n", chip->vbat_channel);
 		return dev_err_probe(dev, -EPROBE_DEFER, "Waiting for VBAT IIO channel\n");
 	}
 
diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 67fdb4335338..c8e242341d04 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -613,7 +613,7 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
 	}
 
 	if (IS_ERR(chan)) {
-		dev_err(chip->dev, "Failed to chan, err = %li", PTR_ERR(chan));
+		dev_err(chip->dev, "Failed to chan, err = %pe", chan);
 		return PTR_ERR(chan);
 	}
 
-- 
2.43.0

