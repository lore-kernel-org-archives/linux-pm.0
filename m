From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] thermal: generic-adc: Add DT binding for ADC based
 thermal sensor driver
Date: Wed, 6 Apr 2016 09:01:27 -0700
Message-ID: <20160406160126.GA638@localhost.localdomain>
References: <1459936986-2839-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459936986-2839-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 06, 2016 at 03:33:05PM +0530, Laxman Dewangan wrote:
> Sometimes, thermal sensors like NCT thermistors are connected to
> the ADC channel. The temperature is read by reading the voltage
> across the sensor resistance via ADC and referring the lookup
> table for ADC value to temperature. The ADC interface is provided
> through the IIO framework.
> 
> Add DT binding doc for the adc based thermal sensor driver to detail
> the DT property and provide the example for how to use it.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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

How about when you have a sensor that does not have a nice linear
stepping correlation ?

> +- temperature-lookup-table:  The ADC reading value on each step of the
> +			     temperature starting from lower temperature
> +			     to upper temperature.
> +			     When ADC is read, the value is looked up on the
> +			     table to get the equivalent temperature.

I would say, we would need to support a two dimensional table here..

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
> +
> +		trips {
> +			therm_est_trip: therm_est_trip {
> +			temperature = <40000>;
> +			type = "active";
> +			hysteresis = <1000>;
> +			writable;

Not sure about writable property, where is it described?

> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {
> +			trip = <&therm_est_trip>;
> +			cooling-device = <&dummy_cool_dev THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			contribution = <100>;
> +			cdev-type = "therm_est_activ";


Not sure about cdev-type property, where is it described?

> +			};
> +		};
> +
> +	};
> +};
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
