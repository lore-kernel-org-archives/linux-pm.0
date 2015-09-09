From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 13/13] dt: power: bq2425x-charger: Cover additional
 devices
Date: Wed, 9 Sep 2015 15:15:35 -0500
Message-ID: <20150909201534.GB9887@beast>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-14-git-send-email-dannenberg@ti.com>
 <55EF7CDA.9030505@samsung.com>
 <20150909024841.GB32255@beast>
 <55EFBC61.1050405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47385 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbbIIUQJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 16:16:09 -0400
Content-Disposition: inline
In-Reply-To: <55EFBC61.1050405@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 09, 2015 at 01:58:09PM +0900, Krzysztof Kozlowski wrote:
> On 09.09.2015 11:48, Andreas Dannenberg wrote:
> > On Wed, Sep 09, 2015 at 09:27:06AM +0900, Krzysztof Kozlowski wrote:
> >> On 09.09.2015 09:12, Andreas Dannenberg wrote:
> >>> Extend the bq2425x charger's device tree documentation to cover the
> >>> bq24250 and bq24257 devices as well as recent feature additions.
> >>>
> >>> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> >>
> >> Hi,
> >>
> >> Thanks for updates. Everything pointed previous looks good. After
> >> looking at Ramakrishna Pallala's (Cc-ed) patch ("power: bq24261_charger:
> >> Add support for TI BQ24261 charger") I have only one comment below.
> > 
> > Thanks for all your efforts and time checking those patches!
> > 
> >>
> >>> ---
> >>>  .../devicetree/bindings/power/bq24257.txt          | 21 -------
> >>>  .../devicetree/bindings/power/bq2425x.txt          | 70 ++++++++++++++++++++++
> >>>  2 files changed, 70 insertions(+), 21 deletions(-)
> >>>  delete mode 100644 Documentation/devicetree/bindings/power/bq24257.txt
> >>>  create mode 100644 Documentation/devicetree/bindings/power/bq2425x.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
> >>> deleted file mode 100644
> >>> index 5c9d394..0000000
> >>> --- a/Documentation/devicetree/bindings/power/bq24257.txt
> >>> +++ /dev/null
> >>> @@ -1,21 +0,0 @@
> >>> -Binding for TI bq24257 Li-Ion Charger
> >>> -
> >>> -Required properties:
> >>> -- compatible: Should contain one of the following:
> >>> - * "ti,bq24257"
> >>> -- reg:			   integer, i2c address of the device.
> >>> -- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
> >>> -- ti,charge-current:	   integer, maximum charging current in uA.
> >>> -- ti,termination-current:  integer, charge will be terminated when current in
> >>> -			   constant-voltage phase drops below this value (in uA).
> >>> -
> >>> -Example:
> >>> -
> >>> -bq24257 {
> >>> -	compatible = "ti,bq24257";
> >>> -	reg = <0x6a>;
> >>> -
> >>> -	ti,battery-regulation-voltage = <4200000>;
> >>> -	ti,charge-current = <1000000>;
> >>> -	ti,termination-current = <50000>;
> >>> -};
> >>> diff --git a/Documentation/devicetree/bindings/power/bq2425x.txt b/Documentation/devicetree/bindings/power/bq2425x.txt
> >>> new file mode 100644
> >>> index 0000000..3e171c3
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/bq2425x.txt
> >>> @@ -0,0 +1,70 @@
> >>> +Binding for TI bq2425x Li-Ion Charger
> >>> +
> >>> +Required properties:
> >>> +- compatible: Should contain one of the following:
> >>> + * "ti,bq24250"
> >>> + * "ti,bq24251"
> >>> + * "ti,bq24257"
> >>> +- reg: integer, i2c address of the device.
> >>> +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> >>> +    also be defined through the standard interrupt definition properties (see
> >>> +    optional properties section below). Only use one method.
> >>> +- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
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
> >>
> >> I understand this is different property than "ti,charge-current:
> >> integer, default charging current (in mA)" from bq24261_charger patch?
> > 
> > Correct this is what "ti,current-limit" is for. And I borrowed that
> > definition from bq2415x_charger.c where it's used in the same context.
> > The reason for this property to exist is for systems where the external
> > power supply does more than just charging the battery, such as supplying
> > the system while it's charging or after it has finished charging. All
> > this only makes sense of course if the "ti,current-limit" is larger than
> > "ti,charge-current".
> > 
> > And if you see a few lines above the bq24257 driver also has a
> > "ti,charge-current" property. And yes this is what actually controls how
> > much current is delivered to the battery.
> 
> Right, I missed that one. Everything is clear now.
> 
> So we have different bindings. Existing ones:
> bq2415x.txt - ti,charge-current - maximum charging current in mA
> bq24257.txt - ti,charge-current - maximum charging current in uA
> bq25890.txt - ti,charge-current - maximum charging current in uA
> bq24735.txt - ti,charge-current - charge current (?) in mA

I just spent some time with the bq24735 datasheet and the way that
device appears to work is putting the user in control of the charging
process rather than implementing a fully automatic control loop, but
either way I still think it's valid to call the property
ti,charge-current and use a description of "maximum charging current"
for that device (there is no DT bindings doc however). And yes the unit
is mA as one can see from reverse-engineering the register settings.

On a related note the datasheet for that device says you have to
periodically re-send the charge current setting every 44...175s to keep
charging with the configured current or disable the device's watchdog
timer. Neither of which the driver seems to do. I can probably go back
and get some HW and test if that driver actually works as advertised.
(also see http://www.ti.com/lit/ds/symlink/bq24735.pdf, Page 21)

> bq2415x.txt - ti,current-limit  - maximum current to be drawn in mA
> 
> New bindings:
> ti,charge-current (bq24261) - default charge current in mA
> ti,max-charge-current (bq24261) - maximum charging current in mA

This ti,max-charge-current is actually an interesting one. It's not a
device setting as it does not impact any of the device registers at all.
Instead, it's an artificial limit that can be set through DT that
prevents somebody from going into sysfs and configuring a charge current
higher than ti,max-charge-current. In other drivers I have seen that the
sysfs property reflecting that max charge current is just read-only and
gives you the maximum the HW is capable of. From a device point of view
there is nothing configurable about this property.

> ti,current-limit (bq2425x) - maximum current to be drawn in uA
> 
> 
> Damn it... It's a mess. And there is no device prefixes...

ACK :)  Let's see how we can bring a little sense into it.
 
> The bq24261's bindings look most sensible (max prefix for max charge
> current) but they are not compatible with existing bindings for
> different devices.

Hmm I think they are compatible, it's just a question making the DT
bindings description for the bq24261 fit better into what's already
there. For example, like this:

(1) ti,charge-current: integer, maximum charging current in mA. For this
device as for others this setting controls the max current the device
uses to charge the battery so the established description is good
however the general use of this property name itself is not 100%
accurate (too late for that).
(2) ti,max-charge-current: Unless there is a good reason to keep it,
REMOVE this property (alongside ti,max-charge-voltage). Instead, have
the charger directly report back the maximum device charge current
(BQ24261_MAX_CC) via sysfs like most other charger drivers do (bq24190,
bq24257, bq25890, rt9455).

> There is no way to unify or make consistent all of these bindings.
> However one could try to add new stuff in a more sensible way. For
> example how about (for bq2425x-charger and bq24261_charger... BTW notice
> even the difference in using underscore and hyphen!):

:(  You are talking about the driver .name, right? I saw that too. If
the bq24261 charger was to change it's device name to use a hyphen at
least it would be consistent with bq2415x and bq2425x.

> ti,charge-current - maximum charging current in uA
> (that one must be supported, it's for existing bq24257 devices)

Agreed. As discussed earlier this one is pretty established -- but in
mA (not uA).

> ti,default-charge-current (bq24261) - default charge current in *uA*

We don't need that. If you look where it goes (registers) this should be
called ti,charge-current for the bq24261 (like it already is). Exactly
the same name/usage as the other bqxxxx chargers. We just need to update
the description.

> ti,current-limit (bq2425x) - maximum current to be drawn in *uA*

Ok. Again here my preference would be mA. Like already on the bq2415x.
If we can change the bq2425x driver to mA (see separate thread) we'd be
closer to a more unified set of properties. Otherwise we would have
properties with the same name but different units (is this even
possible?).

Regards,

--
Andreas Dannenberg
Texas Instruments Inc
