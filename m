Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565197;
	b=HwvsM+c6E5Ztd+kEpxK3eSHUDLFVT1JstXoi9XmDIHpCngNTqOwty3WG89TZn7NiyJ3y
	 6bnFYi9NEL172PtzLg7qpKAwYSw+NAzJH0CW4DGtbIAdPqWzlAWg6j6I9UuwbEkf7azvn
	 rdYQ8bUqRzKjqM9lz71Q0gYwUdTg99Jt5kgLgrGYt1+d3KmXk3lw9uRs4pC6PfxpHS4os
	 WI3tL/vLF/S/5N318pGkcfDLhzitY7aCtUl3zQZ/HUjuUyz6+Eurj+mis6xki+6+xiBOw
	 YwdMzpdHSmr+le/cRt/UA/iRH1VQ4LmIBLPuTMvsSxvoHjDUDfL08DMi4wQbKJg909w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EwqXgM2FKN08CB+8H4O0/VbJ4ckFqMzW77Fps/c3mB0=;
	b=uY2MwzEoX994zWLWf3NUem+NpMuKOHMEUcxps6dh1zla07OWujVowt90AGU51hec/Xmq
	 dyp9RF/lIn283N8hA3rGniVykGLM3hAYDNewI0/FJHQWQnyOilBorSjOCrkN4WIvURGmd
	 bxzTYTGal7XNysuF8eiNZEMnbhVJgdUyNKlu9JKEog1HiW6zt5CrJLZi5W9mLMHTA6h04
	 K94OeI0b0nraAN/a5yjrRD693BWaYlCcWT66zh5eg3QrghwIUAIVirJ3kCHXkzCA7+Wxe
	 Rfs3jm5N0dOse1bqDfmKLOqNtVezgpU1yljkdmd5Yw0NetXsQ4rmtMxharIPvobQjzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XfvXTVpG;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1042606A690
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1042606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XfvXTVpG
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3863db981d4so7124073eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565195; x=1796169995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwqXgM2FKN08CB+8H4O0/VbJ4ckFqMzW77Fps/c3mB0=;
        b=XfvXTVpGy1YzZ3zEnOAmNLaGkgp8sFFr04vw63nGc3s97S9lTl0vqtfIhIfKDetYmY
         cp087BaoKFQYTrYrITRYyohs39+efC3g5+STFsCp1vLHVJ8tVCsFaoFNJ2XaxfwrZPSt
         ek+KmxYPPEbCMUN3aRMxzqHDxAQHsJer9IrMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565195; x=1796169995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EwqXgM2FKN08CB+8H4O0/VbJ4ckFqMzW77Fps/c3mB0=;
        b=dIfju5r6f9/BTzbMVt6gcCTHY+UKGHGZS9hGq5VMIdH7U5Xew4iL1clWc3XQ2bBWXi
         kg2n33d3+MRQpt9vZaMBLv/JOWxzDrdRIZJ3cUO2MJoYBltW5Ib41ceLeWqL628WwJie
         zdwDOplRTx9qOpoRlJr+kMExRi0OEWP/6Qo8hd/ryfM7L6PsH9Z+nbjvef4sdFA6jxt8
         bS8ikA8nxXer6j415fRg2vjNrmNLmLk8Sj6cpc3+6Ha5IqH42BrWwHvkbz0B+sajHqB4
         zBPZWFjy7CC50M5FUff/7cZdpiXniwg4gBHGqEhEVx2kZokll8UK0aGvd91mRov4SeGk
         8bBA==
X-Forwarded-Encrypted: i=1; AL+hErHpihB/9LC9Kp2xL1Q7gdItz/04ryAy6qVetzNjx0iybCA7+pwt3fmC+XTdJ5nupJCZhzYjy54d4w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8d5gU8Q3/Gy8J/hE+1vQod77gKJU11MtMqnSc74nQ/y9XxIRqY
	iWrvcEJ4UE0eqjOkizw21V9qbZZz0nlt0zVZEvHgUBxUhnre1hKL9bJA2LmwwVW1aw==
X-Gm-Gg: AZFdTZehtpRIdKzHcutDjqIbWV9PVM8WfXmMZJmxNh3olml9UHzwBrteFsAwuAu4QS3
	fiIco0clwLJfHjE32C19KbcNEVa9Qz3YGkhYMpy1Ex6AK5hHGA5mZLQnul5kfynEwbN+0x8npQ4
	iW2yc0TfYlBhEDvYxxQYd2Lff4QhHxD9a7k/qZNP2LTRzGFfjbcI/W7+2xW9L3W54jS4d0E77Es
	CvMssbjFd18WRRplYyYEqEZrQOidCWcH0YsUaYANO0uk/5XheD6Tu4p36TTuo4zz8xkoeCiLM2i
	vVkeao92TInw5cb37YDlPc+JG42xEuJvDnUKO1PF6IUVuuvjuwfTJL5fIt83dbrdT/9K5UURuD+
	R6OGvjPBpGlFOd9QqiFhex6Matbae+VdH/jzKx2V0NUIPLKyoIhbsu7b4vUDzxEp8ubf7Cj6KWE
	5mWrwWhKqkGhu4y+PVZdQP5wZYEAHok8OyuFucC4eItS3EEqQCzZfRLshLr/60UUa3WZC7g+qnA
	hhv8LvhN3P1lcypIE7NfYjmgVTkpG37CucAvqFIuqLH1m6UuHvA57LLnM6mirheifCG3x57kcJu
	iUtCbCeiE8WwhUhPNBKDGJvQTet6xz3PwPOb7YTyqRYME0WGnCXb33hHNeloHmIohS6wwg==
X-Received: by 2002:a05:7301:78c1:b0:386:a3fe:44de with SMTP id 5a478bee46e88-386a3fe4616mr10456351eec.28.1795565194862;
        Tue, 24 Nov 2026 16:06:34 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-38567abb870sm40418219eec.25.2026.11.24.16.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:34 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	linux-clk@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 5/9] reset: google: Add CPM reset driver
Date: Tue, 24 Nov 2026 16:03:39 -0800
Message-ID: <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261125000349.3385325-1-briannorris@chromium.org>
References: <20261125000349.3385325-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Google Tensor SoCs (used on Pixel phones) manage many resources
(including resets) using a Central Power Manager (CPM) co-processor. We
communicate with CPM using mailboxes, abstracted in the
devm_cpm_get_handle(), etc., API.

For posterity, I list a summary of changes made relative to the
downstream Pixel driver:

* Switch to auxiliary bus, as a child of a CPM device

* Use devm more heavily

* Avoid representing each reset as its own Device Tree node.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Rename symbols from goog_cpm_rst_* to cpm_reset_*
 * Moved shared protocol details to CPM driver
 * Remove custom reset debugfs interface and .remove callback.
 * Remove per-SoC table; we only need naive translation of firmware IDs

 drivers/reset/Kconfig            |   1 +
 drivers/reset/Makefile           |   1 +
 drivers/reset/google/Kconfig     |  11 +++
 drivers/reset/google/Makefile    |   2 +
 drivers/reset/google/reset-cpm.c | 154 +++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+)
 create mode 100644 drivers/reset/google/Kconfig
 create mode 100644 drivers/reset/google/Makefile
 create mode 100644 drivers/reset/google/reset-cpm.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 673bca1e594e..64c12b479b2c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -475,6 +475,7 @@ config RESET_ZYNQMP
 	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
 
 source "drivers/reset/amlogic/Kconfig"
+source "drivers/reset/google/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
 source "drivers/reset/realtek/Kconfig"
 source "drivers/reset/spacemit/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 2fe527a7be8e..a151fe63905e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core.o
 obj-y += amlogic/
+obj-y += google/
 obj-y += hisilicon/
 obj-y += realtek/
 obj-y += spacemit/
diff --git a/drivers/reset/google/Kconfig b/drivers/reset/google/Kconfig
new file mode 100644
index 000000000000..38431b4f9001
--- /dev/null
+++ b/drivers/reset/google/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config RESET_CPM
+	tristate "Google CPM Reset Controller"
+	depends on ARCH_GOOGLE || COMPILE_TEST
+	depends on GOOGLE_CPM_MBA
+	help
+	  Driver support for reset controllers found on Google Tensor SoCs,
+	  operating over the CPM mailbox interface. This allows peripheral
+	  drivers to assert and deassert resets on LPCM hardware blocks.
+
+	  If unsure, say N.
diff --git a/drivers/reset/google/Makefile b/drivers/reset/google/Makefile
new file mode 100644
index 000000000000..437c19459464
--- /dev/null
+++ b/drivers/reset/google/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_RESET_CPM) += reset-cpm.o
diff --git a/drivers/reset/google/reset-cpm.c b/drivers/reset/google/reset-cpm.c
new file mode 100644
index 000000000000..ef0863f25cac
--- /dev/null
+++ b/drivers/reset/google/reset-cpm.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device driver to control Google SoC LPCM resets via CPM.
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
+#include <linux/limits.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reset-controller.h>
+#include <linux/types.h>
+#include <soc/google/google-cpm-mba.h>
+
+#define ASSERT_OP_ID			0
+#define DEASSERT_OP_ID			1
+
+#define CPM_RST_LPCM_ID_MASK		GENMASK(31, 16)
+#define CPM_RST_ID_MASK			GENMASK(15, 0)
+/* Object fields are 8 bits */
+#define CPM_RST_ID_MAX			U8_MAX
+
+static inline unsigned long to_rstc_idx(u32 lpcm_id, u32 rst_id)
+{
+	return FIELD_PREP(CPM_RST_LPCM_ID_MASK, lpcm_id) |
+	       FIELD_PREP(CPM_RST_ID_MASK, rst_id);
+}
+
+static inline u32 lpcm_from_idx(unsigned long idx)
+{
+	return FIELD_GET(CPM_RST_LPCM_ID_MASK, idx);
+}
+
+static inline u32 rst_from_idx(unsigned long idx)
+{
+	return FIELD_GET(CPM_RST_ID_MASK, idx);
+}
+
+struct cpm_reset_provider {
+	struct reset_controller_dev rcdev;
+	struct cpm_handle *cpm;
+};
+
+static inline struct cpm_reset_provider *to_provider(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct cpm_reset_provider, rcdev);
+}
+
+static int cpm_reset_send_lpcm(struct reset_controller_dev *rcdev,
+			       unsigned long idx, u8 opcode)
+{
+	struct cpm_reset_provider *provider = to_provider(rcdev);
+	const struct cpm_lpcm_message msg = {
+		.cmd = LPCM_CMD_SET_RST,
+		.opcode = opcode,
+		.lpcm_id = lpcm_from_idx(idx),
+		.obj_id = rst_from_idx(idx),
+	};
+
+	return cpm_send_lpcm_message(provider->cpm, &msg);
+}
+
+static int cpm_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	return cpm_reset_send_lpcm(rcdev, idx, ASSERT_OP_ID);
+}
+
+static int cpm_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long idx)
+{
+	return cpm_reset_send_lpcm(rcdev, idx, DEASSERT_OP_ID);
+}
+
+static const struct reset_control_ops cpm_reset_ops = {
+	.assert = cpm_reset_assert,
+	.deassert = cpm_reset_deassert,
+};
+
+static int cpm_reset_of_xlate(struct reset_controller_dev *rcdev,
+			      const struct of_phandle_args *reset_spec)
+{
+	u32 lpcm_id, rst_id;
+
+	if (reset_spec->args_count != 2)
+		return -EINVAL;
+
+	lpcm_id = reset_spec->args[0];
+	rst_id = reset_spec->args[1];
+
+	if (lpcm_id > CPM_RST_ID_MAX)
+		return -EINVAL;
+	if (rst_id > CPM_RST_ID_MAX)
+		return -EINVAL;
+
+	return to_rstc_idx(lpcm_id, rst_id);
+}
+
+static int cpm_reset_probe(struct auxiliary_device *auxdev,
+			   const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct cpm_reset_provider *provider;
+	int ret;
+
+	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+
+	provider->cpm = devm_cpm_get_handle(dev);
+	if (IS_ERR(provider->cpm))
+		return dev_err_probe(dev, PTR_ERR(provider->cpm),
+				     "Failed to get CPM handle\n");
+
+	provider->rcdev.dev = dev;
+	provider->rcdev.owner = THIS_MODULE;
+	provider->rcdev.of_node = dev->of_node;
+	provider->rcdev.ops = &cpm_reset_ops;
+	provider->rcdev.of_reset_n_cells = 2;
+	provider->rcdev.of_xlate = cpm_reset_of_xlate;
+
+	ret = devm_reset_controller_register(dev, &provider->rcdev);
+	if (ret < 0) {
+		dev_err(dev, "failed to register reset controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct auxiliary_device_id cpm_reset_id_table[] = {
+	{ .name = "google_cpm_mba.reset" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, cpm_reset_id_table);
+
+static struct auxiliary_driver cpm_reset_driver = {
+	.probe = cpm_reset_probe,
+	.name = "google-reset-cpm",
+	.id_table = cpm_reset_id_table,
+};
+module_auxiliary_driver(cpm_reset_driver);
+
+MODULE_DESCRIPTION("Google CPM Reset Driver");
+MODULE_LICENSE("GPL");
-- 
2.56.1.831.g720f3f5937-goog

