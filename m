From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 03/16] ARM: mvebu: Add function to export the physical
 address of the boot register
Date: Mon, 30 Jun 2014 14:46:20 +0200
Message-ID: <20140630144620.0030cf94@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54190 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755382AbaF3MqY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 08:46:24 -0400
In-Reply-To: <1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Gregory,

I'm not sure that the best approach to solve this problem. Instead,
maybe the system-controller.c code should set up the boot address
workaround on Armada 375. Since the workaround on 375 is really related
to setting the boot address which is done by the system controller,
maybe the initialization of the workaround belongs in
system-controller.c ?

On Fri, 27 Jun 2014 15:22:44 +0200, Gregory CLEMENT wrote:
> In order to boot the secondary CPUs on Armada 375 Z1, we need to read
> the boot address of these CPUs through a register part of the System
> Controller. This done very early where MMU is not enable yet, so we
> need to get the physical address of this register to use it.

I don't think that really explains what's going on here, maybe:

"As part of a workaround for a BootROM issue on Armada 375 Z1, a piece
of assembly code loaded into the Cryptographic Engine SRAM needs to
read the System Controller Resume Address register before the MMU is
enabled. We therefore need a way of getting the physical address for
the System Controller Resume Address register."

> In the previous version of this workaround the physical address were

were -> was.

> hardcoded whereas depending of the Mbus configuration this address may
> change.
> 
> This commit will allow to use the generic boot workaround function
> with the correct address.



> ---
>  arch/arm/mach-mvebu/common.h            |  1 +
>  arch/arm/mach-mvebu/system-controller.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index b67fb7a10d8b..6ad62cf8352c 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -20,6 +20,7 @@
>  void mvebu_restart(enum reboot_mode mode, const char *cmd);
>  int mvebu_cpu_reset_deassert(int cpu);
>  void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
> +u32 mvebu_system_controller_get_phys_addr(void);
>  void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
>  
>  void armada_xp_cpu_die(unsigned int cpu);
> diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
> index 0c5524ac75b7..ae6ab543aa36 100644
> --- a/arch/arm/mach-mvebu/system-controller.c
> +++ b/arch/arm/mach-mvebu/system-controller.c
> @@ -30,6 +30,7 @@
>  #include "common.h"
>  
>  static void __iomem *system_controller_base;
> +static u32 system_controller_phys_base;
>  
>  struct mvebu_system_controller {
>  	u32 rstoutn_mask_offset;
> @@ -109,6 +110,13 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
>  	writel(virt_to_phys(boot_addr), system_controller_base +
>  	       mvebu_sc->resume_boot_addr);
>  }
> +
> +u32 mvebu_system_controller_get_phys_addr(void)

phys_addr_t should be the return type.

> +{
> +	BUG_ON(system_controller_phys_base == NULL);
> +	BUG_ON(mvebu_sc->resume_boot_addr == 0);
> +	return system_controller_phys_base + mvebu_sc->resume_boot_addr;

So the function name suggests you're returning the base physical address
of the System Controller registers, while you're in fact returning the
physical address of one particular register (the Resume Address one). I
believe the function is misnamed.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
