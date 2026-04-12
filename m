Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1603822BB
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028814; cv=none; b=DW9FesRlt4EbkDawMGttHeaUV8NH/x5yPbpAi0APz1AaWdv13HE96KhCjYE74GZXUYLtr89w8Sv9drM19H+Hcm+UN2SL68TiLyVPtoP1HU//9QsVAcVM+MQQRWMHIUmNIFWN9LFzH38B2rRsYS2/sKEXybH1Q08+8xuKazU9+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028814; c=relaxed/simple;
	bh=k8VI7MRV0RzMVUJwg6fgfku3HWrwyDhLnGC8Egha3XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0W+OLc8rwd0seEwjtE73Vr1Vb7BxTm9E8a5qTRSimDfjiaPUKlaI37w4AL746wNZ2vzYQ3nOWZIAvzbqHRXy3IBs7JinUowTBSsAxfAVlrNBq71EItlCutnU1Uo24vkObIFn2Rkzm9X2OdV1OU2WtBV51UcXCwRJNvhRvr53tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2/GcBSE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2/GcBSE"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so341786a91.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028812; x=1776633612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv96ERjBO9/NiOyiLL/BGaUYHQpO00Dknp/iQI1oqNE=;
        b=d2/GcBSEhRbh7rF7/1faAYhb36OFpCmd8TEURxjXDGtFRcuvzuRKiKbqfHe7evKPdX
         v6OYmv4oAddGGOWBbhgrIGkyspz/T54IHLrIW4j1VquoD8Y3nAHbalEELPyD393wf1as
         KqcAlkJZtGGsCdhajEEtvAJE5KE/eyO+LttzxqO4fl0P2f7SYLdoDSMseQgBV1zGamdx
         uCs7BVK6ksb2w29XTON6/kiYAsb5TcTnz5RgNx0YgLWTxWcaCADoJWi2unDk3eoGMrAe
         4I4BWDI5WH0djiJdbYQWaO0UxBnj6jtFEoI6bpbEyl9wEPyjZ5xCky+idHgrWEpNB+Xo
         OxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028812; x=1776633612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hv96ERjBO9/NiOyiLL/BGaUYHQpO00Dknp/iQI1oqNE=;
        b=jyqn11fUgc8BIYzf/GTt/a1NQL7rEiD2BN+K8IzaWMfnqsuKscQCM4XrJC6WAK9TBo
         5Ab9O9GlWLNqcyEO6U1gtSyFRmyDpWOrOnJD2nggSPXMde+5Viky9dpzAhmtlSPNuEdX
         qILiDfQnUykamtsEn0UKYoIqedgaXE+g6tfn1147n4onEDK4hpToFvJ0nU3tPLPW8M1n
         PfIlm5wiEkrsPps5BJSds9Lg4zD6IIvzBCl84RrnhLn7B+8GJ+6qHu/Sprz9awBPdMsx
         UTjo3dFcPh5b7o3QrUPwTD/0KHVhQ58xAfHXlhZTNiGYRgCSfYx2tLWHpT+rWOCRCbtD
         CNyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UHEeJWgvHHoyqK1a2Dl/RO9FfyOmUPkkghAWNzgfBL/XOkAERt4+gi5gXqvi2G5n8IhegKNXqHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36YG/AD2/xoPfay9SnVjS+HPhOV4AshKhT1Lfe+m8nTP6qw9v
	o4hkRO0QJf2TCJrfllQBDcwORme7h36Nbd/juH9Cu7+wJ2eT7vEhIuXD
X-Gm-Gg: AeBDietTnf9ZSo26PImuRSm6EnQRD5AXvIBK2sc6G/zwZwTlcn5+fYZ7UpeMJsvWWoB
	z+8CCTdGVQt8LM392+It1HOJgN4FYjoGL1W/5xdwxfKCgf2PaiQOk0zQsIE/OPqDTiFoo7HLVaO
	rmWDXKjs+iMLt1bMixPM3JbIMrqx09GOVAvLTta1rFj9U6OE86Pg4Nti+yFFxi3gopCMUSkFopg
	DTYGLwuPlfUUl4w8sevY11GSU7cRRSPezZouGh/7/i32ZEbspIg+MhpKxqUK4Jn/2o0RtD1EVdd
	oc00pfhwNgcih48VkVt91uoAqh54ySMit2Vn3EJ5315K/yVXXtDsQiMterxl6kZan5p9oBnKNZf
	pwo5Q7dnlPpGSucl3tDmR0XTZckPxyD/4Y3OuEKl8kxxje2S8IZUp5oZIAjvu6QOtnxN4oBAKUZ
	nPoUz8thBEZA/paapYc6l1UoH/QvlHQnMyvP9GLW8D5MIqtwEKw1KOBTNa1eeSVHB73It86dryN
	LTV/okiV+eYlOFjaif5g2Go07wDNDJpvcwvL28=
X-Received: by 2002:a17:90b:164d:b0:35a:2ed:9b6f with SMTP id 98e67ed59e1d1-35e351f6d14mr14899912a91.0.1776028812173;
        Sun, 12 Apr 2026 14:20:12 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (100.130.194.35.bc.googleusercontent.com. [35.194.130.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a3e6d2sm7615779a12.32.2026.04.12.14.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:20:11 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	laurent@vivier.eu,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 1/2] power: reset: Add QEMU virt-ctrl driver
Date: Sun, 12 Apr 2026 21:19:51 +0000
Message-ID: <20260412211952.3564033-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260412211952.3564033-1-visitorckw@gmail.com>
References: <20260412211952.3564033-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
(e.g. m68k). This device provides a simple interface for system reset
and power off [1].

This driver utilizes the modern system-off API to register callbacks
for both system restart and power off. It also registers a reboot
notifier to catch SYS_HALT events, ensuring that LINUX_REBOOT_CMD_HALT
is properly handled. It is designed to be generic and can be reused by
other architectures utilizing this QEMU device.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v4:
- Fix sparse warning caught by kernel test robot.
- Pass the struct qemu_virt_ctrl context to sys-off handlers instead of
  the __iomem pointer.

 MAINTAINERS                          |   6 ++
 drivers/power/reset/Kconfig          |  10 +++
 drivers/power/reset/Makefile         |   1 +
 drivers/power/reset/qemu-virt-ctrl.c | 122 +++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..aa9eb8540637 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21441,6 +21441,12 @@ S:	Maintained
 F:	drivers/firmware/qemu_fw_cfg.c
 F:	include/uapi/linux/qemu_fw_cfg.h
 
+QEMU VIRT MACHINE SYSTEM CONTROLLER DRIVER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/power/reset/qemu-virt-ctrl.c
+
 QLOGIC QL41xxx FCOE DRIVER
 M:	Saurav Kashyap <skashyap@marvell.com>
 M:	Javed Hasan <jhasan@marvell.com>
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f6c1bcbb57de..99e3334726a5 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -354,4 +354,14 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config POWER_RESET_QEMU_VIRT_CTRL
+	tristate "QEMU Virt Machine System Controller"
+	depends on HAS_IOMEM
+	help
+	  This driver supports the system reset and power off functionality
+	  provided by the QEMU 'virt-ctrl' device.
+
+	  Say Y here if you are running Linux on a QEMU virtual machine that
+	  provides this controller, such as the m68k virt machine.
+
 endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0e4ae6f6b5c5..d7ae97241a83 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
+obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
diff --git a/drivers/power/reset/qemu-virt-ctrl.c b/drivers/power/reset/qemu-virt-ctrl.c
new file mode 100644
index 000000000000..01409dfe2265
--- /dev/null
+++ b/drivers/power/reset/qemu-virt-ctrl.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QEMU Virt Machine System Controller Driver
+ *
+ * Copyright (C) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+/* Registers */
+#define VIRT_CTRL_REG_FEATURES	0x00
+#define VIRT_CTRL_REG_CMD	0x04
+
+/* Commands */
+#define CMD_NOOP	0
+#define CMD_RESET	1
+#define CMD_HALT	2
+#define CMD_PANIC	3
+
+struct qemu_virt_ctrl {
+	void __iomem *base;
+	struct notifier_block reboot_nb;
+};
+
+static inline void virt_ctrl_write32(u32 val, void __iomem *addr)
+{
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		iowrite32be(val, addr);
+	else
+		iowrite32(val, addr);
+}
+
+static int qemu_virt_ctrl_power_off(struct sys_off_data *data)
+{
+	struct qemu_virt_ctrl *ctrl = data->cb_data;
+
+	virt_ctrl_write32(CMD_HALT, ctrl->base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_restart(struct sys_off_data *data)
+{
+	struct qemu_virt_ctrl *ctrl = data->cb_data;
+
+	virt_ctrl_write32(CMD_RESET, ctrl->base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_reboot_notify(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct qemu_virt_ctrl *ctrl = container_of(nb, struct qemu_virt_ctrl, reboot_nb);
+
+	if (action == SYS_HALT)
+		virt_ctrl_write32(CMD_HALT, ctrl->base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_probe(struct platform_device *pdev)
+{
+	struct qemu_virt_ctrl *ctrl;
+	int ret;
+
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctrl->base))
+		return PTR_ERR(ctrl->base);
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_DEFAULT,
+					    qemu_virt_ctrl_restart,
+					    ctrl);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register restart handler\n");
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    qemu_virt_ctrl_power_off,
+					    ctrl);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register power-off handler\n");
+
+	ctrl->reboot_nb.notifier_call = qemu_virt_ctrl_reboot_notify;
+	ret = devm_register_reboot_notifier(&pdev->dev, &ctrl->reboot_nb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "cannot register reboot notifier\n");
+
+	return 0;
+}
+
+static const struct platform_device_id qemu_virt_ctrl_id[] = {
+	{ "qemu-virt-ctrl", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, qemu_virt_ctrl_id);
+
+static struct platform_driver qemu_virt_ctrl_driver = {
+	.probe = qemu_virt_ctrl_probe,
+	.driver = {
+		.name = "qemu-virt-ctrl",
+	},
+	.id_table = qemu_virt_ctrl_id,
+};
+module_platform_driver(qemu_virt_ctrl_driver);
+
+MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
+MODULE_DESCRIPTION("QEMU Virt Machine System Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0.1213.gd9a14994de-goog

