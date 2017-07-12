From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dts: imx6sx: Use nvmem-cells for tempmon
Date: Wed, 12 Jul 2017 14:40:43 +0800
Message-ID: <20170712064041.GE3172@dragon>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
 <6dc9bb756daf75bb26648b06b204872f71b3a548.1499347157.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6dc9bb756daf75bb26648b06b204872f71b3a548.1499347157.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 06, 2017 at 04:20:43PM +0300, Leonard Crestez wrote:
> On imx6sx accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first. Use the nvmem-cells binding instead.
> 
> This requirement does not apply to older imx6qdl chips because there the
> ocotp access clock (clk_ipg_s) is always enabled.
> 
> This is visible by comparing the "System Clocks, Gating, and Override"
> tables (OCOTP rows) in the 6DQ and 6SX manuals:
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6SXRM.pdf
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> 
> This happens to work right now because the ocotp clock might be enabled
> for some other reason. In particular the it might be enabled from the
> bootloader and it only gets disabled late during boot in
> clk_disable_unused, after imx-thermal has completed probing.
> 
> If imx-thermal is compiled as a module then the system can hang on
> probe.
> 
> Reported-by: Lothar Waﬂmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
> Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index f16b9df..5cfee85 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -675,7 +675,8 @@
>  				compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
>  				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>  				fsl,tempmon = <&anatop>;
> -				fsl,tempmon-data = <&ocotp>;
> +				nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> +				nvmem-cell-names = "calib", "temp_grade";
>  				clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
>  			};
>  
> @@ -993,9 +994,17 @@
>  			};
>  
>  			ocotp: ocotp@021bc000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				compatible = "fsl,imx6sx-ocotp", "syscon";
>  				reg = <0x021bc000 0x4000>;
>  				clocks = <&clks IMX6SX_CLK_OCOTP>;

Please have a newline between child node and property list ...

> +				tempmon_calib: calib {
> +					reg = <56 4>;
> +				};

... and between child nodes as well.

> +				tempmon_temp_grade: temp_grade {

We prefer to use hyphen rather than underscore in node name.  And node
name should have a corresponding unit-address, if the node has a 'reg'
property.

Shawn

> +					reg = <32 4>;
> +				};
>  			};
>  
>  			sai1: sai@021d4000 {
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
