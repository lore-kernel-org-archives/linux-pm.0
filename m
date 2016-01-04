From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 2/4] devicetree: bindings: let thermal-sensor point to
 other thermal zones
Date: Mon, 4 Jan 2016 15:17:09 +0100
Message-ID: <20160104141709.GB19256@pengutronix.de>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-3-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35665 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751297AbcADOR0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2016 09:17:26 -0500
Content-Disposition: inline
In-Reply-To: <1448464186-26289-3-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Wed, Nov 25, 2015 at 03:09:44PM +0000, Javi Merino wrote:
> The thermal-sensor property of the thermal zone node accepts phandles to
> thermal sensors.  However, thermal zones can be created as an
> aggregation of other thermal zones.  Extend the thermal-sensors property
> to allow phandles to other thermal zones.  This patch also adds an
> example that showcases how a board thermal zone can be created from the
> aggregation of the cpu, gpu and lcd thermal zones.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
> 
> Notes:
>     Hi devicetree,
>     
>     Is it ok to extend the definition of the thermal-sensors property like
>     this?  IOW are phandles strongly typed?
> 
>  .../devicetree/bindings/thermal/thermal.txt        | 154 ++++++++++++++++++++-
>  1 file changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 41b817f7b670..52b7e9ae3b4d 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -145,9 +145,12 @@ Required properties:
>    Size: one cell
>  
>  - thermal-sensors:	A list of thermal sensor phandles and sensor specifier
> -  Type: list of 	used while monitoring the thermal zone.
> -  phandles + sensor
> -  specifier
> +  Type: list of 	used while monitoring the thermal zone. The phandles
> +  phandles + sensor	can point to thermal sensors or other thermal zone
> +  specifier		nodes. If it points to other thermal zone
> +			nodes you should omit the sensor specifier
> +			and set #thermal-sensor-cells to 0 for the
> +			thermal zone.
>  
>  - trips:		A sub-node which is a container of only trip point nodes
>    Type: sub-node	required to describe the thermal zone.
> @@ -603,3 +606,148 @@ thermal-zones {
>  The above example is a mix of previous examples, a sensor IP with several internal
>  sensors used to monitor different zones, one of them is composed by several sensors and
>  with different cooling devices.
> +
> +(e) Board thermal with stacked thermal zones
> +
> +Instead of setting up one thermal zone combining multiple thermal
> +zones and multiple trip points for each cooling device, we can create
> +a hierarchy of thermal zones.
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +&i2c1 {
> +	...
> +	/*
> +	 * An IC with several temperature sensor.
> +	 */
> +	adc_dummy: sensor@0x50 {
> +		...
> +		#thermal-sensor-cells = <1>; /* sensor internal ID */
> +	};
> +};
> +
> +thermal-zones {
> +
> +        cpu_thermal: cpu_thermal {
> +		polling-delay-passive = <1000>; /* milliseconds */
> +		polling-delay = <2500>; /* milliseconds */
> +
> +		sustainable-power = <2500>;
> +
> +		thermal-sensors = <&adc_dummy 0>
> +
> +		trips {
> +			cpu_trip: cpu-trip {
> +				temperature = <60000>; /* millicelsius */
> +				hysteresis = <2000>; /* millicelsius */
> +				type = "passive";
> +			};
> +                };
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&cpu_trip>;
> +				cooling-device = <&cpu0 0 2>;
> +			};
> +                };
> +        };
> +
> +        gpu_thermal: gpu_thermal {
> +		polling-delay-passive = <1000>; /* milliseconds */
> +		polling-delay = <2500>; /* milliseconds */
> +
> +		sustainable-power = <2500>;
> +
> +		thermal-sensors = <&adc_dummy 2>
> +
> +		trips {
> +			gpu_trip: gpu-trip {
> +				temperature = <55000>; /* millicelsius */
> +				hysteresis = <2000>; /* millicelsius */
> +				type = "passive";
> +			}
> +                };
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&gpu_trip>;
> +				cooling-device = <&gpu0 0 2>;
> +			};
> +                };
> +        };
> +
> +        lcd_thermal: lcd_thermal {
> +		polling-delay-passive = <1000>; /* milliseconds */
> +		polling-delay = <2500>; /* milliseconds */
> +
> +		sustainable-power = <2500>;
> +
> +		thermal-sensors = <&adc_dummy 1>
> +
> +		trips {
> +			lcd_trip: lcp-trip {
> +				temperature = <53000>; /* millicelsius */
> +				hysteresis = <2000>; /* millicelsius */
> +				type = "passive";
> +			};
> +                };
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&lcd_trip>;
> +				cooling-device = <&lcd0 5 10>;
> +			};
> +                };
> +        };
> +
> +	board_thermal: board-thermal {
> +		polling-delay-passive = <1000>; /* milliseconds */
> +		polling-delay = <2500>; /* milliseconds */
> +
> +		thermal-sensors = <&cpu_thermal &gpu_thermal &lcd_thermal>

This seems inconsistent. Why can a thermal zone only have multiple
thermal sensors when they are thermal zones themselves? Either we assume
that one thermal zone has a single sensor or we assume that it can have
multiple sensors, but this should not depend on the zone being a sub zone
or not.

I think the thermal-sensors property should always point to one or
multiple sensors. I see no point in "This property either points to
exactly one sensor or multiple other thermal zones (from which we only
use the temperature)"

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
