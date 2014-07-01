From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 02/16] ARM: mvebu: Add a common function for the boot
 address work around
Date: Tue, 1 Jul 2014 16:34:28 +0200
Message-ID: <20140701163428.23408c9d@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36204 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757595AbaGAO5Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 10:57:16 -0400
In-Reply-To: <1403875377-940-3-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:43 +0200, Gregory CLEMENT wrote:

> +extern unsigned char mvebu_boot_wa_start;
> +extern unsigned char mvebu_boot_wa_end;
> +
> +void mvebu_boot_addr_wa(int crypto_eng_id, u32 resume_addr_reg)
> +{
> +	void __iomem *sram_virt_base;
> +	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
> +
> +	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
> +	mvebu_mbus_add_window_by_id(crypto_eng_id, CRYPT0_ENG_ATTR,
> +				SRAM_PHYS_BASE, SZ_64K);
> +	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
> +
> +
> +	memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
> +	/*
> +	 * The last word of the code copied in SRAM must contain the
> +	 * physical base address of the PMSU register
> +	 */
> +	*(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;

Contrary to what I said, use __raw_writel() and not writel() here, to
keep the native endianness of the system when writing the value:

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 9c56f8c..2b37e01 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -135,9 +135,11 @@ void mvebu_boot_addr_wa(int crypto_eng_id, u32 resume_addr_reg)
        memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
        /*
         * The last word of the code copied in SRAM must contain the
-        * physical base address of the PMSU register
+        * physical base address of the PMSU register. We
+        * intentionally store this address in the native endianness
+        * of the system.
         */
-       *(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;
+       __raw_writel(resume_addr_reg, sram_virt_base + code_len - 4);
 }

> +.global mvebu_boot_wa_start
> +.global mvebu_boot_wa_end
> +
> +/* The following code will be executed from SRAM */
> +ENTRY(mvebu_boot_wa_start)
> +mvebu_boot_wa_start:
> +/* use physical address of the boot address register register */
> +	adr     r0, 1f
> +	ldr     r0, [r0]
> +	ldr     r0, [r0]
> +	mov     pc, r0
> +/*
> + * the last word of this piece of code will be filled by the physical
> + * address of the boot address register just after being copied in SRAM
> + */
> +1:
> +	.long   .
> +mvebu_boot_wa_end:
> +ENDPROC(mvebu_boot_wa_end)

And this needs to be changed a bit to work properly in a big-endian
configuration:

diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index 15b823d..2f8b021 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -43,11 +43,14 @@ ENDPROC(armada_38x_cpu_resume)
 /* The following code will be executed from SRAM */
 ENTRY(mvebu_boot_wa_start)
 mvebu_boot_wa_start:
-/* use physical address of the boot address register register */
+ARM_BE8(setend be )                    @ go BE8 if entered LE
        adr     r0, 1f
-       ldr     r0, [r0]
-       ldr     r0, [r0]
-       mov     pc, r0
+       ldr     r0, [r0]                @ load the address of the
+                                       @ resume register
+       ldr     r0, [r0]                @ load the value in the
+                                       @ resume register
+ARM_BE8(rev    r0, r0)                 @ the value is stored LE
+       mov     pc, r0                  @ jump to this value

Note that the first ldr r0, [r0] does not need a rev r0, r0 because the
value is stored in the native endianness of the system thanks to the
__raw_writel() mentioned before. However, the second ldr r0, [r0] reads
the value in the Resume Address register, which is written in
little-endian by the writel() call in mvebu_pmsu_set_cpu_boot_addr().

Could you include this in your next iteration of the patches?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
