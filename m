From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] driver core / PM: Add callbacks for PM domain
 initialization/cleanup
Date: Thu, 19 Mar 2015 15:12:23 +0100
Message-ID: <20150319141223.GC7046@kroah.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <2317791.ICLpdqLgyu@vostro.rjw.lan>
 <20150319132907.GA3707@kroah.com>
 <3533423.QQDErEmeTO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48240 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbbCSOM1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 10:12:27 -0400
Content-Disposition: inline
In-Reply-To: <3533423.QQDErEmeTO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 19, 2015 at 03:21:14PM +0100, Rafael J. Wysocki wrote:
> On Thursday, March 19, 2015 02:29:07 PM Greg Kroah-Hartman wrote:
> > On Wed, Mar 18, 2015 at 04:02:11PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > If PM domains are in use, it may be necessary to prepare the code
> > > handling a PM domain for driver probing.  For example, in some
> > > cases device drivers rely on the ability to power on the devices
> > > with the help of the IO runtime PM framework and the PM domain
> > > code needs to be ready for that.  Also, if that code has not been
> > > fully initialized yet, the driver probing should be deferred.
> > > 
> > > Moreover, after the probing is complete, it may be necessary to
> > > put the PM domain in question into the state reflecting the current
> > > needs of the devices in it, for example, to prevent power from being
> > > drawn in vain.
> > > 
> > > For these reasons, introduce new PM domain callbacks, ->activate
> > > and ->sync, called, respectively, before probing for a device
> > > driver and after the probing has been completed.
> > > 
> > > That is not sufficient, however, because the device's PM domain
> > > pointer has to be populated for the ->activate callback to be
> > > executed, so setting it in bus type ->probe callback routines
> > > would be too late.  Also, there are bus types where PM domains
> > > are not used at all and the core should not attempt to set the
> > > pm_domain pointer for the devices on those buses.
> > > 
> > > To overcome that difficulty, introduce two new bus type
> > > callbacks, ->init and ->release, called by bus_add_device() and
> > > bus_remove_device(), respectively.  That will allow ->init to
> > > be used to populate the pm_domain pointer for the bus types
> > > that want to do that and ->release will be useful for any
> > > cleanup that may be necessary after removing a device that
> > > was part of a PM domain.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > > 
> > > It occured to me that we might want to ->sync regardless of whether or
> > > not the probing had been succenssful, so I changed the code in
> > > really_probe() along these lines.  Please let me know if that's
> > > not OK.
> > > 
> > > ---
> > >  drivers/base/bus.c     |   12 +++++++++++-
> > >  drivers/base/dd.c      |   20 ++++++++++++++------
> > >  include/linux/device.h |    5 +++++
> > >  include/linux/pm.h     |    6 ++++++
> > >  4 files changed, 36 insertions(+), 7 deletions(-)
> > > 
> > > Index: linux-pm/drivers/base/bus.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/bus.c
> > > +++ linux-pm/drivers/base/bus.c
> > > @@ -509,10 +509,15 @@ int bus_add_device(struct device *dev)
> > >  	int error = 0;
> > >  
> > >  	if (bus) {
> > > +		if (bus->init) {
> > > +			error = bus->init(dev);
> > > +			if (error)
> > > +				goto out_put;
> > > +		}
> > 
> > This doesn't make sense to me.  A bus just called bus_add_device, it can
> > do whatever it wanted to right before calling this function, no need for
> > another callback.
> 
> The only caller of bus_add_device() is device_add().
> 
> What do you mean by "bus just called bus_add_device"?  Do you think that
> the pm_domain pointer should be populated before calling device_add()?

If it's needed, sure.  The bus itself (i.e. PCI, USB, etc.) just called
device_add() which calls bus_add_device(), so it could set up the
pm_domain pointer as it knows what is up for this device.

> That wouldn't work for the ACPI PM domain at least, because ACPI companions
> are generally added during device_add() and we arguably cannot point a
> device to the ACPI PM domain before its ACPI companion is set.

I don't understand, what is not set up at device_add() time that is
somehow set up at bus_add_device() time?  Our number of callbacks seems
to be getting deep and messy :)

What happens in device_pm_add(dev); in device_add()?

> > >  		pr_debug("bus: '%s': add device %s\n", bus->name, dev_name(dev));
> > >  		error = device_add_attrs(bus, dev);
> > >  		if (error)
> > > -			goto out_put;
> > > +			goto out_release;
> > >  		error = device_add_groups(dev, bus->dev_groups);
> > >  		if (error)
> > >  			goto out_groups;
> > > @@ -534,6 +539,9 @@ out_groups:
> > >  	device_remove_groups(dev, bus->dev_groups);
> > >  out_id:
> > >  	device_remove_attrs(bus, dev);
> > > +out_release:
> > > +	if (bus->release)
> > > +		bus->release(dev);
> > 
> > >  out_put:
> > >  	bus_put(dev->bus);
> > >  	return error;
> > > @@ -597,6 +605,8 @@ void bus_remove_device(struct device *de
> > >  	device_remove_groups(dev, dev->bus->dev_groups);
> > >  	if (klist_node_attached(&dev->p->knode_bus))
> > >  		klist_del(&dev->p->knode_bus);
> > > +	if (bus->release)
> > > +		bus->release(dev);
> > 
> > Same with release(), this happens when a bus wants to remove a device,
> > it controls this, why have a callback right away?  These both shouldn't
> > be needed.
> 
> This is for symmetry with bus_add_device() and please see the argument there.
> 
> > sorry if I missed this before, I hadn't noticed these callbacks in
> > previous patches but I wasn't paying much attention.
> 
> No, they were not present before.
> 
> There are two alternatives to them.  One is to do PM domain attach/detach in
> the bus type's ->probe and ->remove, but that's suboptimal, because it is
> then carried out every time a driver is probed/removed for a device.  The
> other one would be to have each interested bus type register a bus type
> notifier for itself, but that would be rather ugly, wouldn't it?

This seems really messy, and you are adding more complexity, isn't there
some other easier way to do it with all of the different callbacks and
notifications we have today?

thanks,

greg k-h
