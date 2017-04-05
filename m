From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v5 1/7] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Wed, 5 Apr 2017 01:38:08 -0700
Message-ID: <CAKvHMgRD8N4zuW1E4NO8Dzux6V8cHTwiYL+cvoEuz49am2duKQ@mail.gmail.com>
References: <20170405081059.1684-1-quentin.schulz@free-electrons.com> <20170405081059.1684-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34538 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbdDEIiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2017 04:38:19 -0400
In-Reply-To: <20170405081059.1684-2-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, robh+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

[reduced CC list]

Hi Quentin,

On Wed, Apr 5, 2017 at 1:10 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>
> This patch adds the DT binding documentation for the battery power
> supply which gets various data from the PMIC, such as the battery status
> (charging, discharging, full, dead), current max limit, current current,
> battery capacity (in percentage), voltage max and min limits, current
> voltage and battery capacity (in Ah).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>
> v5:
>   - removed DT property example from monitored-battery,
>
> v4:
>  - added monitored-battery optional property,
>  - added example with battery,
>
> v3:
>  - removed constant charge current property, now should use the WIP
>  battery framework,
>
> v2:
>  - changed DT node name from ac_power_supply to ac-power-supply,
>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>  done in the IIO ADC driver now),
>  - added x-powers,constant-charge-current property to set the maximal
>  default constant current charge of the battery,
>
>  .../bindings/power/supply/axp20x_battery.txt       | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> new file mode 100644
> index 0000000..63826fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -0,0 +1,28 @@
> +AXP20x and AXP22x battery power supply
> +
> +Required Properties:
> + - compatible, one of:
> +                       "x-powers,axp209-battery-power-supply"
> +                       "x-powers,axp221-battery-power-supply"
> +
> +Optional properties:
> + - monitored-battery, phandle to a fixed battery

Say here what properties of the battery your driver considers, e.g.
https://patchwork.kernel.org/patch/9660987/

> +
> +This node is a subnode of the axp20x/axp22x PMIC.
> +
> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
> +ADC.
> +
> +Example:
> +
> +battery: battery {
> +       compatible = "fixed-battery";

This is now "simple-battery". Also needs properties.

> +};
> +
> +&axp209 {
> +       battery_power_supply: battery-power-supply {
> +               compatible = "x-powers,axp209-battery-power-supply";
> +               monitored-battery = <&battery>;
> +       }
> +};
> --
> 2.9.3
>
