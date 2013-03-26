From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
Date: Tue, 26 Mar 2013 22:28:16 +0800
Message-ID: <20130326142813.GB7141@S2101-09.ap.freescale.net>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, linus.walleij@linaro.org, nsekhar@ti.com, kgene.kim@samsung.com, linux@arm.linux.org.uk, patches@linaro.org, magnus.damm@gmail.com, kevin.hilman@linaro.org, plagnioj@jcrosoft.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, ben-linux@fluff.org, tglx@linutronix.de, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 25, 2013 at 06:55:30PM +0100, Daniel Lezcano wrote:
> The initialization is done from the cpuidle framework.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index 5ae22f7..a783a63 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -6,7 +6,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include <linux/clockchips.h>
>  #include <linux/cpuidle.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> @@ -43,17 +42,6 @@ done:
>  	return index;
>  }
>  
> -/*
> - * For each cpu, setup the broadcast timer because local timer
> - * stops for the states other than WFI.
> - */
> -static void imx6q_setup_broadcast_timer(void *arg)
> -{
> -	int cpu = smp_processor_id();
> -
> -	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> -}
> -
>  static struct cpuidle_driver imx6q_cpuidle_driver = {
>  	.name = "imx6q_cpuidle",
>  	.owner = THIS_MODULE,
> @@ -84,8 +72,5 @@ int __init imx6q_cpuidle_init(void)
>  	/* Set chicken bit to get a reliable WAIT mode support */
>  	imx6q_set_chicken_bit();
>  
> -	/* Configure the broadcast timer on each cpu */
> -	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
> -
>  	return imx_cpuidle_init(&imx6q_cpuidle_driver);
>  }
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
