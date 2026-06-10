Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F03B71AC
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080930; cv=none; b=hWMq1AUyECTecr9I9h8JN8YReNq3i5TBdDHT7y03S1ElqB7v01f9DYs3B7wo7+DZCotNX8kJ5+xlGM8nP2fpd9HM6Sfc6u8xT3C2/uuBWmZAGnMiBbM1OCzZMNJ7KkWdG5g3InMyyYw//sR9UMlwCUUq5zFneKSaMKMaIv/83+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080930; c=relaxed/simple;
	bh=aM1pKeD/Vxy8p9xU2vujlhCyS6zAz75iUguBLngP3eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qspwqVbZF9MHN0zoCHInTvffSpUpI8ICSm4E+YqTXShkFXH/Vf48jpu23FrUwZ2/3/UU8vDgtPvD7mxWARQPE8hN+zIw0OTBD9rwxaehkvXD22pEGg3JCS5O7vro+mX+L6Opv4kk7QPSAUO+rFAd42e0VnrCZWw6ht4wwViA3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZGtxGeTW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGtxGeTW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf30d530bdso65051935ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080927; x=1781685727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oapuTl40hgb4G5/aDuwYBQkElchJu8zWsaiRUCi5VkU=;
        b=ZGtxGeTWVkEhm8vRhk7ZwKL5GOx9IYSy0tZ7f5lnYaPkWbzRGH+OI52sh7yr9pCvsK
         Luy1k9lx9C1WzeOlPW+AqxWDNesdcA0vlNv4r3VxQb2omFc30ytH9g4d4ICW3VZ4qTOD
         bIcq5XXczNjACDlTfTvq/BSC7YwNR4rJex11A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080927; x=1781685727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oapuTl40hgb4G5/aDuwYBQkElchJu8zWsaiRUCi5VkU=;
        b=PNaCFWv30zpU6yPvo39pSJAugoLU+xAu8XlPEd5iKNuyLXGECVt1qpJN+mhYW3wB63
         IHoZ1n3F2oHWbk6OH6wdghu+CNk4rsbVJJoMhY4M8q7Ei6X0skF+weFwQ6nQ6YU7LCte
         5yJh/9RPH8v/5LHriAwCQXWxHonPJ/Ri3YbhLc3D2sKWlQ51m93uvAyWms9+kQAM4DU2
         qalCTKY9qRgYSMr+cuaqu/kN4S+UEnx60VtHjDX6NJsi8GzBujtDOwMyprKPZJ7NnhWy
         4oggwTUPurmNNnduulByc+XFK7X31liswSwv4mZBGsU/rzPIoWGyT2L/5gj0PNtmVYvj
         sHoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/98V8NrP87mq7QQC7LFDQcYq+S7W/zMuyR8EQ2HCVIqSBh4WEPZQaF71aqCcTSnV/wE/fum/oPlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+Z7MN1alRq+mzc38ayQJkBkVSdmxc8uS7dCnrwG0wheRrs2l
	4tDb7O/UX1tbsAm7hG5c0+srlxGnrGR1PeNv4lxmJ4Dr0L7VQG2G0b39pV17TUXsNw==
X-Gm-Gg: Acq92OHYyZ/nmT+YOfGvvfhXHRrTlBJuEqkNpUs/ZpwCE9nLDvun0rg/XeGR9iBquiO
	6XnTfAr0iKuens9PFs7lyyz27Rq9YL9BF0yyNmOB/CQQpZAToAULOMXt1Tn3ZI6eVnPT1GR9ydJ
	0wwT5nOBFaivcdWrYsXv0W5mnGPBIJMrrC3Cfkozii1y+1Tlx5yjQjd4OhylyuvtkshLi3jEzW7
	uUoJFUe6+Yzmh8igED3NEcLReitnJFmgK6EvwKupN2P4htAAS64dUDuKnHmhKhozZyBv/xNJ20b
	lv6mFj5boK30phWVKn5NzzyA+PPol229kyd9IrmW5sKtDOPOby03v6BgXqXpLbV1wLggOrQq/wj
	0qg2+0tdydjrpfY050LE5rvRzJV5T2ftuGmW3yU+KHfRsNyGyPWMvEAJmmgXQXvfnhGWBdRDXMY
	0tWP83ys15c16U7M6rHbRwzVXcGz6+F9ip2YsyJMop5r+kxno6GNt2o6RAYk7MW3fMVZVcUuWkL
	z53eAMp6V5iXaXpMA==
X-Received: by 2002:a17:902:e5ce:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c1e77d145fmr269724115ad.0.1781080927559;
        Wed, 10 Jun 2026 01:42:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 11/16] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Wed, 10 Jun 2026 16:40:45 +0800
Message-ID: <20260610084053.2059858-12-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
UART for BT. Currently the driver only supports PCIe and UART.

Add power sequencing targets for SDIO and USB. To avoid adding a
complicated dependency tree, rename the existing power sequencing units
"pcie" and "uart" to "wifi" and "bt". The existing target names are left
untouched. The new "sdio" and "usb" targets just point to the renamed
"wifi" and "bt" units.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 49293376956b..a21a3dbe8a5d 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -70,46 +70,46 @@ static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
 	NULL
 };
 
-static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_bt_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
 }
 
-static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_bt_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
-static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
-	.name = "uart-enable",
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_unit_data = {
+	.name = "bt-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
-	.enable = pwrseq_pci_m2_e_uart_enable,
-	.disable = pwrseq_pci_m2_e_uart_disable,
+	.enable = pwrseq_pci_m2_e_bt_enable,
+	.disable = pwrseq_pci_m2_e_bt_disable,
 };
 
-static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_wifi_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
 }
 
-static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_wifi_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
-static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
-	.name = "pcie-enable",
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_wifi_unit_data = {
+	.name = "wifi-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
-	.enable = pwrseq_pci_m2_e_pcie_enable,
-	.disable = pwrseq_pci_m2_e_pcie_disable,
+	.enable = pwrseq_pci_m2_e_wifi_enable,
+	.disable = pwrseq_pci_m2_e_wifi_disable,
 };
 
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
@@ -131,13 +131,24 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
-	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
+	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_data = {
+	.name = "usb",
+	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.name = "pcie",
-	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
+	.unit = &pwrseq_pcie_m2_e_wifi_unit_data,
+	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+};
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_sdio_target_data = {
+	.name = "sdio",
+	.unit = &pwrseq_pcie_m2_e_wifi_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
@@ -148,7 +159,9 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 
 static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	&pwrseq_pcie_m2_e_pcie_target_data,
+	&pwrseq_pcie_m2_e_sdio_target_data,
 	&pwrseq_pcie_m2_e_uart_target_data,
+	&pwrseq_pcie_m2_e_usb_target_data,
 	NULL
 };
 
-- 
2.54.0.1099.g489fc7bff1-goog

