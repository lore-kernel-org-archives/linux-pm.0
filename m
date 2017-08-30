From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 09/11] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Wed, 30 Aug 2017 07:47:46 -0700
Message-ID: <20170830144746.GG6008@atomide.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170830094814.17758-10-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

* Hans de Goede <hdegoede@redhat.com> [170830 02:49]:
> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
> done by a separate port-controller IC, while the current limit is
> controlled through another (charger) IC.
> 
> It has been decided to model this by modelling the external Type-C
> power brick (adapter/charger) as a power-supply class device which
> supplies the charger-IC, with its voltage-now and current-max representing
> the negotiated voltage and max current draw.
> 
> This commit adds support for this to the bq24190_charger driver by adding
> an external_power_changed callback and calling
> power_supply_set_input_current_limit_from_supplier from this callback.
> This callback will only get called if the bq24190 has a parent-supply.
> 
> Note this replaces the functionality to get the current-limit from an
> extcon device, which will be removed in a follow-up commit.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Tony Lindgren <tony@atomide.com>
