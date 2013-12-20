From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 1/2] ARM: imx6sl: Add cpu frequency scaling support
Date: Fri, 20 Dec 2013 13:56:43 +0800
Message-ID: <20131220055642.GN7172@S2101-09.ap.freescale.net>
References: <1387512929-7304-1-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387512929-7304-1-git-send-email-john.tobias.ph@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, rjw@rjwysocki.net, festevam@gmail.com, b20788@freescale.com, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 08:15:28PM -0800, John Tobias wrote:
> Re-use imx6q cpufreq driver to support cpu
> frequency scaling on imx6sl.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>

This one is already applied, so you do not have to resend.

Shawn

> ---
>  arch/arm/mach-imx/mach-imx6sl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 2f952e3..3072e15 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -34,6 +34,13 @@ static void __init imx6sl_fec_init(void)
>  	}
>  }
>  
> +static void __init imx6sl_init_late(void)
> +{
> +	/* imx6sl reuses imx6q cpufreq driver */
> +	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> +		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
> +}
> +
>  static void __init imx6sl_init_machine(void)
>  {
>  	struct device *parent;
> @@ -70,6 +77,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
>  	.map_io		= debug_ll_io_init,
>  	.init_irq	= imx6sl_init_irq,
>  	.init_machine	= imx6sl_init_machine,
> +	.init_late      = imx6sl_init_late,
>  	.dt_compat	= imx6sl_dt_compat,
>  	.restart	= mxc_restart,
>  MACHINE_END
> -- 
> 1.8.3.2
> 

