From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] acpi: utils: Add new acpi_dev_present helper
Date: Wed, 29 Mar 2017 12:26:38 +0300
Message-ID: <20170329092638.GU2957@lahna.fi.intel.com>
References: <20170316161736.339-1-hdegoede@redhat.com>
 <20170316161736.339-2-hdegoede@redhat.com>
 <4029834.c3GWUpRlkb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51449 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754618AbdC2JdR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 05:33:17 -0400
Content-Disposition: inline
In-Reply-To: <4029834.c3GWUpRlkb@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Mar 28, 2017 at 11:42:29PM +0200, Rafael J. Wysocki wrote:
> On Thursday, March 16, 2017 05:17:35 PM Hans de Goede wrote:
> > acpi_dev_found just iterates over all acpi-ids and sees if one matches.
> > This means that it will return true for devices which are in the dsdt
> > but disabled (their _STA method returns 0).
> > 
> > For some drivers it is useful to be able to check if a certain hid
> > is not only present in the namespace, but also actually present as in
> > acpi_device_is_present() will return true for the device. For example
> > because if a certain device is present then the driver will want to use
> > an extcon or IIO adc channel provided by that device.
> > 
> > This commit adds a new acpi_dev_present helper which drivers can use
> > to this end.
> > 
> > Arguably acpi_dev_present is what acpi_dev_found should have been, but
> > there are too many users to just change acpi_dev_found without the risk
> > of breaking something.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Andy, Mika, any concerns about this patch, please?

No concerns from my side.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
