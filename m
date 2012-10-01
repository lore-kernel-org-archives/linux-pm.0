From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [RFC PATCH 0/6] ACPI: ACPI 5.0 device enumeration proposal
Date: Mon, 1 Oct 2012 14:30:00 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926322D989@SHSMSX101.ccr.corp.intel.com>
References: <1348817863.10877.320.camel@rui.sh.intel.com>
 <20121001064433.GF15548@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20121001064433.GF15548@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@secretlab.ca>, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Monday, October 01, 2012 2:45 PM
> To: Zhang, Rui
> Cc: LKML; linux-pm; linux-i2c; linux-acpi@vger.kernel.org; Len, Brown;
> Rafael J. Wysocki; Grant Likely; Dirk Brandewie
> Subject: Re: [RFC PATCH 0/6] ACPI: ACPI 5.0 device enumeration proposal
> Importance: High
> 
> On Fri, Sep 28, 2012 at 03:37:43PM +0800, Zhang Rui wrote:
> >
> > the main idea is that, for Serial Buses like I2C and SPI, we
> enumerate
> > the controller as a platform device, and then enumerate the slaves
> via
> > i2c/spi_register_board_info. And then, when the controller is really
> > probed and enabled in the platform driver, the SPI/I2C bus code will
> > enumerate I2C/SPI slaves automatically.
> > And for the other devices, we will enumerate all of them as platform
> > devices, which is not covered in this patch set yet.
> 
> Can you show some example how we could use this new code for example
> with an existing I2C/SPI slave driver?

This is just prototype patch set that I want to illustrate my idea
on ACPI device enumeration, to get more thoughts on this.
So no example driver so far.

> Let's say the device uses few
> GPIOs, one for interrupt and other for triggering firmware download. In
> addition to that it needs a special parameters that can be extracted
> running the "_DSM" method of the device.
> 
> Normally the driver would get this stuff from the platform data or from
> Device Tree but how it is done with these patches?

Can you show me an example driver that gets the special parameters from Device Tree?

Thanks,
rui
