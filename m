From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH V3 1/2] thermal: max77620: Add DT binding doc for thermal
 driver
Date: Tue, 7 Jun 2016 09:25:36 +0530
Message-ID: <575645B8.5090709@ti.com>
References: <1465213467-23518-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbcFGDzp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 23:55:45 -0400
In-Reply-To: <1465213467-23518-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org



On Monday 06 June 2016 05:14 PM, Laxman Dewangan wrote:
> Maxim Semiconductor MAX77620 supports alarm interrupts when
> its die temperature crosses 120C and 140C. These threshold
> temperatures are not configurable.
>
> Add DT binding document to details out the DT property related
> to MAX77620 thermal functionality.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>   .../bindings/thermal/thermal-max77620.txt          | 64 ++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-max77620.txt b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
> new file mode 100644
> index 0000000..5a500d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
> @@ -0,0 +1,64 @@
> +Thermal driver for MAX77620 Power management IC from Maxim Semiconductor.
> +
> +Maxim Semiconductor MAX77620 supports alarm interrupts when its
> +die temperature crosses 120C and 140C. These threshold temperatures
> +are not configurable. Device does not provide the real temperature
> +of die other than just indicating whether temperature is above or
> +below threshold level.
> +
> +Required properties:
> +-------------------
> +#thermal-sensor-cells:	Please refer <devicetree/bindings/thermal/thermal.txt>
> +			for more details.
> +			The value must be 0.
> +
> +For more details, please refer generic thermal DT binding document
> +<devicetree/bindings/thermal/thermal.txt>.
> +
> +Please refer <devicetree/bindings/mfd/max77620.txt> for mfd DT binding
> +document for the MAX77620.
> +
> +Example:
> +--------
> +#include <dt-bindings/mfd/max77620.h>
> +#include <dt-bindings/thermal/thermal.h>
> +...
> +
> +i2c@7000d000 {
> +	spmic: max77620@3c {
> +		compatible = "maxim,max77620";
> +		:::::
> +		#thermal-sensor-cells = <0>;
> +		:::
> +	};
> +};
> +
> +cool_dev: cool-dev {
> +	compatible = "cooling-dev";
> +	#cooling-cells = <2>;
> +};
> +
> +thermal-zones {
> +	PMIC-Die {
> +		polling-delay = <0>;
> +		polling-delay-passive = <0>;
> +		thermal-sensors = <&spmic>;
> +
> +		trips {
> +			die_temp_thresh: hot-die {
> +				temperature = <120000>;
> +				type = "active";
> +				hysteresis = <0>;
> +			};
> +		};

What about 140C? Isn't that a critical trip point?

> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&die_temp_thresh>;
> +				cooling-device = <&cool_dev THERMAL_NO_LIMIT
> +						  THERMAL_NO_LIMIT>;
> +				contribution = <100>;
> +			};
> +		};
> +	};
> +};
>
