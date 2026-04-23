Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326636CE1E
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957792; cv=none; b=KVl5G5THL/oAgUQO3SaRJVn1ULOm9dXJDuLV1QNT3ZrjkiGQuCsHIDl5qW53fdsyc9ZjYBkDqShadkBwxvljEdI6Z8ulAo0W8zj+O27QcY1onFSJb18w3HoTr8HUgA1bIseFejHgUt2wDSJw/ixoC/xvtp8pGBCcu0NlAknHB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957792; c=relaxed/simple;
	bh=yeIM1tygkcAJHD4Fuo6dYmfGw6Kjwz0lWPb9oCpXElA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOytkR4MVaMdKQrqOgxJ0ZxyJqeaMCKy+luMHOGQC4Qla9apd+22GlDDMz53ycPyqzLqn/ZCAysfW61uVtbSa1jK3+BSsFfEMSlIbMPPTDrXzCvQ7eK78zkFc+6Uz2eiIP9EG/3WTNfuBbaBRxygUM7g1KBKKepbc5DYnYX9QrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ap1dPu9n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap1dPu9n"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso61413865e9.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957783; x=1777562583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUbgzZSjuFhpqCOcKnUVLASDnnm/oM22X9b2CDF2EUE=;
        b=ap1dPu9n7AztdTHxjYnmxQkU62x07yaPNuef0me9Pq9kpHElQfHZslAhVb2ycQhxW/
         geOIc2lv5+1r1S//QnIOI4T7Clr8YEnjw6me2tWYMICGuNgYquTUXhMTSE6Skw0FDsea
         jtobTq0UhxEtVanNeR+/3uRjyk5Vkt1s6CNVWF/Tt8lB/WGk72sBcEBXAiAk9bdP4/vJ
         rXSBXmnqACn58CR1kuR9G8/zkLMJ/dOkPvf1QET1LD6DsgVS7oqtTvx5C9vLGlw6VNC5
         B9z5znMLHf0hGqxWdEuthmR3udF8rEOE7YmMzqwWNLPzVPPXZnQPQS+nQLniCPr28WuC
         l1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957783; x=1777562583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUbgzZSjuFhpqCOcKnUVLASDnnm/oM22X9b2CDF2EUE=;
        b=Mij0ONOxcJIe56g9Mok735LsR8hDUlDYo/qossQ1tiMamSTx8Qg4WmGyBKkgBkwWF7
         lf5VzIDb+dpqb1081Bykmq7bxD4Ljrr9dC+NYT79XSQd6nn/YBrEOzCbRh0VsKF1kY4I
         fVJxgyCsOv9bQOKhG65PbsrncYOk8Vcwatwf8ppIN2Ye2b661iVblRuZ2YenkTN7fZ2C
         IQjVGy2CV9Wa4GxBdLrbZ8V5q/942KWvYZk9iZkcEfc17bo3z4j6eAdt9T5me4kz0G+g
         do2siPbZInVpMScFrwdNxj8ywI1HCIP6HKJYX0n48NAl6VUO7VsyC8fuBwNopMa3RlTM
         HJ6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/AAKpg8EW9QKwKLYS/wsH9esTyZcpLJGR9BC2YUfVINd2WRSXfVyc/YfGwHYlEYtfl2pM/Qu3tZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlhGsfNZxB9A22zohglc7S1OEHkE2XeLNyePpLRUQbzdmFYlNk
	0UKQMbgO53+aWL/GKUVlWK03T1sh82muaGtdp2V9e7NuoyfSs25ZmNhiYO9MkY1K2Uc=
X-Gm-Gg: AeBDies6NsKHK5Fkd1lzYALvxPosEelNqKY969O6vfu3JEZiNKNsoEt6vVSVkbx3+Ff
	CGknobFbIx/9UM4vfLLFQ0h4BWrFCI0bWBiTzDZ2BUBQqWyCJepa9ifQdJiKSaEV0xSBBwO9pRs
	I3GEJytbXB9yL/PsWT3n9wnMH4CfEg5EB9b2BW9cryVXessdrx904nGvjWRdBL5cG6S6Lx84Ji6
	R15LmUTvz7byaRQpMsdVRrI0vH5+gQYNoOZ3bDNMNk1qhdc8IfHs5dpKLia/3X2k9ciyd4u+bCS
	8khlrfiEQJxR8d7kuhEUizg5fVujPAi3S8fgQeg43TXbXxEXo1S80zxzZsG2zo9/J8FVUh+WbVW
	5x0EfXzCIwR6mKqEusFrKeQr6qHAdcB6R4ltE3GBEf5ryn+q4/tOGhr8PhLW4tpIyraQvcM0jpX
	/5r/yFpy3TbYjTYAiC5GvNO9mljphfc1KE35GD/Q217LcnobR5Jorqw3hqMMPIMejl59xuNmekx
	IGKoKePNFI13uc8bsQjaddPQOe6
X-Received: by 2002:a05:600c:1c29:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48a55743b73mr190127085e9.16.1776957783102;
        Thu, 23 Apr 2026 08:23:03 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:02 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:54 +0000
Subject: [PATCH v4 06/11] firmware: samsung: acpm: Add TMU protocol support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-6-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
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
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=10617;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=yeIM1tygkcAJHD4Fuo6dYmfGw6Kjwz0lWPb9oCpXElA=;
 b=Qn7QvHP6vi2y49sjroBwBKcwegyoEouE8Snb4n3cRYs8Q3PM/1g7nVcIGcSeTVqZDQDEmEYpO
 OVoyGYQ2hFdApUfOIff6JCW5i311p9AWSVx9nv9oMVwePGyJhsbKVlO
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Thermal Management Unit (TMU) on the Google GS101 SoC is managed
through a hybrid model shared between the kernel and the Alive Clock
and Power Manager (ACPM) firmware.

Add the protocol helpers required to communicate with the ACPM for
thermal operations, including initialization, threshold configuration,
temperature reading, and system suspend/resume handshakes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/firmware/samsung/Makefile                  |   1 +
 drivers/firmware/samsung/exynos-acpm-tmu.c         | 240 +++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm-tmu.h         |  28 +++
 drivers/firmware/samsung/exynos-acpm.c             |  12 ++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  18 ++
 5 files changed, 299 insertions(+)

diff --git a/drivers/firmware/samsung/Makefile b/drivers/firmware/samsung/Makefile
index 80d4f89b33a9..5a6f72bececf 100644
--- a/drivers/firmware/samsung/Makefile
+++ b/drivers/firmware/samsung/Makefile
@@ -3,4 +3,5 @@
 acpm-protocol-objs			:= exynos-acpm.o
 acpm-protocol-objs			+= exynos-acpm-pmic.o
 acpm-protocol-objs			+= exynos-acpm-dvfs.o
+acpm-protocol-objs			+= exynos-acpm-tmu.o
 obj-$(CONFIG_EXYNOS_ACPM_PROTOCOL)	+= acpm-protocol.o
diff --git a/drivers/firmware/samsung/exynos-acpm-tmu.c b/drivers/firmware/samsung/exynos-acpm-tmu.c
new file mode 100644
index 000000000000..7d9b75be032c
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm-tmu.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/ktime.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "exynos-acpm.h"
+#include "exynos-acpm-tmu.h"
+
+/* IPC Request Types */
+#define ACPM_TMU_INIT		0x01
+#define ACPM_TMU_READ_TEMP	0x02
+#define ACPM_TMU_SUSPEND	0x04
+#define ACPM_TMU_RESUME		0x10
+#define ACPM_TMU_THRESHOLD	0x11
+#define ACPM_TMU_INTEN		0x12
+#define ACPM_TMU_CONTROL	0x13
+#define ACPM_TMU_IRQ_CLEAR	0x14
+
+#define ACPM_TMU_TX_DATA_LEN	8
+#define ACPM_TMU_RX_DATA_LEN	7
+
+struct acpm_tmu_tx {
+	u16 ctx;
+	u16 fw_use;
+	u8 type;
+	u8 rsvd0;
+	u8 tzid;
+	u8 rsvd1;
+	u8 data[ACPM_TMU_TX_DATA_LEN];
+} __packed;
+
+struct acpm_tmu_rx {
+	u16 ctx;
+	u16 fw_use;
+	u8 type;
+	s8 ret;
+	u8 tzid;
+	s8 temp;
+	u8 rsvd;
+	u8 data[ACPM_TMU_RX_DATA_LEN];
+} __packed;
+
+union acpm_tmu_msg {
+	u32 data[4];
+	struct acpm_tmu_tx tx;
+	struct acpm_tmu_rx rx;
+};
+
+static int acpm_tmu_to_linux_err(s8 fw_err)
+{
+	/*
+	 * ACPM_TMU_INIT uses BIT(0) and BIT(1) of msg.rx.ret to flag APM
+	 * capabilities. Treat zero and all positive values as success.
+	 */
+	if (fw_err >= 0)
+		return 0;
+
+	if (fw_err == -1)
+		return -EACCES;
+
+	return -EIO;
+}
+
+int acpm_tmu_init(struct acpm_handle *handle, unsigned int acpm_chan_id)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_INIT;
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
+
+int acpm_tmu_read_temp(struct acpm_handle *handle, unsigned int acpm_chan_id,
+		       u8 tz, int *temp)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_READ_TEMP;
+	msg.tx.tzid = tz;
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	ret = acpm_tmu_to_linux_err(msg.rx.ret);
+	if (ret)
+		return ret;
+
+	*temp = msg.rx.temp;
+
+	return 0;
+}
+
+int acpm_tmu_set_threshold(struct acpm_handle *handle,
+			   unsigned int acpm_chan_id, u8 tz,
+			   const u8 temperature[8], size_t tlen)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int i, ret;
+
+	if (tlen > ACPM_TMU_TX_DATA_LEN)
+		return -EINVAL;
+
+	msg.tx.type = ACPM_TMU_THRESHOLD;
+	msg.tx.tzid = tz;
+
+	for (i = 0; i < tlen; i++)
+		msg.tx.data[i] = temperature[i];
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
+
+int acpm_tmu_set_interrupt_enable(struct acpm_handle *handle,
+				  unsigned int acpm_chan_id, u8 tz, u8 inten)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_INTEN;
+	msg.tx.tzid = tz;
+	msg.tx.data[0] = inten;
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
+
+int acpm_tmu_tz_control(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			u8 tz, bool enable)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_CONTROL;
+	msg.tx.tzid = tz;
+	msg.tx.data[0] = enable ? 1 : 0;
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
+
+int acpm_tmu_clear_tz_irq(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 tz)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_IRQ_CLEAR;
+	msg.tx.tzid = tz;
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
+
+int acpm_tmu_suspend(struct acpm_handle *handle, unsigned int acpm_chan_id)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_SUSPEND;
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
+
+int acpm_tmu_resume(struct acpm_handle *handle, unsigned int acpm_chan_id)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_RESUME;
+
+	acpm_set_xfer(&xfer, msg.data, ARRAY_SIZE(msg.data), acpm_chan_id,
+		      true);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_to_linux_err(msg.rx.ret);
+}
diff --git a/drivers/firmware/samsung/exynos-acpm-tmu.h b/drivers/firmware/samsung/exynos-acpm-tmu.h
new file mode 100644
index 000000000000..8b89f29fda67
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm-tmu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+#ifndef __EXYNOS_ACPM_TMU_H__
+#define __EXYNOS_ACPM_TMU_H__
+
+#include <linux/types.h>
+
+struct acpm_handle;
+
+int acpm_tmu_init(struct acpm_handle *handle, unsigned int acpm_chan_id);
+int acpm_tmu_read_temp(struct acpm_handle *handle, unsigned int acpm_chan_id,
+		       u8 tz, int *temp);
+int acpm_tmu_set_threshold(struct acpm_handle *handle,
+			   unsigned int acpm_chan_id, u8 tz,
+			   const u8 temperature[8], size_t tlen);
+int acpm_tmu_set_interrupt_enable(struct acpm_handle *handle,
+				  unsigned int acpm_chan_id, u8 tz, u8 inten);
+int acpm_tmu_tz_control(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			u8 tz, bool enable);
+int acpm_tmu_clear_tz_irq(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 tz);
+int acpm_tmu_suspend(struct acpm_handle *handle, unsigned int acpm_chan_id);
+int acpm_tmu_resume(struct acpm_handle *handle, unsigned int acpm_chan_id);
+#endif /* __EXYNOS_ACPM_TMU_H__ */
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 38f40fb67ea7..655b80fc635f 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -31,6 +31,7 @@
 #include "exynos-acpm.h"
 #include "exynos-acpm-dvfs.h"
 #include "exynos-acpm-pmic.h"
+#include "exynos-acpm-tmu.h"
 
 #define ACPM_PROTOCOL_SEQNUM		GENMASK(21, 16)
 
@@ -639,6 +640,17 @@ static const struct acpm_ops exynos_acpm_driver_ops = {
 		.bulk_write = acpm_pmic_bulk_write,
 		.update_reg = acpm_pmic_update_reg,
 	},
+
+	.tmu = {
+		.init = acpm_tmu_init,
+		.read_temp = acpm_tmu_read_temp,
+		.set_threshold = acpm_tmu_set_threshold,
+		.set_interrupt_enable = acpm_tmu_set_interrupt_enable,
+		.tz_control = acpm_tmu_tz_control,
+		.clear_tz_irq = acpm_tmu_clear_tz_irq,
+		.suspend = acpm_tmu_suspend,
+		.resume = acpm_tmu_resume,
+	},
 };
 
 static int acpm_probe(struct platform_device *pdev)
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index fbf1829b33db..08d9f5c95701 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -35,9 +35,27 @@ struct acpm_pmic_ops {
 			  u8 type, u8 reg, u8 chan, u8 value, u8 mask);
 };
 
+struct acpm_tmu_ops {
+	int (*init)(struct acpm_handle *handle, unsigned int acpm_chan_id);
+	int (*read_temp)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			 u8 tz, int *temp);
+	int (*set_threshold)(struct acpm_handle *handle,
+			     unsigned int acpm_chan_id, u8 tz,
+			     const u8 temperature[8], size_t tlen);
+	int (*set_interrupt_enable)(struct acpm_handle *handle,
+				    unsigned int acpm_chan_id, u8 tz, u8 inten);
+	int (*tz_control)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 tz, bool enable);
+	int (*clear_tz_irq)(struct acpm_handle *handle,
+			    unsigned int acpm_chan_id, u8 tz);
+	int (*suspend)(struct acpm_handle *handle, unsigned int acpm_chan_id);
+	int (*resume)(struct acpm_handle *handle, unsigned int acpm_chan_id);
+};
+
 struct acpm_ops {
 	struct acpm_dvfs_ops dvfs;
 	struct acpm_pmic_ops pmic;
+	struct acpm_tmu_ops tmu;
 };
 
 /**

-- 
2.54.0.545.g6539524ca2-goog

