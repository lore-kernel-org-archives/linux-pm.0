From: Juergen Borleis <juergen@kreuzholzen.de>
Subject: Re: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
Date: Tue, 24 Mar 2015 21:45:23 +0100
Message-ID: <201503242145.26370.juergen@kreuzholzen.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-8-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426984203-9133-8-git-send-email-stefan.wahren@i2se.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, mark.rutland@arm.com, marex@denx.de, fabio.estevam@freescale.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, dbaryshkov@gmail.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, sre@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, broonie@kernel.org, kernel@pengutronix.de, galak@codeaurora.org, sebastien.szymanski@armadeus.com, shawn.guo@linaro.org, dwmw2@infradead.org
List-Id: linux-pm@vger.kernel.org

Stefan Wahren wrote:
> [...]
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 98c1be6..21c1921 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -38,12 +38,23 @@
>  	};
>
>  	cpus {
> -		#address-cells = <0>;
> +		#address-cells = <1>;
>  		#size-cells = <0>;
>
> -		cpu {
> +		cpu@0 {
>  			compatible = "arm,arm926ej-s";
>  			device_type = "cpu";
> +			reg = <0x0>;
> +			operating-points = <
> +				/* kHz	uV */
> +				261819  1350000
> +				360000  1350000
> +				392728  1450000
> +				454737  1550000
> +			>;
> +			clocks = <&clks 4>;
> +			clock-latency = <61036>; /* two CLK32 periods */
> +			cpu-supply = <&reg_vddd>;
>  		};
>  	};

Maybe you should take into account not to reduce VDD below 1.55 V if the SDRAM 
controller runs above 196 MHz. The i.MX28 datasheet[1] lists these 
restrictions. VDD powers the SDRAM controller as well. From the datasheet the 
table "Frequency versus Voltage for EMICLK" shows:
                     
             EMICLK Fmax (MHz)
VDDD (V)      DDR2       mDDR
--------------------------------
 1.550       205.71     205.71
 1.450       196.36     196.36
 1.350       196.36     196.36

jbe

[1]
  i.MX28 Applications
Processors for Consumer
     Products
  Silicon Version 1.2

Document Number: IMX28CEC
   Rev. 3, 07/2012
