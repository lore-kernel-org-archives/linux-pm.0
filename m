From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Thu, 30 Mar 2017 19:39:04 +0200
Message-ID: <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1490530535.21738.31.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry for doing this in the middle of the thread, but this is the only
mail I could find in my archives (I guess I delete mail to aggressively).

Anyways self-nack for this series, there are multiple issues with it:

1) In hindsight the irq_index is a bad idea and instead we need a noirq
flag in i2c_driver

2) The i2c_acpi_new_device() function needs to have a board_info
argument

3) The cht_wc_fuel_gauge driver actually is a driver for the
Maxim MAX17047 Fuel Gauge. After much poking and reading of
the dsdt I've finally found out what the mysterious INT33FE
ACPI device in the dsdt represents, here is a comment from
a new platform/x86 driver I'm writing for it:

/*
  * Intel Cherry Trail ACPI INT33FE pseudo device driver
  * Some Intel Cherry Trail based device which ship with Windows 10, have
  * this weird INT33FE ACPI device with a CRS table with 4 I2cSerialBusV2
  * resources, for 4 different chips attached to various i2c busses:
  * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device
  * 2. Maxim MAX17047 Fuel Gauge Controller
  * 3. FUSB300C USB Type-C Controller
  * 4. PI3USB30532 USB switch
  *
  * So this driver is a stub / pseudo driver whose only purpose is to
  * instantiate i2c-clients for chips 2 - 4, so that standard i2c drivers
  * for these chips can bind to the them.
  */

So the plan is to have this stub driver instantiate an i2c client
with an id of max17047 and then have a proper max17047 battery
power-supply driver which will get bound to that i2c-client.

Regards,

Hans
