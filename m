From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 5/5] ARM: vexpress/TC2: register vexpress-spc cpufreq
 device
Date: Fri, 18 Oct 2013 14:58:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310181457010.1951@syhkavp.arg>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1381931563-16785-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53330 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597Ab3JRS7H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2013 14:59:07 -0400
Received: by mail-qc0-f181.google.com with SMTP id w4so2263403qcr.12
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2013 11:59:05 -0700 (PDT)
In-Reply-To: <1381931563-16785-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Pawel Moll <Pawel.Moll@arm.com>

On Wed, 16 Oct 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch adds vexpress-spc platform device to enables the vexpress
> SPC cpufreq interface driver.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Cc: Pawel Moll <Pawel.Moll@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-vexpress/spc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index a8b8310..4ddfbfe 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -25,6 +25,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/opp.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/semaphore.h>
>  
> @@ -532,6 +533,7 @@ static int __init ve_spc_clk_init(void)
>  			pr_warn("failed to initialise cpu%d opp table\n", cpu);
>  	}
>  
> +	platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
>  	return 0;
>  }
>  module_init(ve_spc_clk_init);

OK... this solves my concern about initcall ordering.  Please just 
disregard my suggestions on patch #3.  I'd suggest folding this patch 
into patch 3/5 though.


Nicolas
