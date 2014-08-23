From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/2] dt-bindings: document Rockchip thermal
Date: Sun, 24 Aug 2014 01:03:05 +0200
Message-ID: <1504889.nDzfjZj9xp@diego>
References: <1408752934-18318-1-git-send-email-caesar.wang@rock-chips.com>
 <1408752934-18318-2-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408752934-18318-2-git-send-email-caesar.wang@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, addy.ke@rock-chips.com, grant.linkely@linaro.org, xjq@rock-chips.com, linux-pm@vger.kernel.org, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, eduardo.valentin@ti.com, zyw@rock-chips.com, robh+dt@kernel.org, cf@rock-chips.com, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

Am Samstag, 23. August 2014, 08:15:33 schrieb Caesar Wang:
> This add the necessary binding documentation for the thermal
> found on Rockchip SoCs
> 
> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  .../bindings/thermal/rockchip-thermal.txt          |   33
> ++++++++++++++++++++ 1 file changed, 33 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt new file
> mode 100644
> index 0000000..b556eae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -0,0 +1,33 @@
> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> +
> +Required properties:
> +- compatible : "rockchip,rk3288-tsadc"
> +- reg : physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts : The interrupt number to the cpu. The interrupt specifier
> format +  depends on the interrupt controller.
> +- clocks : Must contain an entry for each entry in clock-names.
> +- clock-names : Shall be "tsadc_clk" for the transfer-clock, and
> "tsadc_pclk" for +    the peripheral clock.
> +Optional properties:
> +- clock-frequency : Thermal sensor's clock frequency.

see comment in patch2, this should probably use assigned-rate if at all 
necessary (and the assigned-rate is not necessary to document here)


> +- pinctrl-names : Should contain only one value - "default".
> +- pinctrl-0 : Should contain only one value - &tsadc_int.

in general pinctrl settings are just board-specific settings and do not
need to be part of the binding documentation.
And in this case, are you sure that the tsadc uses some pin as interrupt?
Because in the TRM the TS-ADC interrupt is number 69 of the GIC itself
and not some pin accessible via pinctrl.


> +- passive-temp : Temperature of trip 0.
> +- critical-temp : Temperature of trip 1.
> +- force-shut-temp : Temperature of force shut down.

please use the generic trip-points described in
Documentation/devicetree/bindings/thermal/thermal.txt
for this, instead of defining new properties


Heiko

> +Example:
> +
> +tsadc: tsadc@ff280000 {
> +	compatible = "rockchip,rk3288-tsadc";
> +	reg = <0xff280000 0x100>;
> +	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +	clock-frequency = <10000>;
> +	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> +	clock-names = "tsadc_clk", "tsadc_pclk";
> +	pinctrl-names = "default";
> +	pinctrl-1 = <&tsadc_int>;
> +	passive-temp = <80>;
> +	critical-temp = <100>;
> +	force-shut-temp = <120>;
> +};
