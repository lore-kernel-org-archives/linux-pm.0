From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 14/22] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Wed, 4 Jan 2017 07:21:07 -0600
Message-ID: <20170104132107.tciklylgqvhftb6f@rob-hp-laptop>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-15-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102163723.7939-15-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz, bonbons@linux-vserver.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 02, 2017 at 05:37:14PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
> 
> This patch adds the DT binding documentation for the battery power
> supply which gets various data from the PMIC, such as the battery status
> (charging, discharging, full, dead), current max limit, current current,
> battery capacity (in percentage), voltage max and min limits, current
> voltage and battery capacity (in Ah).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../bindings/power/supply/axp20x_battery.txt       | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> new file mode 100644
> index 0000000..5489d0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -0,0 +1,27 @@
> +AXP20x and AXP22x battery power supply
> +
> +Required Properties:
> + - compatible, one of:
> +			"x-powers,axp209-battery-power-supply"
> +			"x-powers,axp221-battery-power-supply"
> + - io-channels: phandles to battery voltage, charge and discharge
> + currents ADC channels
> + - io-channel-names = "batt_v", "batt_chrg_i", "batt_dischrg_i";
> +
> +This node is a subnode of the axp20x/axp22x PMIC.
> +
> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
> +ADC.
> +
> +Example:
> +
> +&axp209 {
> +	battery_power_supply: battery_power_supply {

Humm, I guess you power-supply is not sufficient, so 
'battery-power-supply' and similar for ac.

> +		compatible = "x-powers,axp209-battery-power-supply";
> +		io-channels = <&axp209_adc 7>, <&axp209_adc 8>,
> +			<&axp209_adc 9>;
> +		io-channel-names = "batt_v", "batt_chrg_i",
> +			"batt_dischrg_i";
> +	}
> +};
> -- 
> 2.9.3
> 
