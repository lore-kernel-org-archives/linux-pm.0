From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 5/5] acpi-based wakeup event detection
Date: Thu, 20 Aug 2009 11:16:51 +0800
Message-ID: <20090820031651.GC26357@sli10-desk.sh.intel.com>
References: <1250666661.23178.120.camel@sli10-desk.sh.intel.com> <20090819114220.GA12216@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090819114220.GA12216@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 07:42:20PM +0800, Matthew Garrett wrote:
> On Wed, Aug 19, 2009 at 03:24:21PM +0800, Shaohua Li wrote:
> 
> > +	ret = acpi_gpe_pme_check(dev);
> > +
> > +	acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number);
> 
> I don't think we want to unconditionally disable the GPE.
yes, we need something you proposed to add reference for GPE disable/enable.
 
> > +
> > +	acpi_init_gpe_pme();
> 
> I'm also not keen on haing the notifier being at the ACPI level. Are we 
> guaranteed that the GPE will only be used for wakeups, and will never 
> trigger any other sort of notification? Keeping this at the bus level 
> may be more practical.
the notification handler checks if this is a wakeup event.
Because the ACPI wakeup event can be sent to any kind of buses, so move the
code to acpi level can reduce a lot of duplicate code, otherwise you must
implement the same mechanism for every bus.

Thanks,
Shaohua
