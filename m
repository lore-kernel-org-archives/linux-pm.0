From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 2/3] ARM: berlin: register cpufreq-dt for the BG2Q
Date: Fri, 31 Jul 2015 14:16:02 +0800
Message-ID: <20150731141602.28b28f21@xhacker>
References: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
	<1438259752-16320-3-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:14729 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179AbbGaGUB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:20:01 -0400
In-Reply-To: <1438259752-16320-3-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, zmxu@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Antoine, 

On Thu, 30 Jul 2015 14:35:51 +0200
Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> The BG2Q SoC uses cpufreq-dt for cpufreq. Register a platform device for
> this.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  arch/arm/mach-berlin/berlin.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> index ac181c6797ee..0de906374994 100644
> --- a/arch/arm/mach-berlin/berlin.c
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -15,9 +15,21 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  
> +static const struct of_device_id berlin2q_match[] = {
> +	{ .compatible = "marvell,berlin2q" },
> +	{ },
> +};
> +
> +static void __init berlin_init_late(void)
> +{
> +	if (of_find_matching_node(NULL, berlin2q_match))
> +		platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

I'm not sure is it acceptable to always register cpufreq-dt platform device.
In cpufreq-dt driver, the probe will exit if there's no cpuclk node.

> +}
> +
>  static const char * const berlin_dt_compat[] = {
>  	"marvell,berlin",
>  	NULL,
> @@ -25,6 +37,7 @@ static const char * const berlin_dt_compat[] = {
>  
>  DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
>  	.dt_compat	= berlin_dt_compat,
> +	.init_late	= berlin_init_late,
>  	/*
>  	 * with DT probing for L2CCs, berlin_init_machine can be removed.
>  	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc

