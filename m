From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/18] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Mon, 7 Aug 2017 21:15:43 -0700
Message-ID: <20170808041543.GH5190@atomide.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170806123555.5124-14-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

* Hans de Goede <hdegoede@redhat.com> [170806 05:37]:
> Register the 5V boost converter as a regulator named
> "regulator-bq24190-usb-vbus". Note the name includes "bq24190" because
> the bq24190 family is also used on ACPI devices where there are no
> device-tree phandles, so regulator_get will fallback to the name and thus
> it must be unique on the system.

Nice, this makes VBUS easy to use for USB PHY drivers :)

Tony
