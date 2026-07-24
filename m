Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53093E6DE0
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882719; cv=none; b=VKk/5/n65AGVYB+8S20Tr7Q8SfuVTmbXIWy/HA6St9FfJwUaTn001tggj6JONiG4J3VKI91jqjkTUpHhRk2UnaWlZA3kSM1b22Sz29lbmvl8ijAt8eYvbz1IsYu/nQvf8Qm7Y7j1Gqf/aq7jzrzWHMxdG0oDrOkZG2ONkJJwRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882719; c=relaxed/simple;
	bh=2bdpJglUXNu6BBTggJFiuCLLgE+aHPv4Z4H92NilTHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrRb8CPDxWJxUGwHGj0T/piQxJZ0qN413CwbjtDeHrheAP2ZN7BIAU9uObrgMs4xwwSIzH6nVSUltsEQjlYrgyW/9yPhkYiSm8au1f2Ng3b0KIXCWRVmlMqnZlKBgVaQe8DJwnwC0u2UogkMr3TEjCXsAM8lq6cdVfggxP0rYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fBcHxtBD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBcHxtBD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso138380a91.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882717; x=1785487517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPhOqCEBzv3eJgxR2FHq6mhzbCgxaYl9KnF0Ou483ms=;
        b=fBcHxtBDYDTinFEZmdfv8EXfL/aqfTCX7skCt+kf1t7650ZuFcp3pbAa5jdtaDy56M
         HPsMQ5C0nwrwRD3c+GPOJ66XhMmxlQrMik+UrHqboVfMNcLiUB9go7f7BqMYPrIAX8w6
         5E2NLpEf/b3fGwjkQ4e9I7qV0JAxn4W1Qn/nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882717; x=1785487517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPhOqCEBzv3eJgxR2FHq6mhzbCgxaYl9KnF0Ou483ms=;
        b=E2k/NI/awzD6ayC1VKVEYSE+/9Jq+rSSuLFIfiGwTBttKWlobav/0d/3y+6FiZzQyG
         z5MSGCuj4n1ImA6eDW759KflU4WDb+D6JkSLdZf83VN+z8zvva0yvXIUTfFIKl1UhclZ
         gObGXFDRNHloh9Oqnt7g/lnUXVv8GtWWTz3AeGBskFMh1uCNQqboHVs/xQZkOWAGUb2p
         P/H0drvzycwq10NWkv4ZbYEJwoaZRLCQCLDjnXyvFBGps0yFYuBPXA6l9lNvx10LC8s+
         LVwKbsvdIS4ZQR7bCfT8O3V4bmcFjTrExfeudKtDf2wuaIxF5iwxTWlMabMobg7UuTIG
         rkyw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/OB/AA0/fqPbkDXDbnmCqly+P4OS0HYaEzwLLSFkE7LHFNwxv+ePItkqr6cNIcfu2z3jL365BDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdSUORrJ/z9/+gAVGvib4bSGQlr1zPXkn4brEWRP8RKNXcN7a
	mKFblRTYE9H3FU4Ng1vrYE0xNM4TcWvTpVXBmGV46CX00uoE+EUGLqC+R6cyPeY7eQ==
X-Gm-Gg: AR+sD11frbX3XO7+Cc9bB7n8a3w2eItqYnwr51R0CysqQZ3vXqBZma5ESfzfNPyAikO
	vfOAe/0foeWvweRtoPI8OYnULdsx36lgj7CrFcNQVjfiT1QS1IPdhGs43z+fD/WiZMIHrUDWpY+
	auC9Oq0b/GNQtbImVrjXKqAenjtYAind3hAQUKJKlnaK8KP3Z//zTelQ7Rs3EN9HSDmGUT7gj/i
	uexi3hCauxqgzeKxSYdH3dP+EvtvuXFq221QVXBWSHie/R8DyE4MGctImCrNRl4aXIhcDa1/U7Q
	A7ffC0rX8NoxXOUBlwvlhzzr74svoQBSCCzz7QajAXICOmqz7bIFHAavZ+PxoXVqzdrdBPlbhtM
	Eh7UVRL8xqj2Rja1Y2tftkRqr8Ghva/jP+8sakGyafZwnz+jJRmNBPhKDZY//JuRu+rvLBQFPNo
	03QE1GGZgxDoU2sd+ZxJbq3sYYNvI02C2QE6YBQVZo007s76J7jS7uEHNyxbk=
X-Received: by 2002:a17:90a:d64c:b0:381:bc4c:da5b with SMTP id 98e67ed59e1d1-38ec6985236mr6392312a91.18.1784882717037;
        Fri, 24 Jul 2026 01:45:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:45:15 -0700 (PDT)
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
Subject: [PATCH v7 14/16] power: sequencing: pcie-m2: Split Bluetooth unit based on interface
Date: Fri, 24 Jul 2026 16:43:23 +0800
Message-ID: <20260724084328.3943997-15-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
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
index 693b0d33f8cf..56e4f40e0480 100644
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
2.55.0.229.g6434b31f56-goog

