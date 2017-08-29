From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 11/14] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Tue, 29 Aug 2017 13:53:24 +0200
Message-ID: <b5d695fc-49dc-c4fd-7470-19e82a859bf5@redhat.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-12-hdegoede@redhat.com>
 <20170829114003.rcj6l5up4277urxq@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170829114003.rcj6l5up4277urxq@earth>
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
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Thank you for your reviews / queuing!

On 29-08-17 13:40, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Aug 15, 2017 at 10:04:59PM +0200, Hans de Goede wrote:
>> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
>> done by a separate port-controller IC, while the current limit is
>> controlled through another (charger) IC.
>>
>> It has been decided to model this by modelling the external Type-C
>> power brick (adapter/charger) as a power-supply class device which
>> supplies the charger-IC, with its voltage-now and current-max representing
>> the negotiated voltage and max current draw.
>>
>> This commit adds support for this to the bq24190_charger driver by calling
>> power_supply_set_input_current_limit_from_supplier helper if the
>> "input-current-limit-from-supplier" device-property is set.
>>
>> Note this replaces the functionality to get the current-limit from an
>> extcon device, which will be removed in a follow-up commit.
> 
> I'm fine with the general approach, but ...
> 
>> [...]
>> +	bdi->input_current_limit_from_supplier =
>> +		device_property_read_bool(dev,
>> +					  "input-current-limit-from-supplier");
>> [...]
> 
> I wonder if we actually need this. I think we can just enable it
> unconditionally when we have a parent power supply providing the
> information.

I was thinking the same when implementing this, so this is fine with
me. I think it is best to just unconditionally call
power_supply_set_input_current_limit_from_supplier from the
external_power_changed callback, that will only get called if we've
a parent supply and that function will check that the parent has
a current-max property itself.

Please let me know if just unconditionally calling
power_supply_set_input_current_limit_from_supplier from the
external_power_changed callback is ok with you then I will do that
for v3 of the patch-set (from which I will drop the patches you've
already queued).

Regards,

Hans
