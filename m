Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051124;
	b=HDKvg2yYW3IdM/5drbLLUc4dTS7r1px+2mF4d7g3Wo1Tc3cWipNk2z1yt2Ng2GWFqJE9
	 10Po9zbnqJSmd6dRo8GlSSId7j4f/BDfGE5zJ+YTW/6twrLZhOhX7EVaoRzyxQ4kky+C5
	 ICjryGmAr4ZzmuBvRkMfoVpqrMGKTiZxvor2rIDLjRQh3qAfQHxpOn9unyRlwmgPjCATD
	 fOEwYFvtFGFvnLCM3OJ663POwlbjomFBWsBgg6pQjmVnAzNMjT02grjonNBFSlPEOXFHt
	 F3YKFzFLhNEXhI2kvGgKMBC/+JyGqkr5RjlTGymeNZe8cmOgBltzL6WAR8m+LR/p3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fFnPwskegPZzfHsLT5NNhjCL4eznWzxTpvnez9GW2eg=;
	b=gqGyXnZNdmi6Owufv3hFU7dQTEe9K1pmGK53ma0NUQWLZn/e8T43bIafiFv2baK3mNJh
	 woqqyE3frepaaBv2TIy/hVrtBmLrmLWKHZcolQZvyFCarnwASguDYanRMSGaz02FfzU20
	 7BLkagNpNN4d62igFmbSkaqC4F0Pzk/ACZc24LgrRZRKfT/ZTqkaOhKrhIX47oIsdKN83
	 PZYfrZjfnIFmgXHRRSyzirIg/Q2oR1zGby9BMZ3P7MUAzhbJiM9OeWQNsmPov/tYSi2QT
	 0TNdrlZ8Ud2FAN/uX3/zv99ndHQPfUkDzPnwyD9CHHE7h4ZgVokYAc9Xb5Sjw/tDg6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iy3fXxzS;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7560A2626
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D7560A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iy3fXxzS
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso5692435eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051124; x=1793655924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fFnPwskegPZzfHsLT5NNhjCL4eznWzxTpvnez9GW2eg=;
        b=iy3fXxzSkOcIiFm0/SXhQRLEuohrieumxG1CHZh3cShs2NfrlObJ8dly7NDumJDq91
         Tu2uGmc4+DOogdSxc/vth16b3mPQio3M/2heoH5y7JOEwwq6jKC1xjaZ+GAmOzjJiQ/x
         Yrs8KA0eXKWDqcmF/AjhFFy5OVJOCnG0T1mlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051124; x=1793655924;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFnPwskegPZzfHsLT5NNhjCL4eznWzxTpvnez9GW2eg=;
        b=ttxcqAPfkas0c7jSW98eEWFROJfcxBoeE1bAk/ytefr+N79XAAfvbBM7AJJeWScv1i
         RY1GkZe17T+aWmTu/nTN0gEKdedCPhiy5SB2VxNQ6V2zK1qNIFouT7TJ7MK6/D8YY61s
         ToPe/r+LwrX2TDtMEVx1Ql3XuNDhnKWPhRfAOICux0rz4qRnoHr7KK0jojXk1tYcLZNC
         8ocpLVNF7+nROlgU96kABbjlMFETtVYWb3cGuXZJB4aWjR6c7AsFzmebKzsRAQatvM9k
         0m+cWpta6qiXTOe5go75NG8zRbOy7ERb0mKdW7lOfQpsDXCG3mIPYSEIJfX+eC5RaLTF
         8H9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcg5XLDiBpebnxBEgnkWqC+Z6QQDnycgb0kXlvjY7b/KPRGiXKmZkOwXZw2TUkcQGe2WZTmVIDUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIPsltIDG50oWQtmOQRCr1DISu7Pmmdc6dqXDEA6qdlAl3Li3gc
	pmJ+XjMqQcphfymxcwsNiypqwsz9bbXx0A4c/62trWu12DPnkXv8OESdQFhwChzkmA==
X-Gm-Gg: AYBFou0qYvjHdknFxw3XzGQ+fO6+CMDtMu/GjPpCnxuMkxxibYqRDTEbeTrjb8TytR7
	JzoBBvE+hxTAKMlbblfXhinOxKnrzwcf42Z2W5Uu3KDxDTFWmElIybc+vjoASvELRGuK7gW3k7R
	cXKKBaRaPmTGNmHok4tIUTHw2yz5HgC7C93Nzmkv/O/ftEaj7a3VWjYnPI6uvPU3k+9lznoQfzz
	G/s8e7DlMpLWar4nuNyhB8QxLarlKuoUjEKsFAGFCDWy/il6izhU4a7ZPAqoUyN/RnsIAbSnjBa
	UE3m9NWT2g/LsnljmlUvcGB3kEJE63I7uKp9OvnaG9+knSZg5QVw/wKroKaW0zM3VTX+s+YJxT6
	DHzFSoSqfHHkcQROae9V2Bff3aYxG5kiNKJVPtYR8qU31fxOhWzyDNunfSo8SzOGavWhmeJr/p5
	B8YaM5MiU1+QuZBiv3XdYP2+A4rSwtWzQk1a+f8Hlt3ANNsZHpgLSOmEwLFJDVWUQzq2ZxTHaKr
	MF4sAjrriZ5C2T/v4Wx+3knjVI0avL5aO3rNACwnVTH/6ArP0h9ZGjo7eF99pAAX8PRext6kTzT
	4Zj8fimHtf/DYC6gctE=
X-Received: by 2002:a05:7301:d80f:10b0:369:f7d2:d7b4 with SMTP id 5a478bee46e88-369f7d2eed8mr7550254eec.26.1793051123451;
        Mon, 26 Oct 2026 14:45:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-369ff5a4d68sm13241766eec.14.2026.10.26.14.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:22 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 7/9] irqchip/google-cpm: Add CPM IRQ driver
Date: Mon, 26 Oct 2026 14:43:45 -0700
Message-ID: <20261026144346.7.I41e14e9460b3add41e69dac97abf57a741e9c4c5@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
References: <20261026214359.3122870-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Central Power Manager (CPM) on Google Tensor SoCs can signal
events/interrupts over its mailbox communication protocol. Today, the
downstream driver for these chips only supports interrupt notification,
although the CPM firmware may also have mask/unmask support (not
currently used) that could be added later if needed.

In practice, this driver is used for RTC alarms and for events driven by
the Always-on Compute (AoC) subsystem.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/irqchip/Kconfig          |  10 +++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-google-cpm.c | 123 +++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/irqchip/irq-google-cpm.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ca915fca0ef5..47f9739b1d74 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -556,6 +556,16 @@ config CSKY_APB_INTC
 	  by C-SKY single core SOC system. It uses mmio map apb-bus to visit
 	  the controller's register.
 
+config GOOGLE_CPM_IRQ
+	tristate "Google Tensor CPM interrupt controller"
+	depends on GOOGLE_CPM_MBA
+	depends on ARCH_GOOGLE || COMPILE_TEST
+	select IRQ_DOMAIN
+	help
+	  Support for the Central Power Manager (CPM) interrupt controller
+	  found on Google Tensor SoCs. This controller routes interrupts from
+	  the CPM to the Application Processor.
+
 config IMX_IRQSTEER
 	bool "i.MX IRQSTEER support"
 	depends on ARCH_MXC || ARCH_S32 || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 16a5fd126c9a..ca10888687fd 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
+obj-$(CONFIG_GOOGLE_CPM_IRQ)		+= irq-google-cpm.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic-main.o irq-riscv-aplic-direct.o
 obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
diff --git a/drivers/irqchip/irq-google-cpm.c b/drivers/irqchip/irq-google-cpm.c
new file mode 100644
index 000000000000..a235cc1cfe7c
--- /dev/null
+++ b/drivers/irqchip/irq-google-cpm.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Google CPM IRQ chip driver
+ *
+ * Copyright 2023-2026 Google LLC
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <soc/google/goog_cpm_service_ids.h>
+#include <soc/google/google-cpm-mba.h>
+
+#define CPM_IRQ_COUNT				512
+
+struct cpm_irq_info {
+	struct device		*dev;
+	struct irq_domain	*domain;
+};
+
+static void cpm_irq_process_irq_status(struct cpm_irq_info *info, u32 irq_number)
+{
+	int ret;
+
+	ret = generic_handle_domain_irq_safe(info->domain, irq_number);
+	if (ret)
+		dev_err(info->dev, "Error handling IRQ %u, error code %d\n", irq_number, ret);
+}
+
+static void cpm_irq_rx_callback(u32 context, const struct cpm_payload *msg, void *priv)
+{
+	struct cpm_irq_info *info = priv;
+	u32 irq_number = msg->payload[0];
+
+	cpm_irq_process_irq_status(info, irq_number);
+}
+
+static void cpm_irq_domain_remove_action(void *data)
+{
+	struct irq_domain *domain = data;
+	unsigned int hwirq;
+
+	for (hwirq = 0; hwirq < CPM_IRQ_COUNT; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(domain, hwirq));
+
+	irq_domain_remove(domain);
+}
+
+static int cpm_irq_domain_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hwirq)
+{
+	struct cpm_irq_info *info = d->host_data;
+
+	if (hwirq >= CPM_IRQ_COUNT)
+		return -EINVAL;
+
+	irq_set_chip_data(virq, info);
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+
+	dev_dbg(info->dev, "Mapped hwirq %lu to virq %u\n", hwirq, virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops cpm_irq_domain_ops = {
+	.map = cpm_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int cpm_irq_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct cpm_client *client;
+	struct cpm_irq_info *info;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = dev;
+	auxiliary_set_drvdata(adev, info);
+
+	info->domain = irq_domain_create_tree(dev_fwnode(dev), &cpm_irq_domain_ops, info);
+	if (!info->domain) {
+		dev_err(dev, "Unable to add irq domain\n");
+		return -ENODEV;
+	}
+
+	ret = devm_add_action_or_reset(dev, cpm_irq_domain_remove_action, info->domain);
+	if (ret) {
+		dev_err(dev, "Failed to add irq domain removal action\n");
+		return ret;
+	}
+
+	client = devm_cpm_request_client(dev, CPM_AP_NS_IRQ_SERVICE,
+					 cpm_irq_rx_callback, info);
+	if (IS_ERR(client))
+		return dev_err_probe(dev, PTR_ERR(client),
+				     "Failed to request cpm client\n");
+
+	return 0;
+}
+
+static const struct auxiliary_device_id cpm_irq_id_table[] = {
+	{ .name = "google_cpm_mba.irq" },
+	{ },
+};
+MODULE_DEVICE_TABLE(auxiliary, cpm_irq_id_table);
+
+static struct auxiliary_driver cpm_irq_driver = {
+	.probe = cpm_irq_probe,
+	.name = "cpm-irq-chip",
+	.id_table = cpm_irq_id_table,
+};
+
+module_auxiliary_driver(cpm_irq_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Google CPM IRQ chip driver");
+MODULE_AUTHOR("Jim Wylder <jwylder@google.com>");
-- 
2.56.0.307.g5fe7bd680c-goog

