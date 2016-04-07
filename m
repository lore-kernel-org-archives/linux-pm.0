From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] thermal: generic-adc: Add DT binding for ADC based
 thermal sensor driver
Date: Thu, 7 Apr 2016 12:58:17 -0500
Message-ID: <20160407175817.GQ32257@rob-hp-laptop>
References: <1459936986-2839-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459936986-2839-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 06, 2016 at 03:33:05PM +0530, Laxman Dewangan wrote:
> Sometimes, thermal sensors like NCT thermistors are connected to
> the ADC channel. The temperature is read by reading the voltage
> across the sensor resistance via ADC and referring the lookup
> table for ADC value to temperature. The ADC interface is provided
> through the IIO framework.

IIO framework is a detail not relevant to the binding.

> 
> Add DT binding doc for the adc based thermal sensor driver to detail
> the DT property and provide the example for how to use it.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  .../bindings/thermal/thermal-generic-adc.txt       | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> new file mode 100644
> index 0000000..6b3e715
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> @@ -0,0 +1,86 @@
> +General Purpose Analog To Digital Converter (ADC) based thermal sensor
> +
> +On some of platforms, thermal sensor like thermistors are connected to
> +one of ADC channel and sensor resistance is read via voltage across the
> +sensor. The voltage read across the sensor is mapped to temperature using
> +voltage-temperature lookup table.
> +
> +This driver provides the interface to sensor-ADC interconnection and
> +the relation ship between ADC read value and temperature.

Bindings don't describe drivers.

> +
> +Required properties:
> +===================
> +- compatible:		     Must be "generic-adc-thermal".
> +- lower-temperature:	     Lower temperature for the lookup table
> +			     in millicelsius.
> +- upper-temperature:	     Upper temperature for the lookup table
> +			     in millicelsius.
> +- step-temperature:	     The temperature steps for the reading ADC
> +			     value in millicelsius.
> +- temperature-lookup-table:  The ADC reading value on each step of the
> +			     temperature starting from lower temperature
> +			     to upper temperature.
> +			     When ADC is read, the value is looked up on the
> +			     table to get the equivalent temperature.
> +- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
> +			     of this property. 
> +
> +Example :
> +#include <dt-bindings/thermal/thermal.h>
> +
> +i2c@7000c400 {
> +	ads1015: ads1015@4a {
> +		reg = <0x4a>;
> +		compatible = "ads1015";
> +		sampling-frequency = <3300>;
> +		#io-channel-cells = <1>; 
> +	};
> +};
> +
> +thermal-sensor@1 {
> +	compatible = "generic-adc-thermal";
> +	#thermal-sensor-cells = <0>;
> +	io-channels = <&ads1015 1>; 
> +	io-channel-names = "sensor-channel";
> +	lower-temperature = <(-40000)>;
> +	upper-temperature = <125000>;
> +	step-temperature = <1000>;
> +	temperature-lookup-table = <2578 2577 2576 2575 2574
> +				2573 2572 2571 2569 2568
> +				2567 2565 2563 2561 2559
> +				::::::::::
> +				254 247 240 233 226 220 
> +				214 208>;
> +};
> +
> +dummy_cool_dev: dummy-cool-dev {
> +	compatible = "dummy-cooling-dev";
> +	#cooling-cells = <2>; /* min followed by max */
> +};
> +
> +thermal-zones {
> +	Tboard {
> +		polling-delay = <15000>; /* milliseconds */
> +		polling-delay-passive = <0>; /* milliseconds */
> +		thermal-sensors = <&tboard_thermistor>;

Missing a label?

> +
> +		trips {
> +			therm_est_trip: therm_est_trip {
> +			temperature = <40000>;
> +			type = "active";
> +			hysteresis = <1000>;
> +			writable;

Missing indentation and closing brace.

> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {
> +			trip = <&therm_est_trip>;
> +			cooling-device = <&dummy_cool_dev THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			contribution = <100>;
> +			cdev-type = "therm_est_activ";
> +			};

Here's your missing brace... 

> +		};
> +
> +	};
> +};
> -- 
> 2.1.4
> 
