From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: New bindings for ltc3651-charger
Date: Mon, 8 May 2017 12:12:06 -0500
Message-ID: <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
References: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, May 05, 2017 at 08:38:35AM +0200, Mike Looijmans wrote:
> This adds the devicetree bindings documentation for the LTC3651 battery charger.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../bindings/power/supply/ltc3651-charger.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> new file mode 100644
> index 0000000..a7dd80f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> @@ -0,0 +1,26 @@
> +ltc3651-charger
> +
> +Required properties:
> + - compatible: "lltc,ltc3651-charger"
> + - acpr-gpios: Connect to ACPR output. See remark below.
> +
> +Optional properties:
> + - fault-gpios: Connect to FAULT output. See remark below.
> + - chrg-gpios: Connect to CHRG output. See remark below.

All the gpios need vendor prefix.

> +
> +The ltc3651 outputs are open-drain type and active low. The driver assumes the
> +GPIO reports "active" when the output is asserted, so if the pins have been
> +connected directly, the GPIO flags should be set to active low also.
> +
> +The driver will attempt to aquire interrupts for all GPIOs. If the system is
> +not capabale of providing that, the driver cannot report changes and userspace
> +will need to periodically read the sysfs attributes to detect changes.

If these are interrupts, then you should use the interrupt binding 
instead (most GPIO controllers are also interrupt controllers).

> +
> +Example:
> +
> +	charger: battery-charger {
> +		compatible = "lltc,ltc3651-charger";
> +		acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
> +		fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
> +		chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
> +	};
> -- 
> 1.9.1
> 
