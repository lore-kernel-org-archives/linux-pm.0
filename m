From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] power: smb347-charger: Summit SMB358 charger IC
Date: Thu, 10 Aug 2017 10:30:13 -0500
Message-ID: <20170810153013.yq6efa4c53wammwe@rob-hp-laptop>
References: <1501613430-24508-1-git-send-email-simhavcs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501613430-24508-1-git-send-email-simhavcs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinay Simha BN <simhavcs@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 02, 2017 at 12:20:26AM +0530, Vinay Simha BN wrote:
> Summit microelectronics' SMB358 charger chip has
> almost the same register map and functionality.
> voltage and current table are only differed.
> 
> SMB345 charger IC tested in nexus7
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> 
> ---
> v2:
> * incorporated code review from Rob Herring
>   gpio line added for Enable charging control,
>   documentation bindings (vendor prefixes and unit suffixes)
> ---
>  .../bindings/power/supply/smb347_charger.txt       |  73 +++++

Please split binding to a separate patch.

>  drivers/power/supply/smb347-charger.c              | 334 +++++++++++++--------
>  include/linux/power/smb347-charger.h               |   4 +-
>  3 files changed, 283 insertions(+), 128 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/smb347_charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/smb347_charger.txt b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
> new file mode 100644
> index 0000000..45da4ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
> @@ -0,0 +1,73 @@
> +smb347_charger bindings
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +[Required porperties]
> +- compatible : "summit,smb345"
> +	       "summit,smb347"
> +- reg : Slave address for i2c interface
> +# At least one of following should be set
> +  - enable-usb-charging
> +  - enable-otg-charging
> +  - enable-mains-charging

As I wrote last time, I don't think these belong in DT.

> +
> +[Optional properties]
> +- interrupt-parent : The phandle for the interrupt controller
> +- interrupts : Interrupt line index for mapping
> +- en-gpio : Enable charging control

enable-gpios

> +	  : If this is not specified it will use SW (i2c interface)
> +
> +# Charging constraints
> +- max-chg-curr : microamps for charging Maximum current
> +- max-chg-volt : microvolts for charging Maximum voltage
> +- pre-chg-curr : microamps for Pre-charging current
> +- term-curr : microamps for Charging cycle termination current
> +- fast-volt-thershold : microvolts for Voltage threshold to transit to fast charge mode
> +- mains-curr-limit : micromaps for Maximum input current from AC/DC input
> +- usb-curr-limit : microamps for Maximum input current from USB input

These are all properties of the battery, not the charger. See 
.../power/supply/battery.txt.

> +
> +# Related thermometer monitoring (Degrees Celsius)
> +- chip-temp-threshold : Chip temperature for thermal regulaton.   <100, 130>
> +- soft-cold-temp-limit : Cold battery temperature for soft alarm. <0, 15>*
> +- soft-hot-temp-limit : Hot battery temperature for soft alarm.   <40, 55>
> +- hard-cold-temp-limit : Cold battery temperature for hard alarm. <0, 15>*
> +- hard-hot-temp-limit : Hot battery temperature for hard alarm.   <55, 65>
> +(* The written temperature has +5'C offset. 0'C -> -5'C, 15'C -> 10'C)

These too should probably be common. If not they need vendor prefix and 
unit suffix. See property-units.txt.

> +- soft-comp-method : Soft temperature limit compensation method
> +	(Not defined) : Use default setting
> +		<0> : Compensation none
> +		<1> : Charge current compensation
> +		<2> : Voltage compensation
> +
> +Example:
> +	smb345@6a {
> +		compatible = "summit,smb345";
> +		reg = <0x6a>;
> +		status = "okay";
> +		interrupt-parent = <&tlmm_pinmux>;
> +		interrupts = <23 IRQ_TYPE_EDGE_BOTH>;
> +
> +		max-chg-curr = <1800000>;
> +		usb-curr-limit = <450000>;
> +
> +		chip-temp-thershold = <110>; /* celsius */
> +
> +		enable-usb-charging;
> +		enable-otg-charging;
> +	};
> +
> +	smb347@7f {

Isn't one example sufficient?

> +		compatible = "summit,smb347";
> +		reg = <0x7f>;
> +		status = "okay";
> +
> +		max-chg-curr = <1800000>;
> +		mains-curr-limit = <2000000>;
> +		usb-curr-limit = <450000>;
> +
> +		chip-temp-thershold = <110>; /* celsius */
> +
> +		en-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_HIGH>;
> +
> +		enable-usb-charging;
> +		enable-mains-charging;
> +	};
