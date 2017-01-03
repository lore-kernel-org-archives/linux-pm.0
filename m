From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
Date: Tue, 3 Jan 2017 17:20:35 -0600
Message-ID: <20170103232035.wwsqmea5dxzu2r5m@rob-hp-laptop>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170102163723.7939-2-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, jic23@kernel.org, icenowy@aosc.xyz
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 02, 2017 at 05:37:01PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
> 
> This adds the device tree binding documentation for the X-Powers AXP20X
> and AXP22X PMICs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/iio/adc/axp20x_adc.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> new file mode 100644
> index 0000000..1b60065
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> @@ -0,0 +1,24 @@
> +X-Powers AXP20X and AXP22X PMIC Analog to Digital Converter (ADC)
> +
> +The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> +battery voltage, battery charge and discharge currents, AC-in and VBUS
> +voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
> +
> +The AXP22X PMICs do not have all ADCs of the AXP20X though.
> +
> +Required properties:
> + - compatible, one of:
> +			"x-powers,axp209-adc"
> +			"x-powers,axp221-adc"
> + - #io-channel-cells = <1>;
> +
> +This is a subnode of the AXP20X PMIC.
> +
> +Example:
> +
> +&axp209 {
> +	axp209_adc: axp209_adc {

Use 'adc' for node name:

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "x-powers,axp209-adc";
> +		#io-channel-cells = <1>;
> +	};
> +};
> -- 
> 2.9.3
> 
