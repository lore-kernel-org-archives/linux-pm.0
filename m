Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BC3E16A0
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105726; cv=none; b=KPjRqL10lijTmHGlBt890QIjdrnIvLA/lMePmVeYE+PghJpNRCPbC7C40pW83qHhBtQug3+xXRJhcGyAmCnSqe6MJNLB8BMh4Zz0kpbDKaeII5eeYuT1vxJ4ts+54oaR73YWQSHqLDDuI+ffnOnjTAlneXLeC0JBr/0s4Oq/Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105726; c=relaxed/simple;
	bh=S9qazdwnsr1QgW0osAkaYIzoucgKhcC+gdhN23cyZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuWrtxgzt7hVZIRzUlLdeyQuYbfBn/d2tOfIbjdk0PcVbKK64cxscrFhoLh3JciKl51+cKl9YtEUYzoqQbred/jyhzV/LUcQjBrnsXHCyIVOJaiAK5ntkEx85hzmUt5/RkqW6lbMA4Y4o3ofjWiD4FMhAKDG3p1Tb7l7PqJQvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJdH6aVp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJdH6aVp"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1501482b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105719; x=1784710519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R59ctZio0nbgqHRQ4JYecMwYKlS4svhcqsOXKq5o7ro=;
        b=UJdH6aVpvcxq7poyI7pN4WpXDbtvcjl3Gajb+p9bZ6Mf/iN6Sdnr+pTkawsVmtCQHb
         bGJa862wQ9cnUKRTEH0Cinkm2kizRGy/Eddyumaw1Xs56rf+w/u3mdMv9VSJeMGdEfg5
         x4S4qLZHFMDhDY985fB1VxdVAC9CQT4uawi1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105719; x=1784710519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R59ctZio0nbgqHRQ4JYecMwYKlS4svhcqsOXKq5o7ro=;
        b=TAQxpaZsIPzG+f1/9TWBtjBzYTqSlGWGJzbrokqGfZdNbRLYL6DlsDvcNDBZhgFxWS
         eD7IFyxZlbg40/NcP/PGejs88P3HmOW2ipQFCufzj6HvMzO8Q161R438ZQPfe27ZoQeW
         VxWQa20mXVLTmUYw7Vm9GgF6tPVINmDaYIHo/c57hEoQEu+YsbJjQxvA9GjzwUmLShLp
         msBmVhFeMUzy2YfIbIJTDUcm+CXY5CS43LWlqBzFjds/nyGuG1YGx8DL3Lt7A0X9+iv2
         JdRm7Z2wSkudMjPQGYtHN/WQJB0Z2AuHy9SrHCRowm+3FIcPJBE0jaJ2Syqs9DWa3nG6
         mwAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRwqEeIyBa1QxXay9TzoLmseaEWK5ueUylRQUerPib93XZZ2I1j2jbvkVhOzlFig0pZe1r2Cp4mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3ccgLxVLrI4YIf3XXeKK+DYg1iytblBVvW2tY63GJqp+VupM
	WwRfJL8kQ8YlzjqKNzwZjroujL5tl6zS44VTr+lIJwLtz9emMgdkGEoM2q0X5l/bww==
X-Gm-Gg: AfdE7ck7gqdH03nLmpw4+cEV+EJbQxW+ub6tn7gBptcoKBqCMV3rTxQ8578JOMFLqyY
	SqkVDsFQLOZ6M3VUpSQxZN9dpLSO+6j1b4VXKdTnjyJ8q/txzB7s33L451NCdsyeX8xTvQKRGEg
	2kyjCGXJs1k1yEfyaZaVS87FoxFziDXh/r1uEpUKOk3X8g+R3TPUs2EgGjezX4MIJTNCfWiascz
	pSSjTN2Chnm6aGpL0Zqfui+1p8OueBptsdA7DcuZfeW/DmrG1ikwcR/+Gz1scqOiy3JF07up+Tw
	OppCquO1v/u0gOc6L0qaG9PlzNKyOXnCYVaMGLVk2ky008InUoR8oEFNgXfAOI/hzrgeui+m4zC
	lXmaJdZHAeVoqrnLvdHCmVP1Jf+ManQGcO27fZxnKKDvywxxfSDbLBlzFN/oobKHtFcXzUL9xEr
	kV1s93st7oDmHn5v1foloWvcCBt/4NCfgmM3A52w/t9vvzXNKyrfQWAA+2RUXJPWU4vnx/MA==
X-Received: by 2002:a05:6a00:ab8a:b0:848:48e7:437b with SMTP id d2e1a72fcca58-8488985bd87mr15890965b3a.69.1784105719486;
        Wed, 15 Jul 2026 01:55:19 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:55:19 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 13/16] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Wed, 15 Jul 2026 16:53:43 +0800
Message-ID: <20260715085348.3457359-14-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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

The "unit" names are internal to the power sequencing framework, and
should be confined to a single provider. The names are only
informational. Dependencies are tracked with pointers to other units.

The "target" names are the strings that the consumer uses to acquire a
descriptor with. As these remain the same, existing users will continue
to work.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Expand commit message
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 691cad0a6dd0..693b0d33f8cf 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -69,46 +69,46 @@ static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
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
@@ -130,13 +130,24 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 
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
 
@@ -147,7 +158,9 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 
 static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	&pwrseq_pcie_m2_e_pcie_target_data,
+	&pwrseq_pcie_m2_e_sdio_target_data,
 	&pwrseq_pcie_m2_e_uart_target_data,
+	&pwrseq_pcie_m2_e_usb_target_data,
 	NULL
 };
 
-- 
2.55.0.795.g602f6c329a-goog

