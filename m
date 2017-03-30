From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] thermal: allow hwmon devices to be created for
 of-thermal zones
Date: Wed, 29 Mar 2017 22:59:31 -0700
Message-ID: <20170330055929.GA28060@localhost.localdomain>
References: <E1cn8qC-0002uz-PB@rmk-PC.armlinux.org.uk>
 <20170320171552.o2ye73c2okcvhluq@rob-hp-laptop>
 <20170324132312.GF7909@n2100.armlinux.org.uk>
 <20170324144029.GG7909@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170324144029.GG7909-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, Mar 24, 2017 at 02:40:29PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 24, 2017 at 01:23:13PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 20, 2017 at 12:15:52PM -0500, Rob Herring wrote:
> > > On Sun, Mar 12, 2017 at 07:07:40PM +0000, Russell King wrote:
> > > > Allow hwmon devices to be optionally created for of-thermal zones,
> > > > rather than permanently denying them "in case" there is a hwmon
> > > > driver duplicating the thermal driver.
> > > > 
> > > > Signed-off-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> > > > ---
> > > > Without this, "sensors" is unable to report the temperature of the
> > > > Dove SoC when it supports thermal zones.
> > > > 
> > > >  Documentation/devicetree/bindings/thermal/thermal.txt | 3 +++
> > > >  arch/arm/boot/dts/dove.dtsi                           | 1 +
> > > >  drivers/thermal/of-thermal.c                          | 3 ++-
> > > >  3 files changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> > > > index 88b6ea1ad290..1478735fff85 100644
> > > > --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> > > > +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> > > > @@ -175,6 +175,9 @@ containing trip nodes and one sub-node containing all the zone cooling maps.
> > > >  			2000mW, while on a 10'' tablet is around
> > > >  			4500mW.
> > > >  
> > > > +- linux,hwmon:		Allow Linux to create hwmon devices for the thermal
> > > > +  Type: bool		zone.
> > > > +
> > > >  Note: The delay properties are bound to the maximum dT/dt (temperature
> > > >  derivative over time) in two situations for a thermal zone:
> > > >  (i)  - when passive cooling is activated (polling-delay-passive); and
> > > > diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> > > > index 40fb98687230..00f5971cd039 100644
> > > > --- a/arch/arm/boot/dts/dove.dtsi
> > > > +++ b/arch/arm/boot/dts/dove.dtsi
> > > > @@ -804,6 +804,7 @@
> > > >  
> > > >  	thermal-zones {
> > > >  		soc-thermal {
> > > > +			linux,hwmon;

New DT properties have to get an Ack from OF maintainers.

> > > 
> > > I'd prefer to see a black or white list of sensor compatibles here. Then 
> > > the dtb doesn't need to change if things move between hwmon and thermal 
> > > zones.
> > 
> > I'm not sure what you mean, and I can't see how that would be coded up.
> > The thermal layer doesn't give the option of individually selecting
> > which sensors have hwmon stuff created - it seems to be all or nothing.
> > I suspect what you're asking would require something of a rewrite of
> > the thermal code.  The sensors are registered completely independently
> > of parsing the thermal zone data.
> 

I agree here that Rob could have been more clear. Maybe he just wants to
avoid DTB changes if the driver decides to move from one subsystem to
the other.


> Okay, I'm convinced that what you're asking for (if I'm understanding
> correctly) is just not possible with how the thermal code is (horribly)
> architected at the moment.
> 
> While trying to understand how all the thermal zone stuff fits together,
> I found this comment:
> 
>                 /* For now, thermal framework supports only 1 sensor per zone */
>                 ret = of_parse_phandle_with_args(child, "thermal-sensors",
>                                                  "#thermal-sensor-cells",
>                                                  0, &sensor_specs);
> 
> so it's really not setup to deal with multiple sensors in DT right now
> (and there's no checking by the code that this is even the case.)
> 

Yes, the thermal core code still does not really support multiple
sensors per zone. Its original design decision to have one sensor
representing one zone is still kept, even though there has been attempts
to change this. So, the of thermal code, although the DT thermal
descriptors support multiple sensors per zone, is still limited to one
sensor per zone, otherwise it would be pretty much a fork from thermal
core.


> The way the code is architected, the thermal zone devices and hwmon
> support is setup _completely_ independently from attaching the single
> sensor to the zone - the setup of the thermal zone devices and
> registering the sysfs entry happens before the sensors.
> 
> The hwmon support is coded such that there is one hwmon device for all
> thermal zones.  Each thermal zone device exports exactly one hwmon
> temperature sensor value with one set of trip points.
> 

Based on git log, the hwmon support was historically written some time
before some of the recent changes on the hwmon subsystem. Looking at
both of them now, I must say the thermal_hwmon.c needs to be rewritten,
given that most of the sysfs interfaces are already handled by the hwmon
core. Also, there seams to be thermal subsystem awareness now on hwmon
core.

> A thermal zone device can support multiple sensors, but from the code
> and the above comment, the code does not support this - the sensors
> are not individually exported through hwmon.

As I mentioned above, the DT thermal descriptor does not limit the
relationship to 1:1, but the code is limited, yes.

> 
> So, I think what you're asking for is not possible and is based upon
> a mis-understanding - thermal does not export sensors, but exports the
> _zone_ itself as a hwmon sensor.  The zone temperature is exported,
> along with its thresholds.
> 
> Obviously, the separation of thermal vs hwmon is purely a Linux
> phenomenon, and I've wondered why people have to rewrite hwmon drivers
> as thermal drivers just to make use of the thermal subsystem - it seems
> to me like NIH syndrome.  I can't see why hwmon isn't able to export
> individual temperature sensors to thermal and have thermal import the
> values from there.
> 

Not sure if I got this point, but I do not see drivers being rewritten.
That is more like, organically, some drivers went into hwmon, some went
into thermal subsystem. I believe most of the drivers in the thermal
subsystem decided to go that route due to the control algorithm to keep
up on silicon temperature, given that most of them are on zones to
control temperature of cores.

> For example, you could have a hwmon device that has multiple temperature
> sensors (some do) which monitor different parts of the system, and a
> hwmon device should be able to be incorporated into a thermal zone for
> management.
> 

I think this is the idea behind the most recent changes related to
thermal on the hwmon core, so hwmon temperature sensors could be exposed
as zones, and therefore, system engineers could benefit of the
temperature control in kernel. But I frankly did not really use this
late support to really judge to which extent we get on the control.

> That doesn't seem possible, you have to implement a thermal driver to
> interface your sensor to the thermal stuff, and then have the _zone_
> statistics exported through hwmon.
> 
> If you want individual sensors exported, you have to implement a driver
> which has a dual-personality, it has to register with hwmon and thermal.
> 


> I'd say that, arguably, the whole "no_hwmon" thing in thermal is also
> wrong - it may _seem_ to be correct because thermal only supports one
> sensor, and we don't want such a dual-personality driver to have two
> entries in sysfs, but that's rather moot when you consider that one is
> exporting the zone (which has DT configured thresholds) and one is
> exporting the sensor itself.
> 
> So, my conclusion is that this is all rather messed up, and certainly
> beyond my willingness to put in a lot of effort, creating lots of
> patches to try and bring the code to a point where what you're asking
> for is possible (iow, where we export individual sensors to hwmon,
> and make individual sensors exportable.)
> 
> Therefore, I believe that my implementation is entirely reasonable -
> the linux,hwmon flag indicates whether the state of the thermal _zone_
> (not the _sensors_) should be exported via hwmon.
> 

Yeah, here your patch seams to be willing to use the thermal_hwmon
support, which goes from thermal subsystem to hwmon. And yes, the
no_hwmon, in this case, is used to avoid having two hwmon sysfs entry
for the same sensor, one coming from a real hwmon driver, another one
exported from the thermal zone.

The only reason one would still want to have both hwmon interfaces, it
would be in case a thermal zone has, for example, some extrapolation
rule defined in DT, and therefore reading the raw hwmon sysfs entry
would not necessarily mean you have the same thermal zone temperature
value. Then again, the zone temperature value can still, be read from
the thermal zone sysfs entry. But,...

Thinking of this use case, and considering that more and more drivers
are now using extrapolation rules on DT, at least the simple linear
extrapolation, then I would suggest simply always adding the hwmon interface
from of thermal, instead. In this way, userspace that knows only about
hwmon entries may be able to know of the raw values and the extrapolated
values based on the zone. Then again, this needs to be clear to avoid
confusion, so people understand the differentiation.

> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
