From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] driver core / PM: Add callbacks for PM domain initialization/cleanup
Date: Thu, 19 Mar 2015 14:16:32 +0100
Message-ID: <CAPDyKFpAfCZR2LxqjCg4JxKgTuwuMMv1HigdNkUjL4-ENXBQZQ@mail.gmail.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
	<2317791.ICLpdqLgyu@vostro.rjw.lan>
	<CAPDyKFp6=16HuRLC=M+mJavGVy=jEG6+=xKTTHa+V7QVJDxxkw@mail.gmail.com>
	<1937500.ipRbAIt7Og@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:36606 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbbCSNQd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 09:16:33 -0400
Received: by qcto4 with SMTP id o4so65287564qct.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 06:16:32 -0700 (PDT)
In-Reply-To: <1937500.ipRbAIt7Og@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 March 2015 at 12:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, March 19, 2015 09:49:19 AM Ulf Hansson wrote:
>> On 18 March 2015 at 16:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > If PM domains are in use, it may be necessary to prepare the code
>> > handling a PM domain for driver probing.  For example, in some
>> > cases device drivers rely on the ability to power on the devices
>> > with the help of the IO runtime PM framework and the PM domain
>> > code needs to be ready for that.  Also, if that code has not been
>> > fully initialized yet, the driver probing should be deferred.
>> >
>> > Moreover, after the probing is complete, it may be necessary to
>> > put the PM domain in question into the state reflecting the current
>> > needs of the devices in it, for example, to prevent power from being
>> > drawn in vain.
>> >
>> > For these reasons, introduce new PM domain callbacks, ->activate
>> > and ->sync, called, respectively, before probing for a device
>> > driver and after the probing has been completed.
>> >
>> > That is not sufficient, however, because the device's PM domain
>> > pointer has to be populated for the ->activate callback to be
>> > executed, so setting it in bus type ->probe callback routines
>> > would be too late.  Also, there are bus types where PM domains
>> > are not used at all and the core should not attempt to set the
>> > pm_domain pointer for the devices on those buses.
>> >
>> > To overcome that difficulty, introduce two new bus type
>> > callbacks, ->init and ->release, called by bus_add_device() and
>> > bus_remove_device(), respectively.  That will allow ->init to
>> > be used to populate the pm_domain pointer for the bus types
>> > that want to do that and ->release will be useful for any
>> > cleanup that may be necessary after removing a device that
>> > was part of a PM domain.
>> >
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > ---
>> >
>> > It occured to me that we might want to ->sync regardless of whether or
>> > not the probing had been succenssful, so I changed the code in
>> > really_probe() along these lines.  Please let me know if that's
>> > not OK.
>>
>> Make perfect sense!
>>
>> >
>> > ---
>> >  drivers/base/bus.c     |   12 +++++++++++-
>> >  drivers/base/dd.c      |   20 ++++++++++++++------
>> >  include/linux/device.h |    5 +++++
>> >  include/linux/pm.h     |    6 ++++++
>> >  4 files changed, 36 insertions(+), 7 deletions(-)
>> >
>> > Index: linux-pm/drivers/base/bus.c
>> > ===================================================================
>> > --- linux-pm.orig/drivers/base/bus.c
>> > +++ linux-pm/drivers/base/bus.c
>> > @@ -509,10 +509,15 @@ int bus_add_device(struct device *dev)
>> >         int error = 0;
>> >
>> >         if (bus) {
>> > +               if (bus->init) {
>> > +                       error = bus->init(dev);
>> > +                       if (error)
>> > +                               goto out_put;
>> > +               }
>> >                 pr_debug("bus: '%s': add device %s\n", bus->name, dev_name(dev));
>> >                 error = device_add_attrs(bus, dev);
>> >                 if (error)
>> > -                       goto out_put;
>> > +                       goto out_release;
>> >                 error = device_add_groups(dev, bus->dev_groups);
>> >                 if (error)
>> >                         goto out_groups;
>> > @@ -534,6 +539,9 @@ out_groups:
>> >         device_remove_groups(dev, bus->dev_groups);
>> >  out_id:
>> >         device_remove_attrs(bus, dev);
>> > +out_release:
>> > +       if (bus->release)
>> > +               bus->release(dev);
>> >  out_put:
>> >         bus_put(dev->bus);
>> >         return error;
>> > @@ -597,6 +605,8 @@ void bus_remove_device(struct device *de
>> >         device_remove_groups(dev, dev->bus->dev_groups);
>> >         if (klist_node_attached(&dev->p->knode_bus))
>> >                 klist_del(&dev->p->knode_bus);
>> > +       if (bus->release)
>> > +               bus->release(dev);
>>
>> I think we should move this new code block below the call to
>> device_release_driver(), since else the bus'/driver's ->remove()
>> callbacks may be invoked after the ->pm_domain pointer for the device
>> has been removed.
>
> Good point, I'll fix that.
>
>> Moving the code below the call to device_release_driver() also means
>> device's devm* managed resources will be freed prior invoking the bus'
>> ->release() callback. Genpd don't have any issues to cope with that I
>> believe that's okay for ACPI as well, but not sure.
>
> It is.
>
>> Moreover, considering the case where device won't be removed but only
>> its corresponding driver. In that case, the PM domain won't be
>> notified other than through runtime PM transitions. I don't think
>> that's enough, we will likely need to add yet another callback in the
>> struct dev_pm_domain, to be invoked from __device_release_driver().
>
> Right, so do we want to ->sync then or do we want a separate callback?

For genpd, I guess using ->sync() should work.

Typically I envision the ->sync() callback for genpd to check whether
runtime PM is enabled or disabled for the device
(pm_runtime_enable()), at take appropriate actions.

The prerequisite to make this work, is that all drivers/buses make
sure to disable runtime PM from their ->remove() callbacks. I guess we
should expect them to behave like this, else they must be fixed.

>
> The only use case I have which is not genpd doesn't need that, so genpd
> will be the only user of it for the time being.
>

Currently acpi_dev_pm_attach() do more things than just assigning the
device's pm_domain pointer.

My idea was to split that into two parts.

1) The first part takes care of assigning the device's pm_domain
pointer to "&acpi_general_pm_domain" which is done when bus_type's
->init() callback get invoked.

2) The second part, which basically will be the remaining operations
from acpi_dev_pm_attach(), should be done from the PM domain's
->activate() callback.

To be able to reverse these actions (acpi_dev_pm_dettach()), for both
device-remove and driver-remove, don't you think ACPI also will need
to get some notification from a callback, during
__device_release_driver()?

Kind regards
Uffe
