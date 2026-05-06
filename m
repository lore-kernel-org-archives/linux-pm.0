Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383E481FCA;
	Wed,  6 May 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078611; cv=none; b=JwIlrhjPsiA3jlWKHxmKFrulbMGVrxIaCjDk0O8U04VgPrL6Cq3SVCUIRvteCEzyGdjmszA+frIRJG+YYOAom0X9agEtDQKvMHrv5X403B4mVZexsQ/oHG6HaO2dYaCGAScgXUroNeDBTmUjdm9Wu19PSTF+cnd9EZAVsuwXD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078611; c=relaxed/simple;
	bh=Ny7nqMN8NxdAkg6MWBl3xuIS09EV4Jp6rIEFDcRJSV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krI5EP+RiYhSYn/6Onf4REZ7iws4C5/ykD/H+N5tNGjRMrRgRlRJJ8hAVlbSTC4FhP/Pztz636O5MItUcgrcrPtMjIQdKL+0fkOo2ApdiCHxp0yMh8m2lSkF1DVG3JXjTurNutKDFKD5LvkXEPgzJOtO12PtWqcgBtxcAXoyC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=KVQSWrZ2; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Q/xJpGIN; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="KVQSWrZ2";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Q/xJpGIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1778078608; bh=Ny7nqMN8NxdAkg6MWBl3xuIS09EV4Jp6rIEFDcRJSV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVQSWrZ2ZT0ahZElPyJhfmve9L7mYtNymM9jIxuIXBJOcGoQnL4BHfJ4N7uNfQ9hm
	 I95pe1t9tYixLFMUZzqHNwFf6U0rVCeTR2JDSfoaj97TC8+zyhSTb8hCJ+r2zTpxG4
	 c+WYnC8kszF6Il1d/p6NSoitg9HKNGqifqvYErT7vab4KQpljL9IGQqk83HgApHV/K
	 +qOMv5+bOIlJhGMJcVjOfEqRciKzL4D0TNm40s3vl7Nva8iY45ypLQ3FDK9o6u7ry9
	 7eHvcYFk1Cwxij53PvK5TUs3dla2P9anuHcpcEvAhhtiajmNL5z/AuINOMTlVjX7lq
	 q3jid4y3BeK7A==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 94F7241CE6; Wed, 06 May 2026 15:43:28 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1778078592; bh=Ny7nqMN8NxdAkg6MWBl3xuIS09EV4Jp6rIEFDcRJSV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/xJpGINnFJoJi5k/0Nsh3lNKvSppoZhvVKWu7GHbVX6JkdXPfHN4uD4EEnSTQOIJ
	 aFXedWaqKtDgW5MSpUO/BTRzUELJNzoxlQ2GN7RnNFz3waqVgNHHPORVwBxWQ6r8+O
	 p+p3cJoc0D4JUvVqrzsSaL9vbsoJYbkJzG/r4IR9NRKqNp8fjl/R2/GtV8fvmKdz0K
	 TnpQz2oQaIjq7E9kLPlpIk46IforZ8kYsDUXbJufQOTgtZVzTf1Y/FN+Zq+TRkmWvG
	 WDLypgPfYGnef9AFkuadMZjvxIH05Dw6KI2rVK0sabn4qVHMVjmu5JQmtsVMSYsUSr
	 n0bFganxaojpw==
Received: from maru.local (unknown [140.228.74.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 780A541CE1;
	Wed, 06 May 2026 15:43:12 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 7/8] cpufreq: sc520_freq: Drop support for AMD Elan SC520
Date: Wed,  6 May 2026 15:42:52 +0100
Message-ID: <12a3abd097fda750ae905290c86ddb8d2b0a716c.1778071745.git.sean@mess.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778071745.git.sean@mess.org>
References: <cover.1778071745.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
the AMD Elan SC520 is no longer supported, so the cpu frequency
driver is no longer needed.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/cpufreq/Kconfig.x86  |  11 ---
 drivers/cpufreq/Makefile     |   1 -
 drivers/cpufreq/sc520_freq.c | 136 -----------------------------------
 3 files changed, 148 deletions(-)
 delete mode 100644 drivers/cpufreq/sc520_freq.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 027e6ea2e038..865b290b01ff 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -141,17 +141,6 @@ config ELAN_CPUFREQ
 
 	  If in doubt, say N.
 
-config SC520_CPUFREQ
-	tristate "AMD Elan SC520"
-	depends on MELAN
-	help
-	  This adds the CPUFreq driver for AMD Elan SC520 processor.
-
-	  For details, take a look at <file:Documentation/cpu-freq/>.
-
-	  If in doubt, say N.
-
-
 config X86_POWERNOW_K6
 	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
 	depends on X86_32
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 385c9fcc65c6..96196edf79d5 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_X86_POWERNOW_K7)		+= powernow-k7.o
 obj-$(CONFIG_X86_LONGHAUL)		+= longhaul.o
 obj-$(CONFIG_X86_E_POWERSAVER)		+= e_powersaver.o
 obj-$(CONFIG_ELAN_CPUFREQ)		+= elanfreq.o
-obj-$(CONFIG_SC520_CPUFREQ)		+= sc520_freq.o
 obj-$(CONFIG_X86_LONGRUN)		+= longrun.o
 obj-$(CONFIG_X86_GX_SUSPMOD)		+= gx-suspmod.o
 obj-$(CONFIG_X86_SPEEDSTEP_ICH)		+= speedstep-ich.o
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
deleted file mode 100644
index b360f03a116f..000000000000
--- a/drivers/cpufreq/sc520_freq.c
+++ /dev/null
@@ -1,136 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *	sc520_freq.c: cpufreq driver for the AMD Elan sc520
- *
- *	Copyright (C) 2005 Sean Young <sean@mess.org>
- *
- *	Based on elanfreq.c
- *
- *	2005-03-30: - initial revision
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/delay.h>
-#include <linux/cpufreq.h>
-#include <linux/timex.h>
-#include <linux/io.h>
-
-#include <asm/cpu_device_id.h>
-
-#define MMCR_BASE	0xfffef000	/* The default base address */
-#define OFFS_CPUCTL	0x2   /* CPU Control Register */
-
-static __u8 __iomem *cpuctl;
-
-static struct cpufreq_frequency_table sc520_freq_table[] = {
-	{0, 0x01,	100000},
-	{0, 0x02,	133000},
-	{0, 0,	CPUFREQ_TABLE_END},
-};
-
-static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
-{
-	u8 clockspeed_reg = *cpuctl;
-
-	switch (clockspeed_reg & 0x03) {
-	default:
-		pr_err("error: cpuctl register has unexpected value %02x\n",
-		       clockspeed_reg);
-		fallthrough;
-	case 0x01:
-		return 100000;
-	case 0x02:
-		return 133000;
-	}
-}
-
-static int sc520_freq_target(struct cpufreq_policy *policy, unsigned int state)
-{
-
-	u8 clockspeed_reg;
-
-	local_irq_disable();
-
-	clockspeed_reg = *cpuctl & ~0x03;
-	*cpuctl = clockspeed_reg | sc520_freq_table[state].driver_data;
-
-	local_irq_enable();
-
-	return 0;
-}
-
-/*
- *	Module init and exit code
- */
-
-static int sc520_freq_cpu_init(struct cpufreq_policy *policy)
-{
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	/* capability check */
-	if (c->x86_vendor != X86_VENDOR_AMD ||
-	    c->x86 != 4 || c->x86_model != 9)
-		return -ENODEV;
-
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
-	policy->freq_table = sc520_freq_table;
-
-	return 0;
-}
-
-
-static struct cpufreq_driver sc520_freq_driver = {
-	.get	= sc520_freq_get_cpu_frequency,
-	.verify	= cpufreq_generic_frequency_table_verify,
-	.target_index = sc520_freq_target,
-	.init	= sc520_freq_cpu_init,
-	.name	= "sc520_freq",
-};
-
-static const struct x86_cpu_id sc520_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 9, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, sc520_ids);
-
-static int __init sc520_freq_init(void)
-{
-	int err;
-
-	if (!x86_match_cpu(sc520_ids))
-		return -ENODEV;
-
-	cpuctl = ioremap((unsigned long)(MMCR_BASE + OFFS_CPUCTL), 1);
-	if (!cpuctl) {
-		pr_err("sc520_freq: error: failed to remap memory\n");
-		return -ENOMEM;
-	}
-
-	err = cpufreq_register_driver(&sc520_freq_driver);
-	if (err)
-		iounmap(cpuctl);
-
-	return err;
-}
-
-
-static void __exit sc520_freq_exit(void)
-{
-	cpufreq_unregister_driver(&sc520_freq_driver);
-	iounmap(cpuctl);
-}
-
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Sean Young <sean@mess.org>");
-MODULE_DESCRIPTION("cpufreq driver for AMD's Elan sc520 CPU");
-
-module_init(sc520_freq_init);
-module_exit(sc520_freq_exit);
-
-- 
2.54.0

