From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] ACPI: ACPI 5.0 device enumeration proposal
Date: Tue, 2 Oct 2012 09:19:08 +0300
Message-ID: <20121002061908.GP15548@intel.com>
References: <1348817863.10877.320.camel@rui.sh.intel.com>
 <20121001064433.GF15548@intel.com>
 <744357E9AAD1214791ACBA4B0B90926322D989@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926322D989-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Len, Brown" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 01, 2012 at 02:30:00PM +0000, Zhang, Rui wrote:
> 
> 
> > -----Original Message-----
> > From: Mika Westerberg [mailto:mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> > Sent: Monday, October 01, 2012 2:45 PM
> > To: Zhang, Rui
> > Cc: LKML; linux-pm; linux-i2c; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Len, Brown;
> > Rafael J. Wysocki; Grant Likely; Dirk Brandewie
> > Subject: Re: [RFC PATCH 0/6] ACPI: ACPI 5.0 device enumeration proposal
> > Importance: High
> > 
> > On Fri, Sep 28, 2012 at 03:37:43PM +0800, Zhang Rui wrote:
> > >
> > > the main idea is that, for Serial Buses like I2C and SPI, we
> > enumerate
> > > the controller as a platform device, and then enumerate the slaves
> > via
> > > i2c/spi_register_board_info. And then, when the controller is really
> > > probed and enabled in the platform driver, the SPI/I2C bus code will
> > > enumerate I2C/SPI slaves automatically.
> > > And for the other devices, we will enumerate all of them as platform
> > > devices, which is not covered in this patch set yet.
> > 
> > Can you show some example how we could use this new code for example
> > with an existing I2C/SPI slave driver?
> 
> This is just prototype patch set that I want to illustrate my idea
> on ACPI device enumeration, to get more thoughts on this.
> So no example driver so far.

But surely you have thought how this should be done? Otherwise we only see
a part of the solution here. What if this enumeration you introduce here
doesn't play well when I2C/SPI are added?

> 
> > Let's say the device uses few
> > GPIOs, one for interrupt and other for triggering firmware download. In
> > addition to that it needs a special parameters that can be extracted
> > running the "_DSM" method of the device.
> > 
> > Normally the driver would get this stuff from the platform data or from
> > Device Tree but how it is done with these patches?
> 
> Can you show me an example driver that gets the special parameters from Device Tree?

drivers/misc/eeprom/at25.c but there are much more if you search for DT
enabled drivers.

Now, I don't know what is the proper way to pass parameters in ACPI but
"_DSM" seems to be one that is being used.
