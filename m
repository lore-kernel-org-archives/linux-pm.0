From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 6/6] thermal: Add DT binding doc for thermal of PMIC
 max77620
Date: Wed, 9 Mar 2016 11:29:00 -0800
Message-ID: <20160309192859.GC2422@localhost.localdomain>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
 <1457529010-6538-7-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457529010-6538-7-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 09, 2016 at 06:40:10PM +0530, Laxman Dewangan wrote:
> Maxim Semiconductor MAX77620 supports alarm interrupts when
> its die temperature crosses 120C and 140C. These threshold
> temperatures are not configurable.
> 
> Add DT binding document to details out the DT property related
> to MAX77620 thermal functionality.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> Changes from V1:
> - New in series to add DT binding doc per V1 review.
> 
>  .../bindings/thermal/thermal-max77620.txt          | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-max77620.txt b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
> new file mode 100644
> index 0000000..d76412f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-max77620.txt
> @@ -0,0 +1,43 @@
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
> +...
> +spmic: max77620@3c {
> +	compatible = "maxim,max77620";
> +
> +	#thermal-sensor-cells = <0>;
> +};
> +
> +thermal-zones {
> +	PMIC-Die {
> +		thermal-sensors = <&spmic>;
> +		trips {
> +			die_temp_thresh: hot-die {
> +				temperature = <120000>;
> +				type = "active";
> +				hysteresis = <0>;
> +			};
> +		};
> +	};
> +};


Considering that this is an example (and people will copy and paste it),
please add all the required DT properties for a thermal-zone node.

> +
> -- 
> 2.1.4
> 
