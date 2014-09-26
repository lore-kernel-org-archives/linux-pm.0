From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 5/5] ARM: imx53: add cpufreq support
Date: Fri, 26 Sep 2014 11:02:37 +0800
Message-ID: <20140926030236.GB31948@dragon>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
 <1411143381-10516-6-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1411143381-10516-6-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 19, 2014 at 06:16:21PM +0200, Lucas Stach wrote:
> Instanciate the platform device for the generic cpufreq-cpu0
> driver and add all required properties to the DT.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx53.dtsi   | 13 ++++++++++++-
>  arch/arm/mach-imx/mach-imx53.c |  4 ++++

Please split dts and kernel changes.

>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 64fa27b36be0..bd5226a7ea20 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -46,10 +46,21 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a8";
>  			reg = <0x0>;
> +			clocks = <&clks IMX5_CLK_ARM>;
> +			clock-latency = <61036>;
> +			voltage-tolerance = <5>;
> +			operating-points = <
> +				/* kHz */
> +				 166666  850000
> +				 400000  900000
> +				 800000 1050000
> +				1000000 1200000
> +				1200000 1300000
> +			>;
>  		};
>  	};
>  
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 03dd6ea13acc..4eb6849c52d2 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -38,9 +38,13 @@ static void __init imx53_dt_init(void)
>  	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
>  }
>  
> +static struct platform_device imx53_cpufreq_pdev = { .name = "cpufreq-cpu0", };
> +
>  static void __init imx53_init_late(void)
>  {
>  	imx53_pm_init();
> +
> +	platform_device_register(&imx53_cpufreq_pdev);

It should be a bit easier to call the following.

	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);

Shawn

>  }
>  
>  static const char * const imx53_dt_board_compat[] __initconst = {
> -- 
> 2.1.0
> 
