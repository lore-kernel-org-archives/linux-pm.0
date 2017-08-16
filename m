From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 08/14] power: supply: Add
 power_supply_set_input_current_limit_from_supplier helper
Date: Wed, 16 Aug 2017 19:38:29 +0200
Message-ID: <327357a2-3491-fa7c-f715-eb1c321c3c38@redhat.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-9-hdegoede@redhat.com>
 <20170816155443.GH8569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170816155443.GH8569@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 16-08-17 17:54, Tony Lindgren wrote:
> * Hans de Goede <hdegoede@redhat.com> [170815 13:06]:
>> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
>> done by a separate port-controller IC, while the current limit is
>> controlled through another (charger) IC.
>>
>> It has been decided to model this by modelling the external Type-C
>> power brick (adapter/charger) as a power-supply class device which
>> supplies the charger-IC, with its voltage-now and current-max representing
>> the negotiated voltage and max current draw.
>>
>> This commit adds a power_supply_set_input_current_limit_from_supplier
>> helper function which charger power-supply drivers can call to get
>> the max-current from their supplier and have this applied
>> through their set_property call-back to their input-current-limit.
> 
> Hmm so can this also be used for the USB gadget subsystem
> to tell charge controller when it's OK to enable 500mA
> charging after enumeration?

I'm not sure that that would be best modeled this way. Perhaps
the phy-driver can directly control the gpio you have for that,
that seems better then trying to solve this with cross subsystem
calls which are always tricky.

> FYI, that's controlled by the bq24190 pin named OTG that should
> be only set high after enumeration. Any ideas how that is wired
> on your device? Does it connect to the USB PHY or to a GPIO
> line?

I believe it is just hardwired to be logical high all the time
on my board.

Regards,

Hans
