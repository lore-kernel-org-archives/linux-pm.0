From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 08/14] power: supply: Add
 power_supply_set_input_current_limit_from_supplier helper
Date: Wed, 16 Aug 2017 08:54:43 -0700
Message-ID: <20170816155443.GH8569@atomide.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170815200502.17339-9-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

* Hans de Goede <hdegoede@redhat.com> [170815 13:06]:
> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
> done by a separate port-controller IC, while the current limit is
> controlled through another (charger) IC.
> 
> It has been decided to model this by modelling the external Type-C
> power brick (adapter/charger) as a power-supply class device which
> supplies the charger-IC, with its voltage-now and current-max representing
> the negotiated voltage and max current draw.
> 
> This commit adds a power_supply_set_input_current_limit_from_supplier
> helper function which charger power-supply drivers can call to get
> the max-current from their supplier and have this applied
> through their set_property call-back to their input-current-limit.

Hmm so can this also be used for the USB gadget subsystem
to tell charge controller when it's OK to enable 500mA
charging after enumeration?

FYI, that's controlled by the bq24190 pin named OTG that should
be only set high after enumeration. Any ideas how that is wired
on your device? Does it connect to the USB PHY or to a GPIO
line?

Regards,

Tony
