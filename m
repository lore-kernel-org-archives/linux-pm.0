From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 13/13] dt: power: bq2425x-charger: Cover additional
 devices
Date: Thu, 10 Sep 2015 09:15:09 +0900
Message-ID: <55F0CB8D.9000507@samsung.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-14-git-send-email-dannenberg@ti.com>
 <55EF7CDA.9030505@samsung.com> <20150909024841.GB32255@beast>
 <55EFBC61.1050405@samsung.com> <20150909201534.GB9887@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:24627 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbbIJAPM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 20:15:12 -0400
In-reply-to: <20150909201534.GB9887@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 10.09.2015 05:15, Andreas Dannenberg wrote:
> On Wed, Sep 09, 2015 at 01:58:09PM +0900, Krzysztof Kozlowski wrote:
>>
>> So we have different bindings. Existing ones:
>> bq2415x.txt - ti,charge-current - maximum charging current in mA
>> bq24257.txt - ti,charge-current - maximum charging current in uA
>> bq25890.txt - ti,charge-current - maximum charging current in uA
>> bq24735.txt - ti,charge-current - charge current (?) in mA
> 
> I just spent some time with the bq24735 datasheet and the way that
> device appears to work is putting the user in control of the charging
> process rather than implementing a fully automatic control loop, but
> either way I still think it's valid to call the property
> ti,charge-current and use a description of "maximum charging current"
> for that device (there is no DT bindings doc however). And yes the unit
> is mA as one can see from reverse-engineering the register settings.

Just for the record: the units used by device registers are not related
to units used in DT binding. You can use whatever you want. The driver
should just convert them.

> 
> On a related note the datasheet for that device says you have to
> periodically re-send the charge current setting every 44...175s to keep
> charging with the configured current or disable the device's watchdog
> timer. Neither of which the driver seems to do. I can probably go back
> and get some HW and test if that driver actually works as advertised.
> (also see http://www.ti.com/lit/ds/symlink/bq24735.pdf, Page 21)

I mentioned existing bindings for reference. To show that it's a mess.
However you cannot change them now (at least easily). You could add new
bindings and mark old as deprecated (still they would have to be
supported by the driver)...

> 
>> bq2415x.txt - ti,current-limit  - maximum current to be drawn in mA
>>
>> New bindings:
>> ti,charge-current (bq24261) - default charge current in mA
>> ti,max-charge-current (bq24261) - maximum charging current in mA
> 
> This ti,max-charge-current is actually an interesting one. It's not a
> device setting as it does not impact any of the device registers at all.
> Instead, it's an artificial limit that can be set through DT that
> prevents somebody from going into sysfs and configuring a charge current
> higher than ti,max-charge-current. In other drivers I have seen that the
> sysfs property reflecting that max charge current is just read-only and
> gives you the maximum the HW is capable of. From a device point of view
> there is nothing configurable about this property.

Hmmm, so now I wonder whether this should be a DT binding. The purpose
of DT isn't the control of the driver like enable some stuff, set some
value used by the driver. The DT provides information about hardware so
the driver could properly configure the device and work with it.

Reason to put this into DT would be:
For example one device configuration (device, board, connected battery)
could handle one maximum value and the other configuration would require
lower one. The device and its capabilities (bq24257 for example) are the
same but configuration changes.


If all configurations of bq24261 device have the same maximum value then
it should not be a DT property but it should be hard-coded in the driver
instead.

Ramakrishna,
Could you describe the reason behind "ti,max-charge-current" and
"pdata.max_cc" in bq24261 driver?

> 
>> ti,current-limit (bq2425x) - maximum current to be drawn in uA
>>
>>
>> Damn it... It's a mess. And there is no device prefixes...
> 
> ACK :)  Let's see how we can bring a little sense into it.
>  
>> The bq24261's bindings look most sensible (max prefix for max charge
>> current) but they are not compatible with existing bindings for
>> different devices.
> 
> Hmm I think they are compatible, it's just a question making the DT
> bindings description for the bq24261 fit better into what's already
> there. For example, like this:
> 
> (1) ti,charge-current: integer, maximum charging current in mA. For this
> device as for others this setting controls the max current the device
> uses to charge the battery so the established description is good
> however the general use of this property name itself is not 100%
> accurate (too late for that).

I agree.

> (2) ti,max-charge-current: Unless there is a good reason to keep it,
> REMOVE this property (alongside ti,max-charge-voltage). Instead, have
> the charger directly report back the maximum device charge current
> (BQ24261_MAX_CC) via sysfs like most other charger drivers do (bq24190,
> bq24257, bq25890, rt9455).

I agree but wait for some more data from Ramakrishna.

> 
>> There is no way to unify or make consistent all of these bindings.
>> However one could try to add new stuff in a more sensible way. For
>> example how about (for bq2425x-charger and bq24261_charger... BTW notice
>> even the difference in using underscore and hyphen!):
> 
> :(  You are talking about the driver .name, right? I saw that too. If
> the bq24261 charger was to change it's device name to use a hyphen at
> least it would be consistent with bq2415x and bq2425x.

The name of file and name of driver. Most of existing bq* drivers have
"_" in file name and "-" in driver name. So maybe use it in
bq2425x-charger (file name: bq2425x_charger)?

To prevent future issues in naming and bindings consistency maybe there
should be a dedicated maintainer for bq/TI charger devices? Pali Rohar
recently took care for devices related to Nokia N900 but maybe someone
from TI should also take care of rest or all of them (if TI is
interested in this)?

> 
>> ti,charge-current - maximum charging current in uA
>> (that one must be supported, it's for existing bq24257 devices)
> 
> Agreed. As discussed earlier this one is pretty established -- but in
> mA (not uA).

Okay.

> 
>> ti,default-charge-current (bq24261) - default charge current in *uA*
> 
> We don't need that. If you look where it goes (registers) this should be
> called ti,charge-current for the bq24261 (like it already is). Exactly
> the same name/usage as the other bqxxxx chargers. We just need to update
> the description.

Okay.

> 
>> ti,current-limit (bq2425x) - maximum current to be drawn in *uA*
> 
> Ok. Again here my preference would be mA. Like already on the bq2415x.
> If we can change the bq2425x driver to mA (see separate thread) we'd be
> closer to a more unified set of properties. Otherwise we would have
> properties with the same name but different units (is this even
> possible?).

mA would be nice... but bq2425x driver must support existing device
which means it must support existing bindings. Unfortunately the
existing binding for bq24257 is in uA.

Best regards,
Krzysztof

