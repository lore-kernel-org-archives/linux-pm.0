From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: al-thermal: Add binding
 documentation
Date: Wed, 10 Apr 2019 09:10:00 -0500
Message-ID: <20190410141000.GA19197@bogus>
References: <1554373016-1442-1-git-send-email-talel@amazon.com>
 <1554373016-1442-2-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554373016-1442-2-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Talel Shenhar <talel@amazon.com>
Cc: edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com, rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 04, 2019 at 01:16:55PM +0300, Talel Shenhar wrote:
> Add thermal binding documentation for Amazon's Annapurna Labs Thermal
> Sensor.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  .../bindings/thermal/amazon,al-thermal.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> new file mode 100644
> index 0000000..af8cf18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> @@ -0,0 +1,33 @@
> +Amazon's Annapurna Labs Thermal Sensor
> +
> +Simple thermal device that allows temperature reading by a single MMIO
> +transaction.
> +
> +Required properties:
> +- compatible: "amazon,al-thermal".
> +- reg: The physical base address and length of the sensor's registers.
> +- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
> +
> +Example:
> +	thermal: thermal {
> +		compatible = "amazon,al-thermal";
> +		reg = <0x0 0x05002860 0x0 0x1>;
> +		#thermal-sensor-cells = <0x1>;
> +	};
> +
> +	thermal-zones {
> +		thermal_z0 {

thermal-z0 {

> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&thermal 0>;
> +			trips {
> +				thermalz0_crit {

critical {

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +					temperature = <105000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +		};
> +	};
> +
> -- 
> 2.7.4
> 
