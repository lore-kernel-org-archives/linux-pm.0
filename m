From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 02/16] ARM: mvebu: Add a common function for the boot
 address work around
Date: Thu, 03 Jul 2014 00:58:22 +0200
Message-ID: <53B48E8E.1080808@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-3-git-send-email-gregory.clement@free-electrons.com> <20140630144054.2f71514b@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46683 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751535AbaGBW6Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jul 2014 18:58:25 -0400
In-Reply-To: <20140630144054.2f71514b@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,


> 
>> mvebu_boot_addr_wa().
> 
> I'm not sure the name of the function is appropriate, as we don't know
> what it is doing. Maybe mvebu_setup_boot_addr_wa() ?

I try to avoid too long name because then we have to do a lot of multiline
code. However I agree that this name is better, I will use it

> 
> Also, maybe your commit log should indicate that the workaround
> involves using the Crypto engine SRAM, which will help understanding
> the reference to the crypto engine in the code.
> 

OK

>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/mach-mvebu/pmsu.c    | 31 +++++++++++++++++++++++++++++++
>>  arch/arm/mach-mvebu/pmsu.h    |  1 +
>>  arch/arm/mach-mvebu/pmsu_ll.S | 19 +++++++++++++++++++
>>  3 files changed, 51 insertions(+)
> 
> I don't really have a better suggestion, but the workaround doesn't
> seem to be related to the PMSU, so are pmsu.c and pmsu_ll.S really the
> right files to store this code?
> 
>>
>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>> index 5584d35b8e88..991560905ccc 100644
>> --- a/arch/arm/mach-mvebu/pmsu.c
>> +++ b/arch/arm/mach-mvebu/pmsu.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/io.h>
>> +#include <linux/mbus.h>
>>  #include <linux/of_address.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/resource.h>
>> @@ -63,6 +64,14 @@ static void __iomem *pmsu_mp_base;
>>  #define L2C_NFABRIC_PM_CTL		    0x4
>>  #define L2C_NFABRIC_PM_CTL_PWR_DOWN		BIT(20)
>>  
>> +#define ARMADA_370_CRYPT0_ENG_ID	0x9
> 
> Not needed in this file, the MBus window target ID is passed as
> argument to the mvebu_boot_addr_wa() function.

OK
> 
>> +#define CRYPT0_ENG_ATTR	0x1
> 
> For consistency, I'd prefer to see this being passed as argument to
> mvebu_boot_addr_wa().

The attribute is the same, so why bother with it? If later we have a SoC
where this attribute can be different then I agree to add this argument.

> 
>> +#define SRAM_PHYS_BASE	    0xFFFF0000
>> +
>> +#define BOOTROM_BASE    0xFFF00000
>> +#define BOOTROM_SIZE    0x100000
>> +
>>  extern void ll_disable_coherency(void);
>>  extern void ll_enable_coherency(void);
>>  
>> @@ -85,6 +94,28 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>>  		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
>>  }
>>  
>> +extern unsigned char mvebu_boot_wa_start;
>> +extern unsigned char mvebu_boot_wa_end;
>> +
>> +void mvebu_boot_addr_wa(int crypto_eng_id, u32 resume_addr_reg)
> 
> unsigned int crypto_eng_target ('unsigned int' is the type used by
> the mvebu-mbus API), and add unsigned int crypto_eng_attribute, to
> match the mvebu-mbus API. Also, void * seems more appropriate than u32
> for an address, maybe even void __iomem * since it's actually pointing
> to a memory-mapped register.

I was lazy for the resume_addr_reg and u32 was easier to use, but indeed
void __iomem * is better. I also agree for the other, I didn't notice it
was unsigned int instead of int.

> 
>> +{
>> +	void __iomem *sram_virt_base;
>> +	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
>> +
>> +	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
>> +	mvebu_mbus_add_window_by_id(crypto_eng_id, CRYPT0_ENG_ATTR,
>> +				SRAM_PHYS_BASE, SZ_64K);
>> +	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
> 
> Maybe a return value check?

yes

> 
>> +
>> +
> 
> One too many new line.
> 
>> +	memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
>> +	/*
>> +	 * The last word of the code copied in SRAM must contain the
>> +	 * physical base address of the PMSU register
>> +	 */
>> +	*(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;
> 
> Maybe instead:
> 
> 	writel(resume_addr_reg, sram_virt_base + code_len - 4);

Oh yes I forgot it was "iomaped"


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
