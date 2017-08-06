From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Sun, 6 Aug 2017 17:44:36 +0200
Message-ID: <85c668d5-c6f0-a94c-4dd5-1b425cdff339@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-11-hdegoede@redhat.com>
 <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
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
To: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

<resend with Liam and Mark added to the Cc as they may want to weigh in on this too>


Hi,

On 06-08-17 16:30, Guenter Roeck wrote:
> On 08/06/2017 05:35 AM, Hans de Goede wrote:
>> On devicetree platforms the fusb302 dt-node will have a vbus regulator
>> property with a phandle to the regulator.
>>
>> On ACPI platforms, there are no phandles and we need to get the vbus by a
>> system wide unique name. Add support for a new "fcs,vbus-regulator-name"
>> device-property which ACPI platform code can set to pass the name.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/staging/typec/fusb302/fusb302.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
>> index e1e08f57af99..c3bcc5484ade 100644
>> --- a/drivers/staging/typec/fusb302/fusb302.c
>> +++ b/drivers/staging/typec/fusb302/fusb302.c
>> @@ -1722,6 +1722,28 @@ static int fusb302_probe(struct i2c_client *client,
>>               return -EPROBE_DEFER;
>>       }
>> +    /*
>> +     * Devicetree platforms should get vbus from their dt-node.
>> +     * On ACPI platforms, we need to get the vbus by a system wide unique
>> +     * name, which is set in a device prop by the platform code.
>> +     */
>> +    if (device_property_read_string(dev, "fcs,vbus-regulator-name",
>> +                    &name) == 0) {
> 
> Another property to be documented and approved.

Again this is for kernel internal use on non-dt platforms only, so documenting
it in the devicetree bindings is not necessary.
> Also, isn't there a better way to get regulator names for dt- and non-dt systems ?
> This would apply to every driver supporting both and using regulators, which seems
> awkward.

While working on this I noticed that it is possible to add a regulator_match
table entry when registering a regulator, but that requires describing this
in regulator_init_data. Which would mean passing regulator_init_data from the
place where it is instantiated to where it gets registered, which would
mean passing a pointer through a device-property, given that this is purely kernel
internal that is possible, but not really how device-props are supposed to be used.

Also since the regulator-core only adds the mapping when registering the
regulator, this means that if we try to get the regulator before it has been
registered; and there is another regulator with the rather generic "vbus"
name then that will be returned instead.

Basically regulators are practically almost unused on x86 systems. I had to
add CONFIG_REGULATOR=y to my .config which is based on the Fedora 26 kernel
.config, so it has pretty much everything under the sun enabled. So it seems
that we are covering new ground here.

An alternative would be to not use the regulator subsys for this at all, but
it does seem the logical thing to use and using get-by-name is no different
then what we've doing for setting the the "fusb302-typec-source" psy as supplier
for the charger psy class device registered by the bq24190_charger driver.

TL;DR: It seems that on x86, at least for existing devices where we cannot
control the ACPI tables that getting things by name is the thing to do.

>> +        /*
>> +         * Use regulator_get_optional so that we can detect if we need
>> +         * to defer the probe rather then getting the dummy-regulator.
>> +         */
> 
> Wouldn't this apply to dt systems as well ?

No because there will be a property named "vbus-supply" in the fusb302
node containing a phandle to the regulator, if the regulator to which the phandle
points has not been registered yet regulator_get will automatically return
-EPROBE_DEFER because there is a "vbus-supply" property, only if there is
no such property at all will it return a dummy regulator.

>> +        chip->vbus = devm_regulator_get_optional(dev, name);
>> +        if (IS_ERR(chip->vbus)) {
>> +            ret = PTR_ERR(chip->vbus);
>> +            return (ret == -ENODEV) ? -EPROBE_DEFER : ret;
>> +        }
>> +    } else {
>> +        chip->vbus = devm_regulator_get(dev, "vbus");
>> +        if (IS_ERR(chip->vbus))
>> +            return PTR_ERR(chip->vbus);
>> +    }
>> +
> 
> You might also want to explain why you moved this code.

Right, I did that because it may fail with -EPROBE_DEFER and
I wanted to do that before the register_psy. But as I just
explained the old code could do that too, so I properly should
just put the register_psy later.

Regards,

Hans



>>       ret = tcpm_register_psy(chip->dev, &chip->tcpc_dev,
>>                   "fusb302-typec-source");
>>       if (ret < 0)
>> @@ -1739,12 +1761,6 @@ static int fusb302_probe(struct i2c_client *client,
>>       INIT_DELAYED_WORK(&chip->bc_lvl_handler, fusb302_bc_lvl_handler_work);
>>       init_tcpc_dev(&chip->tcpc_dev);
>> -    chip->vbus = devm_regulator_get(chip->dev, "vbus");
>> -    if (IS_ERR(chip->vbus)) {
>> -        ret = PTR_ERR(chip->vbus);
>> -        goto destroy_workqueue;
>> -    }
>> -
>>       if (client->irq) {
>>           chip->gpio_int_n_irq = client->irq;
>>       } else {
>>
> 
