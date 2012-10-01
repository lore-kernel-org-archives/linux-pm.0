From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] ACPI: ACPI 5.0 device enumeration proposal
Date: Mon, 1 Oct 2012 09:44:33 +0300
Message-ID: <20121001064433.GF15548@intel.com>
References: <1348817863.10877.320.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348817863.10877.320.camel-fuY85erJQUO75v1z/vFq2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Len, Brown" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 28, 2012 at 03:37:43PM +0800, Zhang Rui wrote:
> 
> the main idea is that, for Serial Buses like I2C and SPI, we enumerate
> the controller as a platform device, and then enumerate the slaves via
> i2c/spi_register_board_info. And then, when the controller is really
> probed and enabled in the platform driver, the SPI/I2C bus code will
> enumerate I2C/SPI slaves automatically.
> And for the other devices, we will enumerate all of them as platform
> devices, which is not covered in this patch set yet.

Can you show some example how we could use this new code for example with
an existing I2C/SPI slave driver? Let's say the device uses few GPIOs, one
for interrupt and other for triggering firmware download. In addition to
that it needs a special parameters that can be extracted running the "_DSM"
method of the device.

Normally the driver would get this stuff from the platform data or from
Device Tree but how it is done with these patches?
