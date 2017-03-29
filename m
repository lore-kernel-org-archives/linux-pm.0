From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] acpi: utils: Add new acpi_dev_present helper
Date: Wed, 29 Mar 2017 19:50:52 +0300
Message-ID: <1490806252.708.53.camel@linux.intel.com>
References: <20170316161736.339-1-hdegoede@redhat.com>
         <20170316161736.339-2-hdegoede@redhat.com>
         <4029834.c3GWUpRlkb@aspire.rjw.lan>
         <20170329092638.GU2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170329092638.GU2957@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-03-29 at 12:26 +0300, Mika Westerberg wrote:
> On Tue, Mar 28, 2017 at 11:42:29PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, March 16, 2017 05:17:35 PM Hans de Goede wrote:
> > > acpi_dev_found just iterates over all acpi-ids and sees if one
> > > matches.
> > > This means that it will return true for devices which are in the
> > > dsdt
> > > but disabled (their _STA method returns 0).
> > > 
> > > For some drivers it is useful to be able to check if a certain hid
> > > is not only present in the namespace, but also actually present as
> > > in
> > > acpi_device_is_present() will return true for the device. For
> > > example
> > > because if a certain device is present then the driver will want
> > > to use
> > > an extcon or IIO adc channel provided by that device.
> > > 
> > > This commit adds a new acpi_dev_present helper which drivers can
> > > use
> > > to this end.
> > > 
> > > Arguably acpi_dev_present is what acpi_dev_found should have been,
> > > but
> > > there are too many users to just change acpi_dev_found without the
> > > risk
> > > of breaking something.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Andy, Mika, any concerns about this patch, please?
> 
> No concerns from my side.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Neither from me.

I briefly looked in the code and indeed we have no existing helper as a
such, so, if you think this is the best way to go, I would agree.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
