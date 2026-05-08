Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA012374E64;
	Fri,  8 May 2026 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218858; cv=none; b=LRKVIeU+RSiqww7YXe46Yw7KfppwhKoL+ZnMqfWNgq5vLeBVwRLzX6UGfUOEsBilocDnzENiW09RA1d2xs6VWQgdGoOWErJFvHEDFhtnS/lQ3J1WD8/IfcEixCHxPCyp/UaHoC+qF+fEllYwDlGKIN3/oJ3HF+ZIuDelDa1il9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218858; c=relaxed/simple;
	bh=cynXXSgjQoxjt1yV7PCFZoBYxgoh2ClKXKIP6d8PFUk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jVP2RVupDXYglajvTpoKmzywPo6DirfYDwhT6vM8Xfs7cGaiYcv/HR7bXTP6a2V3NkFFNlvIC1tUafDEw27jePQpf5MunQ8q0kYrDQ8ZdqOKyN++5hjQxiwjs4HcuY1ZGKFurqf+Nez4vQNi/rmIOk2MIMlb4M0BsNNAIoQXh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATqy14fq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYOzfpi8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATqy14fq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYOzfpi8"
Date: Fri, 08 May 2026 05:40:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778218838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1AdsrNKD/WNYUMwcAy3yzTErq5fLzOTLmGXPp5gqBhU=;
	b=ATqy14fqmS2fm+OTZZJB8qZIIgiYGCvN0/K+rsPrXVrKPcbwEstsPlAhTh30u6Cihq8QZc
	qjhAeNLMoPF1jFnwBuqznywwPNJ78oyW4kW8AeR+OZ9TmF1uT6/mtYYy7M09QV46oJ6ARE
	oCNyJlG/vfaT7zseKqnYWLYY2F5/qVqJEHZ7EPVnBlCxgWLULFZQQASDUxdxFIzj7/XmiO
	na5mSGp9W8juxbpqjO6laoF1qS/u0mw64XyR1EiCKKobTNv5SxcNEnKrYn7dgQNs+7IARh
	5T8vz0enMRLGieBBN7UUjev2D/mSiUvttCIFvWnldmBH7rdPtzOu+i8pZR55pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778218838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1AdsrNKD/WNYUMwcAy3yzTErq5fLzOTLmGXPp5gqBhU=;
	b=FYOzfpi8IFMM1RE26ZB6NN+VwDpKch4ODas8t9AJMaEPVCzsLNiyxrbSM0zxrHLhBdzpfB
	BEy+cgPLpEMPyKBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, cpufreq: Remove AMD ELAN support
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177821883088.864.5785990608593634039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     435ef16e69b9d7f9cdf460a4c2edd20bb47d51fa
Gitweb:        https://git.kernel.org/tip/435ef16e69b9d7f9cdf460a4c2edd20bb47=
d51fa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 10:26:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 08 May 2026 07:34:03 +02:00

x86/cpu, cpufreq: Remove AMD ELAN support

Now that i486 and CONFIG_MELAN support has been removed upstream:

  8b793a92d862c ("x86/cpu: Remove M486/M486SX/ELAN support")

the CONFIG_ELAN_CPUFREQ and CONFIG_SC520_CPUFREQ cpufreq
drivers can be removed as well, as they depend on CONFIG_MELAN.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Link: https://lore.kernel.org/r/20250425084216.3913608-8-mingo@kernel.org
---
 arch/x86/Makefile_32.cpu     |   3 +-
 drivers/cpufreq/Kconfig.x86  |  26 +----
 drivers/cpufreq/Makefile     |   2 +-
 drivers/cpufreq/elanfreq.c   | 226 +----------------------------------
 drivers/cpufreq/sc520_freq.c | 136 +--------------------
 5 files changed, 393 deletions(-)
 delete mode 100644 drivers/cpufreq/elanfreq.c
 delete mode 100644 drivers/cpufreq/sc520_freq.c

diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index ec9f34d..c5aa169 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -28,9 +28,6 @@ cflags-$(CONFIG_MVIAC3_2)	+=3D $(call cc-option,-march=3Dc3=
-2,-march=3Di686)
 cflags-$(CONFIG_MVIAC7)		+=3D -march=3Di686
 cflags-$(CONFIG_MATOM)		+=3D -march=3Datom
=20
-# AMD Elan support
-cflags-$(CONFIG_MELAN)		+=3D -march=3Di486
-
 # Geode GX1 support
 cflags-$(CONFIG_MGEODEGX1)	+=3D -march=3Dpentium-mmx
 cflags-$(CONFIG_MGEODE_LX)	+=3D $(call cc-option,-march=3Dgeode,-march=3Dpen=
tium-mmx)
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 027e6ea..c42dd39 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -126,32 +126,6 @@ config X86_ACPI_CPUFREQ_CPB
 	  By enabling this option the acpi_cpufreq driver provides the old
 	  entry in addition to the new boost ones, for compatibility reasons.
=20
-config ELAN_CPUFREQ
-	tristate "AMD Elan SC400 and SC410"
-	depends on MELAN
-	help
-	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
-	  processors.
-
-	  You need to specify the processor maximum speed as boot
-	  parameter: elanfreq=3Dmaxspeed (in kHz) or as module
-	  parameter "max_freq".
-
-	  For details, take a look at <file:Documentation/cpu-freq/>.
-
-	  If in doubt, say N.
-
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
index 385c9fc..6c7a39b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -40,8 +40,6 @@ obj-$(CONFIG_X86_POWERNOW_K6)		+=3D powernow-k6.o
 obj-$(CONFIG_X86_POWERNOW_K7)		+=3D powernow-k7.o
 obj-$(CONFIG_X86_LONGHAUL)		+=3D longhaul.o
 obj-$(CONFIG_X86_E_POWERSAVER)		+=3D e_powersaver.o
-obj-$(CONFIG_ELAN_CPUFREQ)		+=3D elanfreq.o
-obj-$(CONFIG_SC520_CPUFREQ)		+=3D sc520_freq.o
 obj-$(CONFIG_X86_LONGRUN)		+=3D longrun.o
 obj-$(CONFIG_X86_GX_SUSPMOD)		+=3D gx-suspmod.o
 obj-$(CONFIG_X86_SPEEDSTEP_ICH)		+=3D speedstep-ich.o
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
deleted file mode 100644
index fc5a580..0000000
--- a/drivers/cpufreq/elanfreq.c
+++ /dev/null
@@ -1,226 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *	elanfreq:	cpufreq driver for the AMD ELAN family
- *
- *	(c) Copyright 2002 Robert Schwebel <r.schwebel@pengutronix.de>
- *
- *	Parts of this code are (c) Sven Geggus <sven@geggus.net>
- *
- *      All Rights Reserved.
- *
- *	2002-02-13: - initial revision for 2.4.18-pre9 by Robert Schwebel
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
-
-#include <asm/cpu_device_id.h>
-#include <linux/timex.h>
-#include <linux/io.h>
-
-#define REG_CSCIR 0x22		/* Chip Setup and Control Index Register    */
-#define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
-
-/* Module parameter */
-static int max_freq;
-
-struct s_elan_multiplier {
-	int clock;		/* frequency in kHz                         */
-	int val40h;		/* PMU Force Mode register                  */
-	int val80h;		/* CPU Clock Speed Register                 */
-};
-
-/*
- * It is important that the frequencies
- * are listed in ascending order here!
- */
-static struct s_elan_multiplier elan_multiplier[] =3D {
-	{1000,	0x02,	0x18},
-	{2000,	0x02,	0x10},
-	{4000,	0x02,	0x08},
-	{8000,	0x00,	0x00},
-	{16000,	0x00,	0x02},
-	{33000,	0x00,	0x04},
-	{66000,	0x01,	0x04},
-	{99000,	0x01,	0x05}
-};
-
-static struct cpufreq_frequency_table elanfreq_table[] =3D {
-	{0, 0,	1000},
-	{0, 1,	2000},
-	{0, 2,	4000},
-	{0, 3,	8000},
-	{0, 4,	16000},
-	{0, 5,	33000},
-	{0, 6,	66000},
-	{0, 7,	99000},
-	{0, 0,	CPUFREQ_TABLE_END},
-};
-
-
-/**
- *	elanfreq_get_cpu_frequency: determine current cpu speed
- *
- *	Finds out at which frequency the CPU of the Elan SOC runs
- *	at the moment. Frequencies from 1 to 33 MHz are generated
- *	the normal way, 66 and 99 MHz are called "Hyperspeed Mode"
- *	and have the rest of the chip running with 33 MHz.
- */
-
-static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
-{
-	u8 clockspeed_reg;    /* Clock Speed Register */
-
-	local_irq_disable();
-	outb_p(0x80, REG_CSCIR);
-	clockspeed_reg =3D inb_p(REG_CSCDR);
-	local_irq_enable();
-
-	if ((clockspeed_reg & 0xE0) =3D=3D 0xE0)
-		return 0;
-
-	/* Are we in CPU clock multiplied mode (66/99 MHz)? */
-	if ((clockspeed_reg & 0xE0) =3D=3D 0xC0) {
-		if ((clockspeed_reg & 0x01) =3D=3D 0)
-			return 66000;
-		else
-			return 99000;
-	}
-
-	/* 33 MHz is not 32 MHz... */
-	if ((clockspeed_reg & 0xE0) =3D=3D 0xA0)
-		return 33000;
-
-	return (1<<((clockspeed_reg & 0xE0) >> 5)) * 1000;
-}
-
-
-static int elanfreq_target(struct cpufreq_policy *policy,
-			    unsigned int state)
-{
-	/*
-	 * Access to the Elan's internal registers is indexed via
-	 * 0x22: Chip Setup & Control Register Index Register (CSCI)
-	 * 0x23: Chip Setup & Control Register Data  Register (CSCD)
-	 *
-	 */
-
-	/*
-	 * 0x40 is the Power Management Unit's Force Mode Register.
-	 * Bit 6 enables Hyperspeed Mode (66/100 MHz core frequency)
-	 */
-
-	local_irq_disable();
-	outb_p(0x40, REG_CSCIR);		/* Disable hyperspeed mode */
-	outb_p(0x00, REG_CSCDR);
-	local_irq_enable();		/* wait till internal pipelines and */
-	udelay(1000);			/* buffers have cleaned up          */
-
-	local_irq_disable();
-
-	/* now, set the CPU clock speed register (0x80) */
-	outb_p(0x80, REG_CSCIR);
-	outb_p(elan_multiplier[state].val80h, REG_CSCDR);
-
-	/* now, the hyperspeed bit in PMU Force Mode Register (0x40) */
-	outb_p(0x40, REG_CSCIR);
-	outb_p(elan_multiplier[state].val40h, REG_CSCDR);
-	udelay(10000);
-	local_irq_enable();
-
-	return 0;
-}
-/*
- *	Module init and exit code
- */
-
-static int elanfreq_cpu_init(struct cpufreq_policy *policy)
-{
-	struct cpuinfo_x86 *c =3D &cpu_data(0);
-	struct cpufreq_frequency_table *pos;
-
-	/* capability check */
-	if ((c->x86_vendor !=3D X86_VENDOR_AMD) ||
-	    (c->x86 !=3D 4) || (c->x86_model !=3D 10))
-		return -ENODEV;
-
-	/* max freq */
-	if (!max_freq)
-		max_freq =3D elanfreq_get_cpu_frequency(0);
-
-	/* table init */
-	cpufreq_for_each_entry(pos, elanfreq_table)
-		if (pos->frequency > max_freq)
-			pos->frequency =3D CPUFREQ_ENTRY_INVALID;
-
-	policy->freq_table =3D elanfreq_table;
-	return 0;
-}
-
-
-#ifndef MODULE
-/**
- * elanfreq_setup - elanfreq command line parameter parsing
- *
- * elanfreq command line parameter.  Use:
- *  elanfreq=3D66000
- * to set the maximum CPU frequency to 66 MHz. Note that in
- * case you do not give this boot parameter, the maximum
- * frequency will fall back to _current_ CPU frequency which
- * might be lower. If you build this as a module, use the
- * max_freq module parameter instead.
- */
-static int __init elanfreq_setup(char *str)
-{
-	max_freq =3D simple_strtoul(str, &str, 0);
-	pr_warn("You're using the deprecated elanfreq command line option. Use elan=
freq.max_freq instead, please!\n");
-	return 1;
-}
-__setup("elanfreq=3D", elanfreq_setup);
-#endif
-
-
-static struct cpufreq_driver elanfreq_driver =3D {
-	.get		=3D elanfreq_get_cpu_frequency,
-	.flags		=3D CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
-	.verify		=3D cpufreq_generic_frequency_table_verify,
-	.target_index	=3D elanfreq_target,
-	.init		=3D elanfreq_cpu_init,
-	.name		=3D "elanfreq",
-};
-
-static const struct x86_cpu_id elan_id[] =3D {
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 10, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, elan_id);
-
-static int __init elanfreq_init(void)
-{
-	if (!x86_match_cpu(elan_id))
-		return -ENODEV;
-	return cpufreq_register_driver(&elanfreq_driver);
-}
-
-
-static void __exit elanfreq_exit(void)
-{
-	cpufreq_unregister_driver(&elanfreq_driver);
-}
-
-
-module_param(max_freq, int, 0444);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, "
-		"Sven Geggus <sven@geggus.net>");
-MODULE_DESCRIPTION("cpufreq driver for AMD's Elan CPUs");
-
-module_init(elanfreq_init);
-module_exit(elanfreq_exit);
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
deleted file mode 100644
index b360f03..0000000
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
-static struct cpufreq_frequency_table sc520_freq_table[] =3D {
-	{0, 0x01,	100000},
-	{0, 0x02,	133000},
-	{0, 0,	CPUFREQ_TABLE_END},
-};
-
-static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
-{
-	u8 clockspeed_reg =3D *cpuctl;
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
-static int sc520_freq_target(struct cpufreq_policy *policy, unsigned int sta=
te)
-{
-
-	u8 clockspeed_reg;
-
-	local_irq_disable();
-
-	clockspeed_reg =3D *cpuctl & ~0x03;
-	*cpuctl =3D clockspeed_reg | sc520_freq_table[state].driver_data;
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
-	struct cpuinfo_x86 *c =3D &cpu_data(0);
-
-	/* capability check */
-	if (c->x86_vendor !=3D X86_VENDOR_AMD ||
-	    c->x86 !=3D 4 || c->x86_model !=3D 9)
-		return -ENODEV;
-
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency =3D 1000000; /* 1ms */
-	policy->freq_table =3D sc520_freq_table;
-
-	return 0;
-}
-
-
-static struct cpufreq_driver sc520_freq_driver =3D {
-	.get	=3D sc520_freq_get_cpu_frequency,
-	.verify	=3D cpufreq_generic_frequency_table_verify,
-	.target_index =3D sc520_freq_target,
-	.init	=3D sc520_freq_cpu_init,
-	.name	=3D "sc520_freq",
-};
-
-static const struct x86_cpu_id sc520_ids[] =3D {
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
-	cpuctl =3D ioremap((unsigned long)(MMCR_BASE + OFFS_CPUCTL), 1);
-	if (!cpuctl) {
-		pr_err("sc520_freq: error: failed to remap memory\n");
-		return -ENOMEM;
-	}
-
-	err =3D cpufreq_register_driver(&sc520_freq_driver);
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
