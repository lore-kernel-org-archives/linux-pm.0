From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 1/2] thermal: generic-adc: Add DT binding for ADC
 based thermal sensor
Date: Wed, 13 Apr 2016 10:06:35 -0500
Message-ID: <20160413150635.GA15596@rob-hp-laptop>
References: <1460382102-27755-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55094 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757693AbcDMPGl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Apr 2016 11:06:41 -0400
Content-Disposition: inline
In-Reply-To: <1460382102-27755-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org

On Mon, Apr 11, 2016 at 07:11:41PM +0530, Laxman Dewangan wrote:
> Sometimes, thermal sensors like NCT thermistors are connected to
> the ADC channel. The temperature is read by reading the voltage
> across the sensor resistance via ADC and referring the lookup
> table for ADC value to temperature.
> 
> Add DT binding doc for the ADC based thermal sensor driver to
> detail the DT property and provide the example for how to use it.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> Changes from V1:
> - Make the lookup table to two dimensional instead of single array of linear
>   step of temperature.
> - Remove detailing of IIO frameowrk and drivers.
> - Added proper braces, indenting and labels.
> 
>  .../bindings/thermal/thermal-generic-adc.txt       | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> new file mode 100644
> index 0000000..c5c2e5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
> @@ -0,0 +1,86 @@
> +General Purpose Analog To Digital Converter (ADC) based thermal sensor.
> +
> +On some of platforms, thermal sensor like thermistors are connected to
> +one of ADC channel and sensor resistance is read via voltage across the
> +sensor resistor. The voltage read across the sensor is mapped to
> +temperature using voltage-temperature lookup table.
> +
> +Required properties:
> +===================
> +- compatible:		     Must be "generic-adc-thermal".
> +- temperature-lookup-table:  Two dimensional array of Integer; lookup table
> +			     to map the relation between ADC value and
> +			     temperature. When ADC is read, the value is
> +			     looked up on the table to get the equivalent
> +			     temperature.

First value is ?, 2nd value is ? The units are milliCelsius?

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
> +tboard_thermistor: thermal-sensor@1 {

Drop the unit address.

> +	compatible = "generic-adc-thermal";

