From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v3 01/10] dt: power: bq24257-charger: Cover additional
 devices
Date: Tue, 15 Sep 2015 12:05:37 +0300
Message-ID: <20150915090537.GB3166@lpalcu-desk>
References: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
 <1442003202-1430-2-git-send-email-dannenberg@ti.com>
 <55F66514.1080909@samsung.com>
 <20150914135430.GA21442@borg>
 <55F7CF44.3010102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15394 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbbIOJFm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Sep 2015 05:05:42 -0400
Content-Disposition: inline
In-Reply-To: <55F7CF44.3010102@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 15, 2015 at 04:56:52PM +0900, Krzysztof Kozlowski wrote:
> On 14.09.2015 22:54, Andreas Dannenberg wrote:
> > On Mon, Sep 14, 2015 at 03:11:32PM +0900, Krzysztof Kozlowski wrote:
> >> On 12.09.2015 05:26, Andreas Dannenberg wrote:
> >>> Extend the bq24257 charger's device tree documentation to cover the
> >>> bq24250 and bq24251 devices as well feature additions.
> >>>
> >>> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> >>> ---
> >>>  .../devicetree/bindings/power/bq24257.txt          | 59 ++++++++++++++++++++--
> >>>  1 file changed, 54 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
> >>> index 5c9d394..4a88c96 100644
> >>> --- a/Documentation/devicetree/bindings/power/bq24257.txt
> >>> +++ b/Documentation/devicetree/bindings/power/bq24257.txt
> >>> @@ -1,21 +1,70 @@
> >>> -Binding for TI bq24257 Li-Ion Charger
> >>> +Binding for TI bq24250/bq24251/bq24257 Li-Ion Charger
> >>>  
> >>>  Required properties:
> >>>  - compatible: Should contain one of the following:
> >>> + * "ti,bq24250"
> >>> + * "ti,bq24251"
> >>>   * "ti,bq24257"
> >>> -- reg:			   integer, i2c address of the device.
> >>> +- reg: integer, i2c address of the device.
> >>> +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> >>> +    also be defined through the standard interrupt definition properties (see
> >>> +    optional properties section below). Only use one method.
> >>>  - ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
> >>> -- ti,charge-current:	   integer, maximum charging current in uA.
> >>> -- ti,termination-current:  integer, charge will be terminated when current in
> >>> -			   constant-voltage phase drops below this value (in uA).
> >>> +- ti,charge-current: integer, maximum charging current in uA.
> >>> +- ti,termination-current: integer, charge will be terminated when current in
> >>> +    constant-voltage phase drops below this value (in uA).
> >>> +
> >>> +Optional properties:
> >>> +- pg-gpios: GPIO used for connecting the bq2425x device PG (Power Good) pin.
> >>> +    This pin is not available on all devices however it should be used if
> >>> +    possible as this is the recommended way to obtain the charger's input PG
> >>> +    state. If this pin is not specified a software-based approach for PG
> >>> +    detection is used.
> >>> +- ti,current-limit: The maximum current to be drawn from the charger's input
> >>> +    (in uA). If this property is not specified a USB D+/D- signal based charger
> >>> +    type detection is used (if available) and the input limit current is set
> >>> +    accordingly. If the D+/D- based detection is not available on a given device
> >>> +    a default of 500,000 is used (=500mA).
> >>> +- ti,ovp-voltage: Configures the over voltage protection voltage (in uV). If
> >>> +    not specified a default of 6,5000,000 (=6.5V) is used.
> >>> +- ti,in-dpm-voltage: Configures the threshold input voltage for the dynamic
> >>> +    power path management (in uV). If not specified a default of 4,360,000
> >>> +    (=4.36V) is used.
> >>> +- ti,safety-timer-2x-enable: If this property is set to 1 the device's safety
> >>> +    timer is extended (slowed down) by a factor of two. Setting this property
> >>> +    to 0 or not providing it will leave the safety timer at its default
> >>> +    setting.
> >>
> >> Now I spotted the difference in this binding from previous emails.
> >> Previously you made it as a boolean property. Now it is a integer
> >> property for a boolean value. It is unusual. If you expect a need (or a
> >> possibility of need) of:
> >> 1. extending,
> >> 2. overriding,
> >> 3. using similar (extended) property in different drivers,
> >> then it should be a real value, like:
> >>
> >> 1. ti,safety-timer: integer, in seconds
> > 
> > Hi Krzysztof,
> > 
> > I thought about this as well because the device actually allows
> > configuring different safety timer intervals (currently not exposed) and
> > it appears that the "2x enable" could be factored in there however it's
> > not as easy as it seems.  The "2x enable" is a dedicated HW feature
> > that's only being used in some states of the devices and with that does
> > not generally extend the safety timer under all conditions.
> 
> Right, I read also the datasheet which explains it.
> 
> > 
> >> 2. ti,safety-timer-ratio/multiplier: integer, supported values are: 0
> >> (use default) or 2 (slow down by factor of 2)
> >>
> >> It is unusual and not obvious to use a integer value for boolean strict
> >> property. With current solution you can actually only override it.
> > 
> > Yes that was the sole reason behind using integer instead of boolean.
> > The boolean "character" of this property was left intact because of the
> > direct mapping to a device HW feature (see below).
> 
> DT serves a purpose of providing information allowing the kernel to use
> and configure the hardware. DT binding does not have to map device
> property. In the same time having a device property does not mean you
> create a DT binding.
> 
> If such requirement of mapping property to a HW feature was valid then
> each driver would expose each register in DT. Sometimes platform data
> did this... but DT is not pdata.
> You're using such argument also below but this argument is not sufficient.
> 
> Sufficient argument would be: this property is necessary to configure
> the hardware in different board configurations (so on different boards
> it will have different values).
> 
> Example of device features not matching to DeviceTree:
>  - configuration changing over time:
> /sys/class/power/ds2760-battery.*/charge_full
> 
>  - various timers:
> /sys/class/power_supply/max14577-charger/device/fast_charge_timer
> 
>  - various thresholds:
> /sys/class/power_supply/max77693-charger/device/top_off_threshold_current
> 
> These are strictly HW features (they map to a bit in register) but they
> are not related to configuring device for specific board. They serve for
> user-space to use the devices in different ways.
> 
> In this case - the 2XTMR_EN - I assume that for certain batteries or
> boards you want to extend the time of charging in case of special
> conditions?

FWIW, I don't see any real benefit in manually changing the 2X timer at
all. The default setting is decent enough. The chip will automatically
switch to 2X timer in certain conditions: for example, when the
temperature threshold is exceeded and the charge current is
automatically lowered. This makes sense since it'll take the battery
more time to charge at a lower current.

It would probably make more sense to add a DT property to change the
'Safety Timer Time Limit' device property (which can be 0.75hrs, 6hrs,
9hrs or totally disabled) than the 2XTMR.

I omitted both when I originally added support for this chip since the
6hrs default safety timer seemed more than enough to charge a nowadays
battery, even at 500mA (provided by a standard USB port). But, future
batteries might (and probably will) have higher capacities and will take
longer to charge.

laurentiu
