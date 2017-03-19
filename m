From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Sun, 19 Mar 2017 10:42:00 +0100
Message-ID: <12321f48-def6-33cb-1df5-853ecc8f1061@redhat.com>
References: <20170318071019.4561-1-liam@networkimprov.net>
 <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
 <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
 <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
 <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbdCSJvB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Mar 2017 05:51:01 -0400
In-Reply-To: <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi Liam,

On 19-03-17 09:22, Hans de Goede wrote:
> Hi,

<snip>

>> Then consider the pseudo-driver concept. That would be generally
>> useful for any charger/gauge pairing. Both drivers would provide
>> callbacks to it.
>
> So your rejecting a patch which adds 30 lines of code for some
> vague generic pseudo-driver concept without offering any design
> direction on what such a concept would look like and without taking
> into account that so far this seems to be a one-of problem.

I still think the pseudo-driver idea is a bad idea. Having 1 driver
which somehow combines things from 2 drivers without clear semantics
feels wrong.

As said before I think your suggested solution lacks any
design direction, I've been thinking about this a bit more and
I've come up with an alternative solution with clearly defined
goals and semantics.

We want one driver which is solidly in control of the charger
since getting that wrong is quite bad and we want to extend
the information it is exporting to userspace in the form of
power_supply properties with some extra info.

So taking that as a starting point and generalizing that,
I think that if we want we can make something more generic then
my original patch for this. My idea is to introduce something
called a power_supply_properties_provider, with an API
like this:

typedef int (*power_supply_properties_provider_get_property_t)(
	enum power_supply_property prop, union power_supply_propval *val,
	void *driver_data);

struct power_supply_properties_provider;

struct power_supply_properties_provider *
power_supply_properties_provider_register(
	const char *name,
	power_supply_properties_provider_get_property_t get_property,
	const enum power_supply_property *properties,
	size_t num_properties,
	void *driver_data);

void power_supply_properties_provider_unregister(
	struct power_supply_properties_provider *pspp);

struct power_supply_properties_provider *
	power_supply_properties_provider_get(const char *name);

void power_supply_properties_provider_put(
	struct power_supply_properties_provider *pspp);

int power_supply_properties_provider_merge_properties(
	struct power_supply_properties_provider *pspp,
	const enum power_supply_property *properties,
	size_t num_properties,
	enum power_supply_property **merged_properties_ret,
	size_t *merged_num_properties_ret);

int power_supply_properties_provider_get_property(
	struct power_supply_properties_provider *pspp,
	enum power_supply_property prop,
	union power_supply_propval *val);

So in this case the faul-gauge driver would call
power_supply_properties_provider_register() from probe and
power_supply_properties_provider_unregister() from remove.

The struct power_supply_properties_provider will be ref-counted
so that it will stick around after unregister in case any
consumers who have gotten a ref through
power_supply_properties_provider_get can still call
power_supply_properties_provider_get_property, which after
unregister will simply always return -ENXIO.

A driver wanting to use extra properties like bq24190_charger
will call power_supply_properties_provider_get (with a name
provided through platform_data), use a dynamically allocated
struct power_supply_desc and fill the properties of that
using power_supply_properties_provider_merge_properties
to merge its own properties with the
power_supply_properties_provider's properties and in its
get_property method have a default label which calls
power_supply_properties_provider_get_property.

This would still add quite a bit more code then my original
patch for what may very well end up being a one-of solution,
but I guess we may encounter this problem more often and
this will offer a nice generic and clean way for dealing
with adding extra info from other sources to a power_supply
driver, so I'm happy to turn this idea / design into working
code if people like this better then my original patch.

Liam, Sebastian what do you think of the above proposal?

Regards,

Hans
