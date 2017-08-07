From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Mon, 7 Aug 2017 16:41:18 +0200
Message-ID: <dcbddc43-e581-505e-915b-3bf16b477422@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-11-hdegoede@redhat.com>
 <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
 <85c668d5-c6f0-a94c-4dd5-1b425cdff339@redhat.com>
 <20170807111054.4lp5rgc5vpnsmhim@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170807111054.4lp5rgc5vpnsmhim@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Liam Breck <liam@networkimprov.net>, Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 07-08-17 13:10, Mark Brown wrote:
> On Sun, Aug 06, 2017 at 05:44:36PM +0200, Hans de Goede wrote:
>> On 06-08-17 16:30, Guenter Roeck wrote:
>>> On 08/06/2017 05:35 AM, Hans de Goede wrote:
> 
>>>> On ACPI platforms, there are no phandles and we need to get the vbus by a
>>>> system wide unique name. Add support for a new "fcs,vbus-regulator-name"
>>>> device-property which ACPI platform code can set to pass the name.
> 
>>> Another property to be documented and approved.
> 
>> Again this is for kernel internal use on non-dt platforms only, so documenting
>> it in the devicetree bindings is not necessary.
> 
> However it *is* for use on ACPI platforms and is impacting power
> management (which is something ACPI definitely models) so should be
> being documented in an ASWG spec.  We don't want Linux systems to start
> breaking the ACPI power management model with uncontrolled extensions,
> it's fine to add new bindings for things where there's just no ACPI
> specification at all but power management isn't one of those areas.

This regulator is used to enable/disable driving vbus on the Type-C connector
from a 5V boost converter or not depending on the power direction (sink
or source) negotiated by the Type-C port-controller. As such this is never
under firmware/ACPI control it always gets controlled by the Type-C
port-manager, so there is no need for ACPI to control it. The problem is
that the Type-C setup on these boards consist of a bunch of ICs chained
together / driving different pins of the Type-C connector. So we need to
somehow tell the bq24292i charger-IC to turn on/off its 5V boost converter
from the Type-C port-controller driver. This discussion (and this patch)
is about getting a handle to the regulator-device for the 5V boost converter
from the Type-C port-controller driver.

For added fun the bq24292i charger-IC is not described in ACPI at all,
but we know that the Whiskey Cove PMIC used is always paired with it.

The fusb302 Type-c port-controller itself is enumerated to the weird
INT33FE ACPI device node (which describes 3 different i2c ICs, including
the fusb302)

>> TL;DR: It seems that on x86, at least for existing devices where we cannot
>> control the ACPI tables that getting things by name is the thing to do.
> 
> The idiomatic thing to do on an ACPI system at present appears to be to
> have a big DMI quirk table somewhere that instantiates the regulators
> and mappings required for them based on the machine's DMI data.  Or if
> it's a self contained PCI device or something with both regulator and
> consumer do it as part of the subfunction instantiation there.

Thanks for your input. I've taken a look at the possibility to specify
a mapping via regualtor_init_data, rather then falling back to finding the
regulator by name. I've found 2 problems with this:

Problem 1)

The regulator in question is part of the bq24292i charger-IC attached to
a private i2c bus between the PMIC and the charger. The driver for the i2c
controller inside the PMIC which drivers this bus currently also instantiates
the i2c-client for the charger:

drivers/i2c/busses/i2c-cht-wc.c:

static const char * const bq24190_suppliers[] = { "fusb302-typec-source" };

static const struct property_entry bq24190_props[] = {
         PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq24190_suppliers),
         PROPERTY_ENTRY_BOOL("input-current-limit-from-supplier"),
         PROPERTY_ENTRY_BOOL("omit-battery-class"),
         PROPERTY_ENTRY_BOOL("disable-reset"),
         { }
};

static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
{
         struct i2c_board_info board_info = {
                 .type = "bq24190",
                 .addr = 0x6b,
                 .properties = bq24190_props,
         };
	...
	adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
	ret = i2c_add_adapter(&adap->adapter);

	board_info.irq = adap->client_irq;
	adap->client = i2c_new_device(&adap->adapter, &board_info);
	...
}

Note that the bq24190 driver is a generic driver, so to pass the
board specific regulator_init_data to it I would need to somehow
pass it here, but I don't see how, except by storing a pointer to
it in an u64 device-property which seems like a bad idea


Problem 2)

Even if I could add the mapping through regulator_init_data
then it may well be too late, if the regulator_get happens
before the bq24190 driver registers its regulator (and thus
the mapping) the regulator_get for it may have already
happened and returned a dummy-regulator, or another regulator
with the rather generic vbus name.


TL;DR: It is a mess and I cannot come up with anything better then
just using a globally-unique name, suggestions for a better
solution are welcome.

Regards,

Hans
