From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 2/3] thermal: of: parse stacked thermal zones from
 device tree
Date: Mon, 9 Nov 2015 14:52:51 +0000
Message-ID: <20151109145250.GA3120@e104805>
References: <1446658662-19582-1-git-send-email-javi.merino@arm.com>
 <1446658662-19582-3-git-send-email-javi.merino@arm.com>
 <20151104185633.GC12825@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50971 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbKIOwy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 09:52:54 -0500
Content-Disposition: inline
In-Reply-To: <20151104185633.GC12825@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>

On Wed, Nov 04, 2015 at 10:56:34AM -0800, Eduardo Valentin wrote:
> On Wed, Nov 04, 2015 at 05:37:41PM +0000, Javi Merino wrote:
> > Let device tree set thermal zones in the thermal-sensors list of
> > phandles and set up the thermal zone hierarchy based on the information
> > present there.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  .../devicetree/bindings/thermal/thermal.txt        | 154 ++++++++++++++++++++-
> >  drivers/thermal/of-thermal.c                       |  99 +++++++++++++
> 
> Please split this patch.

Into documentation and code?  I prefer it when the documentation is
updated with the code but I can split it if that's what you prefer.

> >  2 files changed, 250 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> > index 41b817f7b670..52b7e9ae3b4d 100644
> > --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> > @@ -145,9 +145,12 @@ Required properties:
> >    Size: one cell
> >  
> >  - thermal-sensors:	A list of thermal sensor phandles and sensor specifier
> > -  Type: list of 	used while monitoring the thermal zone.
> > -  phandles + sensor
> > -  specifier
> > +  Type: list of 	used while monitoring the thermal zone. The phandles
> > +  phandles + sensor	can point to thermal sensors or other thermal zone
> > +  specifier		nodes. If it points to other thermal zone
> > +			nodes you should omit the sensor specifier
> > +			and set #thermal-sensor-cells to 0 for the
> > +			thermal zone.
> >  
> >  - trips:		A sub-node which is a container of only trip point nodes
> >    Type: sub-node	required to describe the thermal zone.
> > @@ -603,3 +606,148 @@ thermal-zones {
> >  The above example is a mix of previous examples, a sensor IP with several internal
> >  sensors used to monitor different zones, one of them is composed by several sensors and
> >  with different cooling devices.
> > +
> > +(e) Board thermal with stacked thermal zones
> > +
> > +Instead of setting up one thermal zone combining multiple thermal
> > +zones and multiple trip points for each cooling device, we can create
> > +a hierarchy of thermal zones.
> > +
> > +#include <dt-bindings/thermal/thermal.h>
> > +
> > +&i2c1 {
> > +	...
> > +	/*
> > +	 * An IC with several temperature sensor.
> > +	 */
> > +	adc_dummy: sensor@0x50 {
> > +		...
> > +		#thermal-sensor-cells = <1>; /* sensor internal ID */
> > +	};
> > +};
> > +
> > +thermal-zones {
> > +
> > +        cpu_thermal: cpu_thermal {
> > +		polling-delay-passive = <1000>; /* milliseconds */
> > +		polling-delay = <2500>; /* milliseconds */
> > +
> > +		sustainable-power = <2500>;
> > +
> > +		thermal-sensors = <&adc_dummy 0>
> > +
> > +		trips {
> > +			cpu_trip: cpu-trip {
> > +				temperature = <60000>; /* millicelsius */
> > +				hysteresis = <2000>; /* millicelsius */
> > +				type = "passive";
> > +			};
> > +                };
> > +
> > +		cooling-maps {
> > +			map0 {
> > +				trip = <&cpu_trip>;
> > +				cooling-device = <&cpu0 0 2>;
> > +			};
> > +                };
> > +        };
> > +
> > +        gpu_thermal: gpu_thermal {
> > +		polling-delay-passive = <1000>; /* milliseconds */
> > +		polling-delay = <2500>; /* milliseconds */
> > +
> > +		sustainable-power = <2500>;
> > +
> > +		thermal-sensors = <&adc_dummy 2>
> > +
> > +		trips {
> > +			gpu_trip: gpu-trip {
> > +				temperature = <55000>; /* millicelsius */
> > +				hysteresis = <2000>; /* millicelsius */
> > +				type = "passive";
> > +			}
> > +                };
> > +
> > +		cooling-maps {
> > +			map0 {
> > +				trip = <&gpu_trip>;
> > +				cooling-device = <&gpu0 0 2>;
> > +			};
> > +                };
> > +        };
> > +
> > +        lcd_thermal: lcd_thermal {
> > +		polling-delay-passive = <1000>; /* milliseconds */
> > +		polling-delay = <2500>; /* milliseconds */
> > +
> > +		sustainable-power = <2500>;
> > +
> > +		thermal-sensors = <&adc_dummy 1>
> > +
> > +		trips {
> > +			lcd_trip: lcp-trip {
> > +				temperature = <53000>; /* millicelsius */
> > +				hysteresis = <2000>; /* millicelsius */
> > +				type = "passive";
> > +			};
> > +                };
> > +
> > +		cooling-maps {
> > +			map0 {
> > +				trip = <&lcd_trip>;
> > +				cooling-device = <&lcd0 5 10>;
> > +			};
> > +                };
> > +        };
> > +
> > +	board_thermal: board-thermal {
> > +		polling-delay-passive = <1000>; /* milliseconds */
> > +		polling-delay = <2500>; /* milliseconds */
> > +
> > +		thermal-sensors = <&cpu_thermal &gpu_thermal &lcd_thermal>
> > +
> 
> (no, I have not grepped the device tree)
> Was there any other occurrence of such construction ?
> 
> It just looks awkward that one property holds two types of data. Is DT
> strongly typed?
>
> I would say, following the DT pattern, one would expect to have the
> binding to allow one thermal zone to be written inside another thermal
> zone, no?

That would not allow us to have a thermal zone be a child of multiple
thermal zones.  For example, a thermal sensor could be half-way
through a GPU and a core and you would want to use that sensor's
thermal zone as input for both the GPU and the core thermal zones.

Cheers,
Javi
