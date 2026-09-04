Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA243F4A2
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511476; cv=none; b=OARYevrcEQvCp2/zxJ6MomG7TBQY4JUo47BhHA79AN4tgp+sBFCYf6Sdz02N6efbxzMh83AE6k6oeddVHaklIjfhWsYqDTrGbVWlWq9lIoDNt+k1u/1rSP1XnDnIdVRdEt0G4HI7P2tslwZj4LC6/9fy9G5/0Pw3kWTCy8T7Y2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511476; c=relaxed/simple;
	bh=iMNgXmNz+LIwXhN5Tpbg3zFAHcxrNG+nhFvPP6LiEEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDA/4WHIy/0wxi5N4p6bTASUFIt40//fnUphRiUVyW9QzNyF/zJVDQayHF5DZ2ccez/mq9F9P7HLFav5zAbWajubBbYJlBbavxtLqpfDDngLl4elnKTPf+W2EDDwdKCfUzJQUY0EW1cLm/aNozHbMVrRpu51Ei16qW1I526VHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SM8/8je9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SM8/8je9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38511175ad3so656154a91.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511473; x=1789116273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBs9AvV8VgFuyAyigj5QfCqQvbDEoRbP4Si3r+fhDas=;
        b=SM8/8je9k5QR752Ca+9eYmAIadauFZkGm2Z8Tj3NOdWja/SrdSazSUtLOw5jTZAlgw
         WyNxTJacR1mIo+ko5PshEIErmMZW3JG0zQ+bM1FtKgOAumC5NhDPw+BWD+HgWctIhUSi
         5G7d7uTvlhFoJVQkIU1sP4jJhg2gOZYYhvOLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511473; x=1789116273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBs9AvV8VgFuyAyigj5QfCqQvbDEoRbP4Si3r+fhDas=;
        b=qy+u4BjiWf8P8fJ6OaW+0kstuJQptgPJffKbFs0oQrpli7uQJPNHELgDiOjhRWm2v6
         4jLCKU+3Uu+Jka7rEiEAtK86E/tfiosS8CbIVoYSLvLo/dgoE6o4bHsW2z0ZM2I1U4A5
         MJ9NV6dL1Qz4uXlZ3XlWvJz/0v43hkKr4Xx2QOwyFVu0ZNCcmACwwab/FFR7J7CVCEfY
         CJzuN7Ti6CPgtDVE3kEB4wh22KoAuDr+2EpJLhaIDhQxwzXT7DZwynj8dc920PMFz2+k
         6wYYsAzKDCOLT/vv/0RJHW0zD5ya9kFWLM8rb0l9V0boOP/8LXbaCZmmh9arjZ0CxwHr
         k81A==
X-Forwarded-Encrypted: i=1; AKwUvBzeN5GK+uzUAbezAtFpNI2fO74OrZytIGCceQMPGWfNJ/L1YInaoZLHvwRncr0sbNTTDRybHbHznA==@vger.kernel.org
X-Gm-Message-State: AFuF++mDZahi9kzcGK7iG473cwke8Pvvq73EWChHHTSNaQNEEVfbqcdo
	EvJU7BFu2ZuNSDYUlWyU6YQbPm0/bNU9+PJdNQZA6xyvpkShGwLnOPAzGK228viFoA==
X-Gm-Gg: AYBFou1MjSJXLXYKOQFuWEiLlqYzmKYiWJ+hlhoiSXrarAufgV9/jhOxmGDbl9mNZ1Q
	1fdMcNHs5Xaz++OPpAYKTjsTuzd0sPdMO2kFT0VLKxFl0o04IPVDloW4VNt1qnS42aoa8GLUZ4N
	6gdw+HOnUjB5LTxb6G7zEsq+FsKx9tmmcZGFnvON7hWRE33lFyr/OiRIuAvQq6YwzRFuHSzE+nA
	ATWcDucAKeg93ViToDva+BzYPSoEZm/cTpaN7VMTlXeUWzA9J1ZwXB8rrL9+cz27J1/tl2G3Ph0
	dXoFW/yd4e4xi8fnSns2ORnMlGYsWUoKiw7TGCNhd5pXEj2h6bNGRGkDmIEj5FV3nksSL8met6V
	o8hIC1szAkzhFWpo5zYp4rW3ujmTOZzKS4lDUunhMkKVIg2/Uh7wZW7ax2iHR8LDvA8VK3SfxE7
	wRyEI655WmSfJxc3TyfgOzVHLp7bMeXSaaH0hF+jlAekrC85QRhYnyrnAH8UdWjW+O33z0aeda/
	Hs0kzDb0rvZQTgAb1iqSIZmOL/L1RBa0jCjJ+k/a+YW+PIbgadZEz4P
X-Received: by 2002:a17:90a:e18b:b0:398:ab03:95b2 with SMTP id 98e67ed59e1d1-39b26155274mr6523995a91.10.1788511473366;
        Fri, 04 Sep 2026 01:44:33 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:32 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
	Alan Stern <stern@rowland.harvard.edu>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v8 14/16] power: sequencing: pcie-m2: Split Bluetooth unit based on interface
Date: Fri,  4 Sep 2026 16:41:53 +0800
Message-ID: <20260904084158.1341550-15-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some UART / serdev based Bluetooth drivers need to be able to reset the
hardware during initialization or recovery. This is not possible with
the current power sequencing API if a unit is shared between USB and
UART interfaces.

For now, split the Bluetooth unit into two, one for each interface.
This allows either interface to independently toggle the power, with
the last action prevailing, thereby unbreaking the Qualcomm Bluetooth
serdev driver. This is also needed for the Realtek Bluetooth serdev
driver (hci_h5).

Having independent control from either interface unfortunately means
that userspace is able to shut down the controller from sysfs using
the USB port's "disable" setting without the serdev driver knowing
about it. On the USB side, independent control is also desired, as it
allows the USB core to power cycle the port/device during faults, and
for userspace to initiate reset and recovery using the aforementioned
"disable" setting. However when USB is used, a serdev device is not
created, and there is no conflicting usage, which allows the power
sequencing to work even without the split unit.

Suggested-by: Wei Deng <wei.deng@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- New patch

This patch is _not_ squashed into the previous to provide clear context
on the change, and the less than perfect nature of it.

I think what we need in this case is some sort of lockout. The serdev
consumer would want "exclusive" access, locking out the USB consumer,
which can tolerate "shared" access.

Something similar would be needed for the WiFi if we ever add support
for SDIO for toggling the state of W_DISABLE#1. At least the SDIO and
PCIe reset signals are separate.
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 987faa9f3b3b..f7bcc8bb4c77 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -83,8 +83,22 @@ static int pwrseq_pci_m2_e_bt_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
-static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_unit_data = {
-	.name = "bt-enable",
+/*
+ * XXX There are two Bluetooth units to allow either one to be able to power
+ * off and thus reset the controller. In practice only one of the interfaces
+ * is used, so there is no conflict. However userspace could power off the
+ * USB unit by disabling the associated USB port, without the UART unit or
+ * its consumer ever knowing.
+ */
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_uart_unit_data = {
+	.name = "bt-uart-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_e_bt_enable,
+	.disable = pwrseq_pci_m2_e_bt_disable,
+};
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_usb_unit_data = {
+	.name = "bt-usb-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
 	.enable = pwrseq_pci_m2_e_bt_enable,
 	.disable = pwrseq_pci_m2_e_bt_disable,
@@ -130,13 +144,13 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
-	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
+	.unit = &pwrseq_pcie_m2_e_bt_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_data = {
 	.name = "usb",
-	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
+	.unit = &pwrseq_pcie_m2_e_bt_usb_unit_data,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
-- 
2.55.0.979.g7e5102b832-goog

