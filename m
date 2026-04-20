Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45703A7580
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706816; cv=none; b=X9k0LolmRs9NhTQZiNUtgNERTNQuAVZPw9jnUZgv7YUegmWaCojTpfWlamY4B8hcZfX4+WKbyFv2w5l2K2XuHDtuHEF/2yDFhP5T1KbKoYkk0DpvB3z5i8dHrFUfiNqX1q67VxTbv3py2LYuTZyY+yUencldVa6r/3KJIMMNmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706816; c=relaxed/simple;
	bh=WKLGUtHcCNyB75a/mIe0Fi5jZUq9xL1obF/iPOKGPO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmghrRX2UNc6vVNHxWbKprDRLjy9rfz0YfIpvPZyulp7MIukXYEhgpUJ24TGRqlVp/ofqwjItcZFWYg7Xi/VyJi1EUmbvEJ1A79wWOY/0dSusZRnpNvppXN/EkzFczD1NrnpOxtyV38bY7li7wX7n6KgnkwyNF7D3Th8nPqarj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHQxB6IQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHQxB6IQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so33961305e9.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706807; x=1777311607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQZMf3eIsjFVRWF3sE9lpUJLt72fcFn9iR6RKZYiOCs=;
        b=pHQxB6IQCIrDn+3pfFpg/Jcabfmo/j2yJ+1pmIcj4QHNjvlaYXBU6Qr5yL2/hgrvdm
         sDJ0dRDMvVvy/cd/xc8VkvMaKc9synXKZ147S1EOH6mxQQpOU6o8am5CBRfzBsjAV9Rz
         Dpg9tiZDepiQNzq5Jd5qOUEsowTwfMfguKRhjBunjIOlXSbrLEfwLvleSJpgssx85VGm
         fGgyMAiScZBJt2luYFTtv5iQFuA6SpEMhjHAhptyE5C/+rs+G5acrAKsFObe1FuQL0V2
         BgxJCoRs+PrQYYm3DGYRIk7En5F/t4rlIMAiBcX7KDzJ0KYLGZOqk28WDvWqATJPyCJo
         zd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706807; x=1777311607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQZMf3eIsjFVRWF3sE9lpUJLt72fcFn9iR6RKZYiOCs=;
        b=ncwmyit+4kFv2rZRFz8XcccJR0a6Vn9Nuaw/qHh8VEaAnKUg+tT4A9JY+B/Xclkb/j
         nArJ0o++ZaQ24/gyBn9Hg2vfgct1IrIv5vNV9eKPMm45dt+acwJ0P6jlX5ejQvnXOZXA
         8f1e0yNVHvF9U9NQ1YBAVKZyv7ZRt3RytGJGPeFdouh0g0eDisk03gwV4FqlnCRUyuu7
         yMUoGI3iK6wLxoJg4ye8/OyDpNTHL8lN2eDY6vGtswYEc3/j67XJHoDoArK/gyka3Lcr
         S/YlVyRYrgCgFZwcmXbpF6wc9O42Emu0wttrFa1WCM2bLXQcW/AkqAY8WzKHcaCmjNT7
         hZ+w==
X-Forwarded-Encrypted: i=1; AFNElJ+ZpGLL98xwnWoJRuc5Y7rov/ST/EmnsUzZGBlFeAjbuHYxIztARa8WbBodxVLK2Q2TYRzuDcS6qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ENYOWAYykmwwAtL8CiFit78An78DbsI3rmKE0PyInhOIaJLD
	H7Ijb5XavFDu8KIHYcCdLmXmEuia4Lf+wnJ/3Bc7rOHDO6tERy/X7+wYrr+YZtCzeLw=
X-Gm-Gg: AeBDieuu4pgfhKjudu5/fl/x1lmBUOORp9FeQADQqC3qJqJGmanesPTIdQ5DH276i4/
	eRprDFDkCXr7QrXAp9t+KNKN2pQJEomKZV/hyfH76ZnpCdRO7R8wvqxkoL6mJvHO7d9JzxHJI39
	uDMo+kS+ZXpJB8CrVtdF5oaXoqDpF5gAou30J0a+o4d8zGdgbpwBdDPq34ylZoIXEV51WsKvKHR
	rkNv5hghHNIjYS3AlJNKBlniAx1HacPDZyAMxLXiSwkjf+Gj8M+0HJVnK+PiFCOd0HsIMkImvEU
	R4ZrNJxYB8vIP40J2qQBiqL7oCeinPTTRFf2GjuL1mmRHiJIdqD4uNfhEch0f1H9WU1yiKUqNFD
	j/JhDjUEzJyv4R4jnzjptv7xBTl/GZ1QshOVaM34Irlc3AsFbqHWRvyHZi2imkcv3d3bguk7YRY
	slfH9DmLM9FUHhezUvpU2aKcqkFrS77nqAgSPFvQyH88Or6VJf5266oHBva183HjteTXW5lf12f
	UqYGkRKwmzmqmFMmw==
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488fb796fa0mr194800345e9.25.1776706806875;
        Mon, 20 Apr 2026 10:40:06 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:06 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:48 +0000
Subject: [PATCH v3 02/10] firmware: samsung: acpm: Consolidate transfer
 initialization helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-2-3dc8e93f0b26@linaro.org>
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=6621;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=WKLGUtHcCNyB75a/mIe0Fi5jZUq9xL1obF/iPOKGPO0=;
 b=ytLvdkH0V8xD4mIf4tcLZpXLnSbLl/4UU3zbh5ud7q3fmPRkdRuj8JAUqTQnvZ4eRLJtHyGFE
 59M1NRPpitpBmHv1QMuyFz62NbxsoDC/uwHQG7F+8TLWYZIAMDziI7M
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Both the DVFS and PMIC ACPM sub-drivers implement their own identical
local helper functions (acpm_dvfs_set_xfer and acpm_pmic_set_xfer) to
initialize the acpm_xfer structure before sending an IPC message.

Move this logic into a single centralized helper, acpm_set_xfer(),
in the core ACPM driver to reduce boilerplate and code duplication.
In addition to cleaning up the DVFS and PMIC implementations, this
centralized method will also be utilized by the upcoming Exynos ACPM
Thermal Management Unit (TMU) driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c | 17 ++---------------
 drivers/firmware/samsung/exynos-acpm-pmic.c | 20 +++++---------------
 drivers/firmware/samsung/exynos-acpm.c      | 23 +++++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm.h      |  2 ++
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 06bdf62dea1f..7266312ef5a6 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -21,19 +21,6 @@
 #define ACPM_DVFS_FREQ_REQ		0
 #define ACPM_DVFS_FREQ_GET		1
 
-static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
-			       unsigned int acpm_chan_id, bool response)
-{
-	xfer->acpm_chan_id = acpm_chan_id;
-	xfer->txcnt = cmdlen;
-	xfer->txd = cmd;
-
-	if (response) {
-		xfer->rxcnt = cmdlen;
-		xfer->rxd = cmd;
-	}
-}
-
 static void acpm_dvfs_init_set_rate_cmd(u32 cmd[4], unsigned int clk_id,
 					unsigned long rate)
 {
@@ -51,7 +38,7 @@ int acpm_dvfs_set_rate(struct acpm_handle *handle,
 	u32 cmd[4];
 
 	acpm_dvfs_init_set_rate_cmd(cmd, clk_id, rate);
-	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, false);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, false);
 
 	return acpm_do_xfer(handle, &xfer);
 }
@@ -71,7 +58,7 @@ unsigned long acpm_dvfs_get_rate(struct acpm_handle *handle,
 	int ret;
 
 	acpm_dvfs_init_get_rate_cmd(cmd, clk_id);
-	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 0c50993cc9a8..f032f2c69685 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -58,16 +58,6 @@ static inline u32 acpm_pmic_get_bulk(u32 data, unsigned int i)
 	return (data >> (ACPM_PMIC_BULK_SHIFT * i)) & ACPM_PMIC_BULK_MASK;
 }
 
-static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
-			       unsigned int acpm_chan_id)
-{
-	xfer->txd = cmd;
-	xfer->rxd = cmd;
-	xfer->txcnt = cmdlen;
-	xfer->rxcnt = cmdlen;
-	xfer->acpm_chan_id = acpm_chan_id;
-}
-
 static void acpm_pmic_init_read_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan)
 {
 	cmd[0] = FIELD_PREP(ACPM_PMIC_TYPE, type) |
@@ -86,7 +76,7 @@ int acpm_pmic_read_reg(struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_read_cmd(cmd, type, reg, chan);
-	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -119,7 +109,7 @@ int acpm_pmic_bulk_read(struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_read_cmd(cmd, type, reg, chan, count);
-	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -159,7 +149,7 @@ int acpm_pmic_write_reg(struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_write_cmd(cmd, type, reg, chan, value);
-	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -199,7 +189,7 @@ int acpm_pmic_bulk_write(struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_write_cmd(cmd, type, reg, chan, count, buf);
-	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -229,7 +219,7 @@ int acpm_pmic_update_reg(struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_update_cmd(cmd, type, reg, chan, value, mask);
-	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
+	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 16c46ed60837..8b2529e50328 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -463,6 +463,29 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 	return acpm_wait_for_message_response(achan, xfer);
 }
 
+/**
+ * acpm_set_xfer() - initialize an ACPM IPC transfer structure.
+ * @xfer:	pointer to the ACPM transfer structure that is being initialized.
+ * @cmd:	pointer to the buffer containing the command to be transmitted
+ *              to the ACPM firmware.
+ * @cmdlen:	size (count) of the command.
+ * @acpm_chan_id: mailbox channel identifier.
+ * @response:	boolean flag indicating whether the kernel expects the ACPM
+ *              firmware to send a reply to this specific command.
+ */
+void acpm_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
+		   unsigned int acpm_chan_id, bool response)
+{
+	xfer->acpm_chan_id = acpm_chan_id;
+	xfer->txcnt = cmdlen;
+	xfer->txd = cmd;
+
+	if (response) {
+		xfer->rxcnt = cmdlen;
+		xfer->rxd = cmd;
+	}
+}
+
 /**
  * acpm_chan_shmem_get_params() - get channel parameters and addresses of the
  * TX/RX queues.
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index 5df8354dc96c..3d8e33040444 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -17,6 +17,8 @@ struct acpm_xfer {
 
 struct acpm_handle;
 
+void acpm_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
+		   unsigned int acpm_chan_id, bool response);
 int acpm_do_xfer(struct acpm_handle *handle,
 		 const struct acpm_xfer *xfer);
 

-- 
2.54.0.rc1.555.g9c883467ad-goog

