From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 13/18] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Tue, 8 Aug 2017 01:39:58 -0700
Message-ID: <CAKvHMgRJ4CVn43BnsB1odx_B3QvfFMMqeT3BrrwVtteXFszyAQ@mail.gmail.com>
References: <20170806123555.5124-1-hdegoede@redhat.com> <20170806123555.5124-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-14-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi Hans,

On Sun, Aug 6, 2017 at 5:35 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Register the 5V boost converter as a regulator named
> "regulator-bq24190-usb-vbus". Note the name includes "bq24190" because
> the bq24190 family is also used on ACPI devices where there are no
> device-tree phandles, so regulator_get will fallback to the name and thus
> it must be unique on the system.

What we're enabling here is 5V boost for otg host mode, not vbus
generally, so maybe the name should indicate that...

regulator-bq24190-usb-5volt
regulator-bq24190-usb-host
regulator-bq24190-usb-otg-5v

Tony, thoughts?
