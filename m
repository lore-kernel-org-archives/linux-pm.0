Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CB3AE1AF;
	Thu,  7 May 2026 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144314; cv=none; b=eH7YPt9eUlueDNKb667MW1107sZpxe63Lhhrm9Xj3qTHBgsHp4tq0uvvh53qUj4xPro6nW0wxvB2y8ANzLoV2GNlOQ6rEYwQ01mDE4/6pDc4H7X0G15e6Cf1knciaF0aWNQ7cHdSNCfDwwLY4XNREWPOesRgiAtCmJ47V57NsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144314; c=relaxed/simple;
	bh=c+AMYaVSpNmXDeiYLhix81XGrb8e3IIdeCn6xT12faE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc67FKZFx4uxgYHpN7g1aFS6Lsu2i5okBbFU4S5hklziYyZPXLP3pqZeNGkAweY44n6e0jqwyI0V1VIByS6pNjWFdXmAI/e8xcmk6O43BhJNP3jI5KtyxX3S9MEDzJgr35WdYiA3bBKz2EWfsP/j/0lmxkoFm9loHn9F2aqwmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=TA/xHZcu; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="TA/xHZcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1778144301; bh=c+AMYaVSpNmXDeiYLhix81XGrb8e3IIdeCn6xT12faE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA/xHZcuoy8qafv81B4i8rKRxtIF9x22aHjt5u7vSbydiOBTHJjDqIftED4TX+n0i
	 Ub4SN8rS01RXH67SUhgOuECL3ejPmKVFoYBWSIkE+6pLTtbp1gXjJLUs7jTZI8svIE
	 QYUXjj9ElXMguCg8Zyxf84KFldH6sMxG2GcF97GcH5oUBlh1QsEMB9z8xDAyMEt0zi
	 NAHkRLN/jSd7mF9F39RU9GdVFFpeknszB3na9XvElzX13G+cOTp8T2KV9wdH/buJt1
	 EOp8S8HmOoc3d0zPL0Usj/5BWEnHSXu7RLxuwi9Oe2yiEsDCcoswP/p5/vK57hJJa8
	 i0Ht2VROsP/fA==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 65F4141CDC; Thu, 07 May 2026 09:58:21 +0100 (BST)
Date: Thu, 7 May 2026 09:58:21 +0100
From: Sean Young <sean@mess.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] cpufreq: elanfreq: Drop support for AMD Elan SC4*
Message-ID: <afxULci9-K9o90Ag@extorris.mess.org>
References: <cover.1778071745.git.sean@mess.org>
 <ab6775ddd8aa71f3a5a329500de24ff7f5c25ac8.1778071745.git.sean@mess.org>
 <1680200e-453f-4a2b-b407-4f703dd0a541@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680200e-453f-4a2b-b407-4f703dd0a541@oss.qualcomm.com>

On Thu, May 07, 2026 at 12:50:55PM +0800, Zhongqiu Han wrote:
> On 5/6/2026 10:42 PM, Sean Young wrote:
> > Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> > the AMD Elan SC4* is no longer supported, so the cpu frequency
> > driver is no longer needed.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >   drivers/cpufreq/Kconfig.x86 |  15 ---
> >   drivers/cpufreq/Makefile    |   1 -
> >   drivers/cpufreq/elanfreq.c  | 226 ------------------------------------
> >   3 files changed, 242 deletions(-)
> >   delete mode 100644 drivers/cpufreq/elanfreq.c
> > 
> 
> Thanks Sean,
> 
> One minor nit: now that the elanfreq driver and its setup code are
> removed, should the corresponding elanfreq= entry in
> Documentation/admin-guide/kernel-parameters.txt be dropped as well?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=linux-next#n1671

Yes, good catch. I'll send out a v2 shortly.

Thanks,

Sean

> 
> 
> > diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> > index 865b290b01ff..c42dd39e0b2a 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -126,21 +126,6 @@ config X86_ACPI_CPUFREQ_CPB
> >   	  By enabling this option the acpi_cpufreq driver provides the old
> >   	  entry in addition to the new boost ones, for compatibility reasons.
> > -config ELAN_CPUFREQ
> > -	tristate "AMD Elan SC400 and SC410"
> > -	depends on MELAN
> > -	help
> > -	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
> > -	  processors.
> > -
> > -	  You need to specify the processor maximum speed as boot
> > -	  parameter: elanfreq=maxspeed (in kHz) or as module
> > -	  parameter "max_freq".
> > -
> > -	  For details, take a look at <file:Documentation/cpu-freq/>.
> > -
> > -	  If in doubt, say N.
> > -
> >   config X86_POWERNOW_K6
> >   	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
> >   	depends on X86_32
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 96196edf79d5..6c7a39b7f8d2 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -40,7 +40,6 @@ obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> >   obj-$(CONFIG_X86_POWERNOW_K7)		+= powernow-k7.o
> >   obj-$(CONFIG_X86_LONGHAUL)		+= longhaul.o
> >   obj-$(CONFIG_X86_E_POWERSAVER)		+= e_powersaver.o
> > -obj-$(CONFIG_ELAN_CPUFREQ)		+= elanfreq.o
> >   obj-$(CONFIG_X86_LONGRUN)		+= longrun.o
> >   obj-$(CONFIG_X86_GX_SUSPMOD)		+= gx-suspmod.o
> >   obj-$(CONFIG_X86_SPEEDSTEP_ICH)		+= speedstep-ich.o
> > diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
> > deleted file mode 100644
> > index fc5a58088b35..000000000000
> > --- a/drivers/cpufreq/elanfreq.c
> > +++ /dev/null
> > @@ -1,226 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-or-later
> > -/*
> > - *	elanfreq:	cpufreq driver for the AMD ELAN family
> > - *
> > - *	(c) Copyright 2002 Robert Schwebel <r.schwebel@pengutronix.de>
> > - *
> > - *	Parts of this code are (c) Sven Geggus <sven@geggus.net>
> > - *
> > - *      All Rights Reserved.
> > - *
> > - *	2002-02-13: - initial revision for 2.4.18-pre9 by Robert Schwebel
> > - */
> > -
> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > -
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > -#include <linux/init.h>
> > -
> > -#include <linux/delay.h>
> > -#include <linux/cpufreq.h>
> > -
> > -#include <asm/cpu_device_id.h>
> > -#include <linux/timex.h>
> > -#include <linux/io.h>
> > -
> > -#define REG_CSCIR 0x22		/* Chip Setup and Control Index Register    */
> > -#define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
> > -
> > -/* Module parameter */
> > -static int max_freq;
> > -
> > -struct s_elan_multiplier {
> > -	int clock;		/* frequency in kHz                         */
> > -	int val40h;		/* PMU Force Mode register                  */
> > -	int val80h;		/* CPU Clock Speed Register                 */
> > -};
> > -
> > -/*
> > - * It is important that the frequencies
> > - * are listed in ascending order here!
> > - */
> > -static struct s_elan_multiplier elan_multiplier[] = {
> > -	{1000,	0x02,	0x18},
> > -	{2000,	0x02,	0x10},
> > -	{4000,	0x02,	0x08},
> > -	{8000,	0x00,	0x00},
> > -	{16000,	0x00,	0x02},
> > -	{33000,	0x00,	0x04},
> > -	{66000,	0x01,	0x04},
> > -	{99000,	0x01,	0x05}
> > -};
> > -
> > -static struct cpufreq_frequency_table elanfreq_table[] = {
> > -	{0, 0,	1000},
> > -	{0, 1,	2000},
> > -	{0, 2,	4000},
> > -	{0, 3,	8000},
> > -	{0, 4,	16000},
> > -	{0, 5,	33000},
> > -	{0, 6,	66000},
> > -	{0, 7,	99000},
> > -	{0, 0,	CPUFREQ_TABLE_END},
> > -};
> > -
> > -
> > -/**
> > - *	elanfreq_get_cpu_frequency: determine current cpu speed
> > - *
> > - *	Finds out at which frequency the CPU of the Elan SOC runs
> > - *	at the moment. Frequencies from 1 to 33 MHz are generated
> > - *	the normal way, 66 and 99 MHz are called "Hyperspeed Mode"
> > - *	and have the rest of the chip running with 33 MHz.
> > - */
> > -
> > -static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
> > -{
> > -	u8 clockspeed_reg;    /* Clock Speed Register */
> > -
> > -	local_irq_disable();
> > -	outb_p(0x80, REG_CSCIR);
> > -	clockspeed_reg = inb_p(REG_CSCDR);
> > -	local_irq_enable();
> > -
> > -	if ((clockspeed_reg & 0xE0) == 0xE0)
> > -		return 0;
> > -
> > -	/* Are we in CPU clock multiplied mode (66/99 MHz)? */
> > -	if ((clockspeed_reg & 0xE0) == 0xC0) {
> > -		if ((clockspeed_reg & 0x01) == 0)
> > -			return 66000;
> > -		else
> > -			return 99000;
> > -	}
> > -
> > -	/* 33 MHz is not 32 MHz... */
> > -	if ((clockspeed_reg & 0xE0) == 0xA0)
> > -		return 33000;
> > -
> > -	return (1<<((clockspeed_reg & 0xE0) >> 5)) * 1000;
> > -}
> > -
> > -
> > -static int elanfreq_target(struct cpufreq_policy *policy,
> > -			    unsigned int state)
> > -{
> > -	/*
> > -	 * Access to the Elan's internal registers is indexed via
> > -	 * 0x22: Chip Setup & Control Register Index Register (CSCI)
> > -	 * 0x23: Chip Setup & Control Register Data  Register (CSCD)
> > -	 *
> > -	 */
> > -
> > -	/*
> > -	 * 0x40 is the Power Management Unit's Force Mode Register.
> > -	 * Bit 6 enables Hyperspeed Mode (66/100 MHz core frequency)
> > -	 */
> > -
> > -	local_irq_disable();
> > -	outb_p(0x40, REG_CSCIR);		/* Disable hyperspeed mode */
> > -	outb_p(0x00, REG_CSCDR);
> > -	local_irq_enable();		/* wait till internal pipelines and */
> > -	udelay(1000);			/* buffers have cleaned up          */
> > -
> > -	local_irq_disable();
> > -
> > -	/* now, set the CPU clock speed register (0x80) */
> > -	outb_p(0x80, REG_CSCIR);
> > -	outb_p(elan_multiplier[state].val80h, REG_CSCDR);
> > -
> > -	/* now, the hyperspeed bit in PMU Force Mode Register (0x40) */
> > -	outb_p(0x40, REG_CSCIR);
> > -	outb_p(elan_multiplier[state].val40h, REG_CSCDR);
> > -	udelay(10000);
> > -	local_irq_enable();
> > -
> > -	return 0;
> > -}
> > -/*
> > - *	Module init and exit code
> > - */
> > -
> > -static int elanfreq_cpu_init(struct cpufreq_policy *policy)
> > -{
> > -	struct cpuinfo_x86 *c = &cpu_data(0);
> > -	struct cpufreq_frequency_table *pos;
> > -
> > -	/* capability check */
> > -	if ((c->x86_vendor != X86_VENDOR_AMD) ||
> > -	    (c->x86 != 4) || (c->x86_model != 10))
> > -		return -ENODEV;
> > -
> > -	/* max freq */
> > -	if (!max_freq)
> > -		max_freq = elanfreq_get_cpu_frequency(0);
> > -
> > -	/* table init */
> > -	cpufreq_for_each_entry(pos, elanfreq_table)
> > -		if (pos->frequency > max_freq)
> > -			pos->frequency = CPUFREQ_ENTRY_INVALID;
> > -
> > -	policy->freq_table = elanfreq_table;
> > -	return 0;
> > -}
> > -
> > -
> > -#ifndef MODULE
> > -/**
> > - * elanfreq_setup - elanfreq command line parameter parsing
> > - *
> > - * elanfreq command line parameter.  Use:
> > - *  elanfreq=66000
> > - * to set the maximum CPU frequency to 66 MHz. Note that in
> > - * case you do not give this boot parameter, the maximum
> > - * frequency will fall back to _current_ CPU frequency which
> > - * might be lower. If you build this as a module, use the
> > - * max_freq module parameter instead.
> > - */
> > -static int __init elanfreq_setup(char *str)
> > -{
> > -	max_freq = simple_strtoul(str, &str, 0);
> > -	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
> > -	return 1;
> > -}
> > -__setup("elanfreq=", elanfreq_setup);
> > -#endif
> > -
> > -
> > -static struct cpufreq_driver elanfreq_driver = {
> > -	.get		= elanfreq_get_cpu_frequency,
> > -	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
> > -	.verify		= cpufreq_generic_frequency_table_verify,
> > -	.target_index	= elanfreq_target,
> > -	.init		= elanfreq_cpu_init,
> > -	.name		= "elanfreq",
> > -};
> > -
> > -static const struct x86_cpu_id elan_id[] = {
> > -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 10, NULL),
> > -	{}
> > -};
> > -MODULE_DEVICE_TABLE(x86cpu, elan_id);
> > -
> > -static int __init elanfreq_init(void)
> > -{
> > -	if (!x86_match_cpu(elan_id))
> > -		return -ENODEV;
> > -	return cpufreq_register_driver(&elanfreq_driver);
> > -}
> > -
> > -
> > -static void __exit elanfreq_exit(void)
> > -{
> > -	cpufreq_unregister_driver(&elanfreq_driver);
> > -}
> > -
> > -
> > -module_param(max_freq, int, 0444);
> > -
> > -MODULE_LICENSE("GPL");
> > -MODULE_AUTHOR("Robert Schwebel <r.schwebel@pengutronix.de>, "
> > -		"Sven Geggus <sven@geggus.net>");
> > -MODULE_DESCRIPTION("cpufreq driver for AMD's Elan CPUs");
> > -
> > -module_init(elanfreq_init);
> > -module_exit(elanfreq_exit);
> 
> 
> -- 
> Thx and BRs,
> Zhongqiu Han
