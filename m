Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DB3D0BED
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132697; cv=none; b=jlBl4k3sQUQOo1wLeY6r9UU1lFwb39peZP23ZKIC9n9AxgCh1euxkFXrW5dD/ozltoOlyB5/0MARsrYnwXv6W394iWzxc70RUzISAVMD9euk14u0yx+OoQTcgMnn0vU5jObbAYGDzXT324HrIFdkd8JX3rCOK9Xh97PN3ej8Unc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132697; c=relaxed/simple;
	bh=7wG9Ljo/wLQuUSFyuvqM5SlTjkxmEhtxmQbgpLCzXuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwgWUGMm/zEy3y4wcmd1cnN/ywj7AJbISZhEAfzqor+5fLbRWQR7vPYR4enin1elRggnT+9JUmjJ1tVcRcOlCWKthnRRLuhZ6+k6D86szSuqjGrRO1g+RPxEeX56GLlXRZmNw+44JFvcgfhLPmgIZ/AN42BhurLmqUw8pSaS+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV525KoU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV525KoU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso625005e9.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791132692; x=1791737492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NP4InVw4ZvTsXvnaGIApv16AhZMv/UaEABA2B83Ciew=;
        b=PV525KoUXzx0DE1Myx3pRxTRSvnUKDVXmrKbiBb4tSdxBVHOMS1Kstx30He8HkruKy
         UNB3or6NsDHzpRVLekX316sW4RtsDIRlJvVh6hVLm/Dofm1Yj1qcXYgYUEp+bY7piWOM
         ryuwflz0/CfryUbTVTTgBQaru5mAoaHPplMT4EihXPRgq0iKXaP30eyKmpRLByLr7oZG
         5b3SzvmseEJ+RBbkmIuohSIhx+E7BVEv5L8fJOLGT+nVoaXlP4zCp10U8VX/Tmb76Odc
         25Qs5dbYncwzqS6Nc9BF0LZi3zhHKSvFlWe17+lSt6XNaggK29I/xFTj5pjKkhd3AATS
         v3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791132692; x=1791737492;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NP4InVw4ZvTsXvnaGIApv16AhZMv/UaEABA2B83Ciew=;
        b=JtzS7PiVxkFLXyHnOY9H+3gYUhQ+p3u+gR+jFsNQJkt0BJzRjtVVO/ZP456ZyYG6Li
         8R6GOR1T4Z3koU+5Y1IpH3/8b7kzgD5opuL3/tz7+iH78YuMBTqrK4TFtnbd/m34HEGe
         1LsMM0togsAKqHkpm1yz9ClW2ltndypI+ZfjiJsU8YRgPw1CK76xSXuezKApjUr+n0cM
         WS23ayhPfJHOGyFP/5p6BhOO13OhkaqkqBI5GZoBbeVaN6ciJz1NzqY3hpVv1WMHY3sl
         I1nO3WZOsv82jsr82VNzEPJ3fU3toXxp1Io70etqUxmxQhbdMACSBawH8zQT4gFj3L1C
         kjAw==
X-Forwarded-Encrypted: i=1; AKwUvBwp5gRlEw+kq0IpXNzXdcB3I1c5EAkXkqmTeOP6GMV6toXqAglB9HdB3lYIqxgYbO+lP0v6s2csuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kFRQK1DdTKZ6QXee4AQJKgj2e0tZLmRYhkgE7X2cJn7y+Laj4H
	iRekpyQC5woZqhJnKSqrsv31GTk3JeMeBFcIXnFWel+2xKIppfDozrbC
X-Gm-Gg: AYBFou0RGp5jK1g+IOseutfzOJeWIkcvt02f/TogqxyBNkav/va1SL0h0v7Sm85XGiu
	8SvbXlL4iJx6Rk1NqlzLLDdTk1i/i76Vd2PUOSN6DluM/Fw5GaYL+t8wXjrIaU4WYnHKPmSvo3k
	Z6YHTysTfXUKI+u8TTkKwVPVei9gg/QZ8jManaK+DA3iMnc4R61pyGw8vl3q65kYJFu+1MFYUmh
	7niwY/Sr/0bzflMQw7EF8fqdoBer69ILyzqnrFxZgcVWocdCNNwAwR/kKPh25fesZ0sVtX7ULl7
	G8QcFuBOlbdqEgcJqdjIodQxFHqSUJp1nt3qqk9vgpkEvaCEhM2gdb2jc6VEg6ta7+Dezu7U/S4
	HxiJn9MJ8SJDxMP2HOhFLpMr4ZOU2sg9HEwMtz5lrmYhSpfH7/YFL3UoM0y9kQN6m4ZMyGKPjcS
	UX1bbUQD8QlTyOHEaLwI2uIll6UVX3Qf3Wk2kNlrLvdGG+6yj3uVLDpxcH4NxRkzPu7PnwgBtsa
	G4l8rAoaC0=
X-Received: by 2002:a05:600c:698d:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-4a1680e5865mr77354445e9.14.1791132692261;
        Sun, 04 Oct 2026 09:51:32 -0700 (PDT)
Received: from FranzSP11.fritz.box ([31.31.60.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027725c6asm311375035e9.8.2026.10.04.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:51:31 -0700 (PDT)
From: =?UTF-8?q?Fran=C3=A7ois=20Roux?= <franzelfranzel@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
Date: Sun,  4 Oct 2026 18:51:24 +0200
Message-ID: <20261004165124.4277-1-franzelfranzel@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
current level, so that a WLAN module left powered on by the firmware is
not switched off. The FIXME explains why: toggling it would take the
PCIe link down, and the controller driver could not recover from that.

That reasoning held while the PCIe link was trained before the
sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
powers the endpoint through pwrctrl before it starts link training, and
defers until the pwrctrl driver is bound. That driver cannot bind
before this sequencer has probed. Power-on therefore always comes
before link training, and keeping the firmware state is now harmful.

On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
bound, the host init is deferred about ten times, and each attempt
powers the PHY and controller back down. The later power-on only sets
a GPIO that is already high, so the chip is never reset and the link
never comes up:

  qcom-pcie 1c08000.pcie: Device found, but not active

The endpoint is not enumerated and ath12k never probes. Bluetooth on
the same chip fails too ("QCA Failed to send TLV segment (-110)").

Request the GPIO as GPIOD_OUT_LOW. The chip is then off when the
sequencer probes, and pwrctrl powers it up cleanly right before link
training. Drop the FIXME and the code that preserved the firmware
state.

Tested on a Surface Pro 11:
 - b921aa3f8dec plus a one-line version of this change: endpoint
   enumerated at 2.4 s, ath12k and Bluetooth working.
 - next-20260929 plus this patch: "PCIe Gen.3 x2 link up" at 3.4 s,
   ath12k and Bluetooth working, Wi-Fi connected.
Without the change, neither kernel enumerates the endpoint.

The culprit was found by bisecting v6.17..v7.1, with the DTB and
.config held constant.

Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: François Roux <franzelfranzel@gmail.com>
---
Changes in v2:
- Sign off with my full name.
- Use the Assisted-by format from Documentation/process/coding-assistants.rst.
- Add a Closes: tag pointing to the regression report.
No code change.

v1: https://lore.kernel.org/all/20261003091451.4727-1-franzelfranzel@gmail.com/

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 7f88a29b2..636dd7e63 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -526,15 +526,8 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
-	/*
-	 * FIXME: This should actually be GPIOD_OUT_LOW, but doing so would
-	 * cause the WLAN power to be toggled, resulting in PCIe link down.
-	 * Since the PCIe controller driver is not handling link down currently,
-	 * the device becomes unusable. So we need to keep this workaround until
-	 * the link down handling is implemented in the controller driver.
-	 */
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
-						 GPIOD_ASIS);
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->wlan_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
@@ -545,13 +538,6 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->xo_clk_gpio),
 				     "Failed to get the XO_CLK GPIO\n");
 
-	/*
-	 * Set direction to output but keep the current value in order to not
-	 * disable the WLAN module accidentally if it's already powered on.
-	 */
-	gpiod_direction_output(ctx->wlan_gpio,
-			       gpiod_get_value_cansleep(ctx->wlan_gpio));
-
 	ctx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ctx->clk))
 		return dev_err_probe(dev, PTR_ERR(ctx->clk),

base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
-- 
2.56.0

