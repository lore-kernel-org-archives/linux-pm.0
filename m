From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] ARM: shmobile: sh7372: Keep D4 pm domain powered
Date: Mon, 27 Oct 2014 10:08:47 +0900
Message-ID: <20141027010846.GC30485@verge.net.au>
References: <1414063874-9533-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33283 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbaJ0BI4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Oct 2014 21:08:56 -0400
Content-Disposition: inline
In-Reply-To: <1414063874-9533-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 23, 2014 at 01:31:14PM +0200, Geert Uytterhoeven wrote:
> The D4 power domain contains the Coresight-ETM hardware block.
> As long as the ARM debug/perf code doesn't use resource management with
> runtime PM support, the D4 power domain must be kept powered to avoid a
> crash during resume from s2ram (dbg_cpu_pm_notify() calls
> reset_ctrl_regs() unconditionally, causing an undefined instruction
> oops).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested on real hardware, but a similar workaround is needed on r8a7740.

I have hardware in the form of a Mackerel board and I'm happy
to test this if it would help and you give me some guidance on how to do so.

>  arch/arm/mach-shmobile/pm-sh7372.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> index 7e5c2676c48902f1..cedffdd4b476adb4 100644
> --- a/arch/arm/mach-shmobile/pm-sh7372.c
> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -77,6 +77,16 @@
>  
>  #define PM_DOMAIN_ON_OFF_LATENCY_NS	250000
>  
> +static int sh7372_d4_pd_suspend(void)
> +{
> +	/*
> +	 * The D4 domain contains the Coresight-ETM hardware block and
> +	 * therefore it should only be turned off if the debug module is
> +	 * not in use.
> +	 */
> +	return -EBUSY;
> +}
> +
>  static int sh7372_a4r_pd_suspend(void)
>  {
>  	sh7372_intcs_suspend();
> @@ -131,6 +141,8 @@ static struct rmobile_pm_domain sh7372_pm_domains[] = {
>  		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
>  		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
>  		.bit_shift = 3,
> +		.gov = &pm_domain_always_on_gov,
> +		.suspend = sh7372_d4_pd_suspend,
>  	},
>  	{
>  		.genpd.name = "A4R",
> -- 
> 1.9.1
> 
