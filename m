From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Mon, 20 Mar 2017 18:04:05 +0100
Message-ID: <5e7becad-44e4-8cc8-aabb-cc678b03098b@redhat.com>
References: <20170318071019.4561-1-liam@networkimprov.net>
 <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
 <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
 <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
 <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
 <12321f48-def6-33cb-1df5-853ecc8f1061@redhat.com>
 <20170320052715.hrgaxsxwdrv7ynbu@earth>
 <6de63319-f30f-cae7-6d7a-0df2edd12859@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54247 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753165AbdCTRMO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 13:12:14 -0400
In-Reply-To: <6de63319-f30f-cae7-6d7a-0df2edd12859@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <liam@networkimprov.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi,

On 20-03-17 14:54, Hans de Goede wrote:
> Hi,
>
> On 20-03-17 06:27, Sebastian Reichel wrote:
>> Hi,
>>
>> On Sun, Mar 19, 2017 at 10:42:00AM +0100, Hans de Goede wrote:
>
> <snip>
>
>>> We want one driver which is solidly in control of the charger
>>> since getting that wrong is quite bad and we want to extend
>>> the information it is exporting to userspace in the form of
>>> power_supply properties with some extra info.
>>>
>>> So taking that as a starting point and generalizing that,
>>> I think that if we want we can make something more generic then
>>> my original patch for this. My idea is to introduce something
>>> called a power_supply_properties_provider, with an API
>>> like this:
>>
>> Thanks for thinking about this. From what I can see it should
>> be enough to just avoid exposing a battery device at all in
>> the charger driver, though. It does not really provide useful
>> information anyways.
>
> Interesting suggestion, 2 remarks / questions:
>
> 1) Given that we do not want to break existing setups
> which may depend on the existing battery interface on the bq24190
> driver and add a flag to not register it, or are you suggesting
> to simply remove it all together? Removing it all together would
> be better from a maintenance pov. Liam, you indicated that you
> are the main user of the bq24190 driver currently, do you need
> the battery power_supply interface for your use case ?
>
> 2) Not using the battery interface of the bq24190 driver at all
> means that the fuelgauge driver needs to grow some extra
> properties, specifically it will need to start reporting status,
> something which the bq24190 driver really has a better idea
> of the the fuel gauge.
>
> Note that I do not have documentation on the fuel-gauge (not even
> an out of tree driver from android-x86). It is all based on dumping
> registers every 5 minutes during a charge / discharge cycle and
> then puzzling together which register is what. I'm quite confident
> I've this all right, but this does make adding a status property
> harder (might involve some heuristics instead of being able
> to get the absolute truth from the charge ic itself).
>
> As such I think the power_supply_properties_provider proposal I'm
> doing might still be a good idea. Anyways I will dig through the
> dumps I've some more to see if I can find a good way to get
> charging status from the fuel gauge and get back to you when
> I'm done with looking at the dumps.

Ok, it looks like this approach should work. Downside is that
the fuel-gauge does not get interrupts when changing state,
but I can use extcon to get power being plugged in / removed
which is the most important state change to immediately
notify userspace about.

I will rework the patch-set accordingly. For now I'm just
going to throw in a patch completely removing the battery
power_supply from the bq24190_charger driver. If that is a
problem then that one can be replaced by one using a device
property to enable/disable the battery power_supply device,
question if we are going for a property for this, what should
the default be ? I tend toward a default of off / no battery
interface unless requested but that may break compatibility
with some existing dt files + userspace expecting it to be
there ?

Regards,

Hans





>>> typedef int (*power_supply_properties_provider_get_property_t)(
>>>     enum power_supply_property prop, union power_supply_propval *val,
>>>     void *driver_data);
>>>
>>> struct power_supply_properties_provider;
>>>
>>> struct power_supply_properties_provider *
>>> power_supply_properties_provider_register(
>>>     const char *name,
>>>     power_supply_properties_provider_get_property_t get_property,
>>>     const enum power_supply_property *properties,
>>>     size_t num_properties,
>>>     void *driver_data);
>>>
>>> void power_supply_properties_provider_unregister(
>>>     struct power_supply_properties_provider *pspp);
>>>
>>> struct power_supply_properties_provider *
>>>     power_supply_properties_provider_get(const char *name);
>>>
>>> void power_supply_properties_provider_put(
>>>     struct power_supply_properties_provider *pspp);
>>>
>>> int power_supply_properties_provider_merge_properties(
>>>     struct power_supply_properties_provider *pspp,
>>>     const enum power_supply_property *properties,
>>>     size_t num_properties,
>>>     enum power_supply_property **merged_properties_ret,
>>>     size_t *merged_num_properties_ret);
>>>
>>> int power_supply_properties_provider_get_property(
>>>     struct power_supply_properties_provider *pspp,
>>>     enum power_supply_property prop,
>>>     union power_supply_propval *val);
>>>
>>> So in this case the faul-gauge driver would call
>>> power_supply_properties_provider_register() from probe and
>>> power_supply_properties_provider_unregister() from remove.
>>>
>>> The struct power_supply_properties_provider will be ref-counted
>>> so that it will stick around after unregister in case any
>>> consumers who have gotten a ref through
>>> power_supply_properties_provider_get can still call
>>> power_supply_properties_provider_get_property, which after
>>> unregister will simply always return -ENXIO.
>>>
>>> A driver wanting to use extra properties like bq24190_charger
>>> will call power_supply_properties_provider_get (with a name
>>> provided through platform_data), use a dynamically allocated
>>> struct power_supply_desc and fill the properties of that
>>> using power_supply_properties_provider_merge_properties
>>> to merge its own properties with the
>>> power_supply_properties_provider's properties and in its
>>> get_property method have a default label which calls
>>> power_supply_properties_provider_get_property.
>>>
>>> This would still add quite a bit more code then my original
>>> patch for what may very well end up being a one-of solution,
>>> but I guess we may encounter this problem more often and
>>> this will offer a nice generic and clean way for dealing
>>> with adding extra info from other sources to a power_supply
>>> driver, so I'm happy to turn this idea / design into working
>>> code if people like this better then my original patch.
>>>
>>> Liam, Sebastian what do you think of the above proposal?
>>>
>>> Regards,
>>>
>>> Hans
>>>
