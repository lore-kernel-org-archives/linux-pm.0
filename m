From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/4] ARM: imx: add VDDSOC/PU setpoint info into dts
Date: Tue, 17 Dec 2013 09:40:15 +0800
Message-ID: <20131217014013.GB6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387228450-641-1-git-send-email-b20788@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 16, 2013 at 04:14:09PM -0500, Anson Huang wrote:
> i.MX6Q needs to update VDDARM, VDDSOC/PU regulator when CPUFreq
> is changed, each setpoint has different voltage, so we need to
> pass VDDARM, VDDSOC/PU's freq-voltage info from dts.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7e8332..03da628 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -30,6 +30,13 @@
>  				792000  1150000
>  				396000  975000
>  			>;
> +			fsl,soc-operating-points = <
> +			/* ARM kHz  SOC-PU uV */
> +				1200000	1275000
> +				996000	1250000
> +				792000	1175000
> +				396000	1175000

Okay.  Now I get it why you're increasing VDDARM_CAP to 975mV in the
first patch.  You expect VDDSOC_CAP to be 1175mV rather than 1250mV for
396MHz operating-point, which is hard-coded in cpufreq driver right now.

Shawn

> +			>;
>  			clock-latency = <61036>; /* two CLK32 periods */
>  			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
>  				 <&clks 17>, <&clks 170>;
> -- 
> 1.7.9.5
> 
> 

