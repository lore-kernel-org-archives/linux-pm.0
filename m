From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 02/14] ARM: mvebu: ll_set_cpu_coherent no more uses
 the coherency address as parameter
Date: Mon, 14 Oct 2013 16:20:41 +0200
Message-ID: <20131014162041.185d797a@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:32913 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755535Ab3JNOUp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 10:20:45 -0400
In-Reply-To: <1381759106-15004-3-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:14 +0200, Gregory CLEMENT wrote:
> Until now the calling functions of ll_set_cpu_coherent() have to know
> the base address of the coherency registers. This commit doesn't
> expose anymore this address, and replace the argument by a flag to
> indicate if we have to use the physical or the virtual address.

Why is this necessary? Passing the base address (either physical or
virtual) seems much better than the boolean you're introducing.

The title of the commit is also badly worded I believe, "no more uses"
is not a really great way of expressing what it is doing. It should
probably be:

	ARM: mvebu: make ll_set_cpu_coherent use a boolean to choose coherency fabric address

Nonetheless, a few comments below.

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c    |  6 +++---
>  arch/arm/mach-mvebu/coherency_ll.S | 18 +++++++++++++++++-
>  arch/arm/mach-mvebu/headsmp.S      | 10 ++--------
>  3 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index 58adf2f..d492fb3 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -29,7 +29,7 @@
>  #include "armada-370-xp.h"
>  
>  unsigned long coherency_phys_base;
> -static void __iomem *coherency_base;
> +void __iomem *coherency_base;
>  static void __iomem *coherency_cpu_base;
>  
>  /* Coherency fabric registers */
> @@ -43,7 +43,7 @@ static struct of_device_id of_coherency_table[] = {
>  };
>  
>  /* Function defined in coherency_ll.S */
> -int ll_set_cpu_coherent(void __iomem *base_addr, unsigned int hw_cpu_id);
> +int ll_set_cpu_coherent(bool use_virt_addr, unsigned int hw_cpu_id);
>  
>  int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>  {
> @@ -53,7 +53,7 @@ int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>  		return 1;
>  	}
>  
> -	return ll_set_cpu_coherent(coherency_base, hw_cpu_id);
> +	return ll_set_cpu_coherent(true, hw_cpu_id);
>  }
>  
>  static inline void mvebu_hwcc_sync_io_barrier(void)
> diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
> index 5476669..8d4e22f 100644
> --- a/arch/arm/mach-mvebu/coherency_ll.S
> +++ b/arch/arm/mach-mvebu/coherency_ll.S
> @@ -22,10 +22,22 @@
>  
>  	.text
>  /*
> - * r0: Coherency fabric base register address
> + * r0: if r0==0 => physical addres, else virtual address

address, not addres. Also, which address are we talking about?

 * r0: if r0 equal 0, then the function will use access the coherency
   fabric through its physical address (to be used when the MMU is
   disabled). Otherwise, the virtual address at which the coherency
   fabric has been mapped will be used (to be used when the MMU is
   enabled).

But I still complain that the original solution of passing the address
was better. If you really have a strong explanation to switch to this
boolean, then don't use a boolean at all: test if the MMU is enabled,
and if not, use the physical address automatically, otherwise, use the
virtual address automatically.

>   * r1: HW CPU id
>   */
>  ENTRY(ll_set_cpu_coherent)
> +	cmp	r0, #0
> +	bne	1f
> +    /* use physical address */

Bad indentation for the comment: it should be one tab and not spaces,
not match the other code around.

> +	adr	r0, 3f

> +	ldr	r3, [r0]
> +	ldr	r0, [r0, r3]
> +	b	2f
> +1:
> +    /* use virtual address */

Same comment for the indentation.

> +	ldr	r0, =(coherency_base)

Are the parenthesis needed?

> +	ldr	r0, [r0]
> +2:
>  	/* Create bit by cpu index */
>  	mov	r3, #(1 << 24)
>  	lsl	r1, r3, r1
> @@ -53,3 +65,7 @@ ENTRY(ll_set_cpu_coherent)
>  	mov	r0, #0
>  	mov	pc, lr
>  ENDPROC(ll_set_cpu_coherent)
> +
> +	.align 2
> +3:
> +	.long	coherency_phys_base - .
> diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
> index 8a1b0c9..bffaabc 100644
> --- a/arch/arm/mach-mvebu/headsmp.S
> +++ b/arch/arm/mach-mvebu/headsmp.S
> @@ -27,10 +27,8 @@
>   * startup
>   */
>  ENTRY(armada_xp_secondary_startup)
> -	/* Get coherency fabric base physical address */
> -	adr	r0, 1f
> -	ldr	r1, [r0]
> -	ldr	r0, [r0, r1]
> +	/* Use physical addrss */

addrss -> address. Please pay attention to typos, there are such typos
everywhere.

Also, address of what?

> +	mov	r0, #0
>  
>  	/* Read CPU id */
>  	mrc     p15, 0, r1, c0, c0, 5
> @@ -41,7 +39,3 @@ ENTRY(armada_xp_secondary_startup)
>  	b	secondary_startup
>  
>  ENDPROC(armada_xp_secondary_startup)
> -
> -	.align 2
> -1:
> -	.long	coherency_phys_base - .



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
