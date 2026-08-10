Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009030567F
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372332; cv=none; b=jswzW7qyVGVMOjNJinaqHCLGtR9Nt8tTJM/mv2jUNUck4sRYO8w7+oKmEIQzKsacDvxYRRi0k0w8irkHMZiJ/Zob5nPHAHk+NH5Yc5Qb8IwUDBRPqZHCEARvtgsMBzl5Q9gRbVS48YCyV3IEbtyDUNLMzLlE9iuQOUHIJxPDBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372332; c=relaxed/simple;
	bh=uyZX4gPRQtl4jmnSZx2ZJRKSrL8w6QqMB+qfRovOzv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fT8m/ZeaRvWtvRVB86bxMBbMuwkhIZw641KrPlht/V5LhVyn2yWiYd2z9ehAQukUvXS7Fv0wnknhs4H00Y7wQBOYt4x85HEMh3d5NA4QqG5K1Nw2gH3mfwBFEKWcCTzlPPn7cgUtUxPvPUngarN98OQAjLfeS9PVv7KPGQSa26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8schReS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8schReS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956869750eso12911915e9.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786372329; x=1786977129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M6II6wNoYIH6ltsWqtS7reuxWUbNKPD2fplzN48dIG8=;
        b=l8schReSWqxrKt70ZcC8bkQJrMLEkUzyVIapzNRb1g+hQa00lWNX8zTjfoUl+V6zcR
         vgoTuQyJBfeMwNmqk0fq6sPzMOXpu8vLIZu5wOnW4Ld/urFOKT0mYRVE7UWKsjg9gGGg
         VFCtEm9tt0Pt0Qj+8bICl7WiYcYeungv3HGJwW5Xp69TZAAONqwfMruTuq9ZUwUuhb9N
         XbvLm/m++gb11f7ODe/apGHRZw+gKS/6xMqz0TsvKbQgpzu6dRlDWm7rBk8I7NcsyUYR
         W2C0qcx5A4/YxkJl3uq6TD+1pWuarIaRZpHxwi5VQwEEVf0rZ6r/ltAG34PlbJgF5PHa
         811A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372329; x=1786977129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M6II6wNoYIH6ltsWqtS7reuxWUbNKPD2fplzN48dIG8=;
        b=TTCXdOL60walEUzRHeNroQET80P7Qx2iH59UjIsTxAlG549rk+V486pvzx9iedu4yK
         c/lne+mpW0/6QD7vrTQ6czBBumzY/j8g6rwavl1zfaDN/IsaquNLTtO4eUMrJpR0HZzE
         O7aCJpqgt34lRzv0aWTrRah0Nz38+DyrSAFBN1gE7USiJbA+kJ8eOW2pnLTILBtBek48
         ty99Kcz/1HfbCmhVvku09WTTBBSfdcc1vaPQWzr/W3qnbk5m67dhTg/kS9q0+BlySNZf
         AXhPBSBPKNTtL+VmQwDRGlu7GqPOwINhMQXdjLArjmwSflsIhNV1W6ClkxQVD+/LPCGx
         2JCw==
X-Forwarded-Encrypted: i=1; AHgh+RqhiM8i0QZnxFJfc9O7CzlBL39jmOvnGdPx55BxPcf1BWn0vzTQdRfX7P0sX5BotTbEIMUAVJoTvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtziIyTB0b1peHlBTcU8H0VnLmdXDYSafnYA9lnrGD47jW/t0
	M871qmfhqpa6dmDHcYRTOoif4U5thE4Nvq2ijyS8JmW4G80x4JWkSg2I
X-Gm-Gg: AR+sD13gcEAW5YBS8FZ5tO32BezNofNBTXz/UuergOgVBwqqJVUWzLqU7gJ5j/6ccI7
	bM7D2td7fM6iFTS+U5ip5rdWKHaviOcF5slG7EPNfGj5LnZLO0vs1j/BUzdgRG2Gigxr5Kq4JVg
	n8jcDLLcMrqfD0LbTvI4nw8mAN6075IvhlOzf0VW1wzgRzmtTO8E98FrJ5AdieTcUrkQkMSjCrq
	PfijyK2ry+CAa9ThQ5tANvY6fOPje7Qr21Xaqsg/Y0eLYmb6ig39zIrCAtR29S10rg22rzqB+GB
	BSFwaCDLEwRvsCSVuV56xLMWi8clGZJcdZBXoEZsX72GC7CLEH10hjDLhmSBPA9z3Hm5phmjIwx
	2TNEYH09A55F2dUULLC4hux29tBXghTRWY1KHTT9Dz03lU08ubjCyU58MUk4XrCsdFVlwyrkWjE
	ChATRAh1drg7uJ/Yn/VkKxjVa5orG2aZbhjajb5moHNoss/24YsYo8sQTYTzD1ovn6xZjGbgBlo
	0bajBmB5G3oljiLIvTB2an3ukTTVJvLOfTrM5jN4c5IGgH6
X-Received: by 2002:a05:600c:4688:b0:495:4bf3:2150 with SMTP id 5b1f17b1804b1-4997277b7f1mr22756405e9.8.1786372264913;
        Mon, 10 Aug 2026 07:31:04 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm438950695e9.3.2026.08.10.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:31:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM / devfreq: add Airoha SoC devfreq driver
Date: Mon, 10 Aug 2026 16:30:55 +0200
Message-ID: <20260810143057.651478-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810143057.651478-1-ansuelsmth@gmail.com>
References: <20260810143057.651478-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple Airoha SoC devfreq driver. This simple driver register a
driver from a given clock and register a passive governor to scale the
frequency with the CPU frequency.

required-opp on the CPU frequency will be used to correctly bind the
clock to the related CPU frequency.

GSW, NPU, SOE, BUS and many other clock will register this devfreq
driver to scale all these internal peripheral  from idle to performance
mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/Kconfig          | 10 ++++
 drivers/devfreq/Makefile         |  1 +
 drivers/devfreq/airoha-devfreq.c | 99 ++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/devfreq/airoha-devfreq.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index c999c4a1e567..1e857a7e9caf 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -75,6 +75,16 @@ config DEVFREQ_GOV_PASSIVE
 
 comment "DEVFREQ Drivers"
 
+config ARM_AIROHA_DEVFREQ
+	tristate "Scaling support for Airoha SoC"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	select DEVFREQ_GOV_PASSIVE
+	help
+	  This adds the DEVFREQ driver for the Airoha SoC.
+
+	  The driver register with the cpufreq notifier and find the right frequency
+	  based on the required OPP set in DT.
+
 config ARM_EXYNOS_BUS_DEVFREQ
 	tristate "ARM Exynos Generic Memory Bus DEVFREQ Driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 404179d79a9d..5ca27684dee3 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
+obj-$(CONFIG_ARM_AIROHA_DEVFREQ)	+= airoha-devfreq.o
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_HISI_UNCORE_DEVFREQ)	+= hisi_uncore_freq.o
 obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
diff --git a/drivers/devfreq/airoha-devfreq.c b/drivers/devfreq/airoha-devfreq.c
new file mode 100644
index 000000000000..cb6d8b49e4a4
--- /dev/null
+++ b/drivers/devfreq/airoha-devfreq.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/devfreq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/pm_opp.h>
+
+struct airoha_devfreq_data {
+	struct clk *clk;
+
+	struct devfreq_passive_data gov_data;
+};
+
+static int airoha_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct airoha_devfreq_data *data = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(data->clk);
+
+	return 0;
+};
+
+static int airoha_devfreq_target(struct device *dev, unsigned long *freq,
+				 u32 flags)
+{
+	struct airoha_devfreq_data *data = dev_get_drvdata(dev);
+
+	return clk_set_rate(data->clk, *freq);
+};
+
+static int airoha_devfreq_get_dev_status(struct device *dev,
+					 struct devfreq_dev_status *stat)
+{
+	struct airoha_devfreq_data *data = dev_get_drvdata(dev);
+
+	stat->busy_time = 0;
+	stat->total_time = 0;
+	stat->current_frequency = clk_get_rate(data->clk);
+
+	return 0;
+};
+
+static struct devfreq_dev_profile airoha_devfreq_devfreq_profile = {
+	.target = airoha_devfreq_target,
+	.get_dev_status = airoha_devfreq_get_dev_status,
+	.get_cur_freq = airoha_devfreq_get_cur_freq
+};
+
+static int airoha_devfreq_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct airoha_devfreq_data *data;
+	struct devfreq *devfreq;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(data->clk))
+		return dev_err_probe(dev, PTR_ERR(data->clk), "failed to get clk\n");
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse fab freq thresholds\n");
+
+	dev_set_drvdata(dev, data);
+
+	data->gov_data.parent_type = CPUFREQ_PARENT_DEV;
+	devfreq = devm_devfreq_add_device(dev, &airoha_devfreq_devfreq_profile,
+					  DEVFREQ_GOV_PASSIVE, &data->gov_data);
+
+	return PTR_ERR_OR_ZERO(devfreq);
+};
+
+static const struct of_device_id airoha_devfreq_match_table[] = {
+	{ .compatible = "airoha,devfreq" },
+	{}
+};
+
+static struct platform_driver airoha_devfreq_driver = {
+	.probe		= airoha_devfreq_probe,
+	.driver		= {
+		.name   = "airoha-devfreq",
+		.of_match_table = airoha_devfreq_match_table,
+	},
+};
+module_platform_driver(airoha_devfreq_driver);
+
+MODULE_DESCRIPTION("Airoha Devfreq driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.53.0

