From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Mon, 7 Aug 2017 21:20:05 +0200
Message-ID: <5f3d7cfa-c993-0cda-fae6-a975f7d4ca1c@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-11-hdegoede@redhat.com>
 <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
 <85c668d5-c6f0-a94c-4dd5-1b425cdff339@redhat.com>
 <20170807111054.4lp5rgc5vpnsmhim@sirena.org.uk>
 <dcbddc43-e581-505e-915b-3bf16b477422@redhat.com>
 <20170807154152.wt5b4y3s3oe4cnam@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170807154152.wt5b4y3s3oe4cnam@sirena.org.uk>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 07-08-17 17:41, Mark Brown wrote:
> On Mon, Aug 07, 2017 at 04:41:18PM +0200, Hans de Goede wrote:
>> On 07-08-17 13:10, Mark Brown wrote:
> 
>> Problem 1)
> 
>> The regulator in question is part of the bq24292i charger-IC attached to
>> a private i2c bus between the PMIC and the charger. The driver for the i2c
>> controller inside the PMIC which drivers this bus currently also instantiates
>> the i2c-client for the charger:
> 
> ...
> 
>> Note that the bq24190 driver is a generic driver, so to pass the
>> board specific regulator_init_data to it I would need to somehow
>> pass it here, but I don't see how, except by storing a pointer to
>> it in an u64 device-property which seems like a bad idea
> 
> I2C has a perfectly good platform_data pointer in the board info for
> this stuff.

True, so you are suggesting that I define a bq24190_platform_data
struct with a regulator_init_data pointer in there I guess?

At least I would not want to just claim that pointer for
just regulator_init_data and more-over assuming that what
is in there will be regulator_init_data feels wrong.

I don't think the power-supply maintainers will be enthusiastic
about this (hi Sebastian). But that does make sense and is
actually a good idea for tackling the problem of regulator_init_data.

>> Problem 2)
> 
>> Even if I could add the mapping through regulator_init_data
>> then it may well be too late, if the regulator_get happens
>> before the bq24190 driver registers its regulator (and thus
>> the mapping) the regulator_get for it may have already
>> happened and returned a dummy-regulator, or another regulator
>> with the rather generic vbus name.
> 
> If you don't have control over the instantiation ordering

It is not just device-instantiation ordering, it is also driver
loading order, the event around which ordering needs to happen is
the registration of the regulator (as things are now).

> but you have a firmware which claims to provide a complete description of regulators
> then you'd need to add an interface that allows mappings to be
> registered separately to regulator registration.

So the pwm subsys has this pwm_add_table thing which can add lookup
entries indepdentent of pwm_registration and which uses supply/device_name
matching to find the entry for the caller of pwm_get which is the same as
the current lookup code in the regulator-core, but since it is
independent of the registration the lookup-table does not contain
direct pointers to pwmchip-s instead it uses a string which gets
matches against the pwm (parent) dev's dev_name().

Would extending the struct regulator_map with a const char *provider_name:

struct regulator_map {
         struct list_head list;
         const char *dev_name;   /* The dev_name() for the consumer */
         const char *supply;
         struct regulator_dev *regulator;
	const char *provider;	/* The dev_name() for the regulator parent-dev */
};

And having a regulator_add_lookup function which adds an entry to the
regulator_map_list which sets provider_name instead of regulator
be acceptable ?

lookup of such entries would look for regulators where supply
matches the regulator-name and provider matches the
regulators parent-dev-name.

Alternatively the entry could additionally contain a provider_supply_name
so that we can make arbitrary consumer-dev-name + consumer-supply-name
provider-dev-name + provider-supply-name matches. That would probably
be more flexible then requiring the supply name to match.

So would something like this (including returning -EPROBE_DEFER if there
is a pwm_map_list entry and no matching regulator can be found) acceptable ?

> Whatever you're doing the answer isn't to try to specify the name of the
> supply through some firmware binding, that's just obviously not sensible
> both in terms of a firmware abstraction and in terms of how the
> abstractions in Linux work.

Ok.

Regards,

Hans
