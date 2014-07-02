From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 02/16] ARM: mvebu: Add a common function for the boot
 address work around
Date: Thu, 03 Jul 2014 00:58:32 +0200
Message-ID: <53B48E98.2080407@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-3-git-send-email-gregory.clement@free-electrons.com> <20140701163428.23408c9d@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46696 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751547AbaGBW6f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jul 2014 18:58:35 -0400
In-Reply-To: <20140701163428.23408c9d@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,


>> +	/*
>> +	 * The last word of the code copied in SRAM must contain the
>> +	 * physical base address of the PMSU register
>> +	 */
>> +	*(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;
> 
> Contrary to what I said, use __raw_writel() and not writel() here, to
> keep the native endianness of the system when writing the value:

Ok


[...]
> --- a/arch/arm/mach-mvebu/pmsu_ll.S
> +++ b/arch/arm/mach-mvebu/pmsu_ll.S
> @@ -43,11 +43,14 @@ ENDPROC(armada_38x_cpu_resume)
>  /* The following code will be executed from SRAM */
>  ENTRY(mvebu_boot_wa_start)
>  mvebu_boot_wa_start:
> -/* use physical address of the boot address register register */
> +ARM_BE8(setend be )                    @ go BE8 if entered LE
>         adr     r0, 1f
> -       ldr     r0, [r0]
> -       ldr     r0, [r0]
> -       mov     pc, r0
> +       ldr     r0, [r0]                @ load the address of the
> +                                       @ resume register
> +       ldr     r0, [r0]                @ load the value in the
> +                                       @ resume register
> +ARM_BE8(rev    r0, r0)                 @ the value is stored LE
> +       mov     pc, r0                  @ jump to this value
> 
> Note that the first ldr r0, [r0] does not need a rev r0, r0 because the
> value is stored in the native endianness of the system thanks to the
> __raw_writel() mentioned before. However, the second ldr r0, [r0] reads
> the value in the Resume Address register, which is written in
> little-endian by the writel() call in mvebu_pmsu_set_cpu_boot_addr().
> 
> Could you include this in your next iteration of the patches?

Yes sure, and thanks again for having tested it in BE

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
