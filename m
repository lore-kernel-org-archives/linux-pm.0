From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V4 2/3] ARM: imx: add vddsoc/pu setpoint info into dts
Date: Thu, 19 Dec 2013 11:06:49 +0800
Message-ID: <20131219030646.GQ6691@S2101-09.ap.freescale.net>
References: <1387462609-13013-1-git-send-email-b20788@freescale.com>
 <1387462609-13013-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387462609-13013-2-git-send-email-b20788@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 09:16:48AM -0500, Anson Huang wrote:
> i.MX6Q needs to update vddarm, vddsoc/pu regulators when cpu freq
> is changed, each setpoint has different voltage, so we need to
> pass vddarm, vddsoc/pu's freq-voltage info from dts together.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied after changing patch subject to be 'ARM: dts: imx6q: add
vddsoc/pu setpoint info'.

Shawn

> ---
>  arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7e8332..021e0cb 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -30,6 +30,13 @@
>  				792000  1150000
>  				396000  975000
>  			>;
> +			fsl,soc-operating-points = <
> +				/* ARM kHz  SOC-PU uV */
> +				1200000 1275000
> +				996000	1250000
> +				792000	1175000
> +				396000	1175000
> +			>;
>  			clock-latency = <61036>; /* two CLK32 periods */
>  			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
>  				 <&clks 17>, <&clks 170>;
> -- 
> 1.7.9.5
> 
> 

