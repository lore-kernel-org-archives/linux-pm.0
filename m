From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
Date: Wed, 18 Mar 2015 14:41:47 +0100
Message-ID: <CAPDyKFp_xjOOxCEu7GtWwamkWYffhN-oJ3B78-4xC5RFS-qFdQ@mail.gmail.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
	<37566526.IvGLQo2usO@vostro.rjw.lan>
	<CAPDyKFpO+3m37bpkzi_rTXpko0Zk+hAYD11e1Jjw01YR12KFdA@mail.gmail.com>
	<2524443.vpfcNqfmJz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34376 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118AbbCRNls (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 09:41:48 -0400
Received: by qgh62 with SMTP id 62so36641481qgh.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2015 06:41:48 -0700 (PDT)
In-Reply-To: <2524443.vpfcNqfmJz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 18 March 2015 at 02:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, March 17, 2015 03:40:47 PM Ulf Hansson wrote:
>> On 17 March 2015 at 15:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Tuesday, March 17, 2015 10:27:03 AM Ulf Hansson wrote:
>> >> On 17 March 2015 at 04:01, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > On Monday, March 16, 2015 10:26:46 AM Ulf Hansson wrote:
>> >> >> On 14 March 2015 at 02:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> >> > On Friday, March 13, 2015 04:43:41 PM Ulf Hansson wrote:
>> >> >> >> There may be more than one device in a PM domain which then will be
>> >> >> >> probed at different points in time.
>> >> >> >>
>> >> >> >> Depending on timing and runtime PM support, in for the device related
>> >> >> >> driver/subsystem, a PM domain may be advised to power off after a
>> >> >> >> successful probe sequence.
>> >> >> >>
>> >> >> >> A general requirement for a device within a PM domain, is that the
>> >> >> >> PM domain must stay powered during the probe sequence. To cope with
>> >> >> >> such requirement, let's add the dev_pm_domain_get|put() APIs.
>> >> >> >>
>> >> >> >> These APIs are intended to be invoked from subsystem-level code and the
>> >> >> >> calls between get/put needs to be balanced.
>> >> >> >>
>> >> >> >> dev_pm_domain_get(), tells the PM domain that it needs to increase a
>> >> >> >> usage count and to keep supplying power. dev_pm_domain_put(), does the
>> >> >> >> opposite.
>> >> >> >>
>> >> >> >> For a PM domain to support this feature, it must implement the optional
>> >> >> >> ->get|put() callbacks.
>> >> >> >>
>> >> >> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> >> >> ---
>> >> >> >>  drivers/base/power/common.c | 40 ++++++++++++++++++++++++++++++++++++++++
>> >> >> >>  include/linux/pm.h          |  2 ++
>> >> >> >>  include/linux/pm_domain.h   |  4 ++++
>> >> >> >>  3 files changed, 46 insertions(+)
>> >> >> >>
>> >> >> >> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> >> >> >> index f32b802..99225af 100644
>> >> >> >> --- a/drivers/base/power/common.c
>> >> >> >> +++ b/drivers/base/power/common.c
>> >> >> >> @@ -128,3 +128,43 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>> >> >> >>               dev->pm_domain->detach(dev, power_off);
>> >> >> >>  }
>> >> >> >>  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
>> >> >> >> +
>> >> >> >> +/**
>> >> >> >> + * dev_pm_domain_get - Increase usage count to keep a PM domain powered.
>> >> >> >> + * @domain: The PM domain to operate on.
>> >> >> >> + *
>> >> >> >> + * This function will not by itself increase the usage count, that's up to each
>> >> >> >> + * PM domain implementation to support. Typically it should be invoked from
>> >> >> >> + * subsystem level code prior drivers starts probing.
>> >> >> >> + *
>> >> >> >> + * Do note, it's optional to implement the ->get() callback for a PM domain.
>> >> >> >> + *
>> >> >> >> + * Returns 0 on successfully increased usage count or negative error code.
>> >> >> >> + */
>> >> >> >> +int dev_pm_domain_get(struct dev_pm_domain *domain)
>> >> >> >> +{
>> >> >> >> +     int ret = 0;
>> >> >> >> +
>> >> >> >> +     if (domain && domain->get)
>> >> >> >> +             ret = domain->get(domain);
>> >> >> >> +
>> >> >> >> +     return ret;
>> >> >> >> +}
>> >> >> >> +EXPORT_SYMBOL_GPL(dev_pm_domain_get);
>> >> >> >> +
>> >> >> >> +/**
>> >> >> >> + * dev_pm_domain_put - Decrease usage count to allow a PM domain to power off.
>> >> >> >> + * @domain: The PM domain to operate on.
>> >> >> >> + *
>> >> >> >> + * This function will not by itself decrease the usage count, that's up to each
>> >> >> >> + * PM domain implementation to support. Typically it should be invoked from
>> >> >> >> + * subsystem level code after drivers has finished probing.
>> >> >> >> + *
>> >> >> >> + * Do note, it's optional to implement the ->put() callback for a PM domain.
>> >> >> >> + */
>> >> >> >> +void dev_pm_domain_put(struct dev_pm_domain *domain)
>> >> >> >> +{
>> >> >> >> +     if (domain && domain->put)
>> >> >> >> +             domain->put(domain);
>> >> >> >> +}
>> >> >> >> +EXPORT_SYMBOL_GPL(dev_pm_domain_put);
>> >> >> >> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> >> >> >> index e2f1be6..e62330b 100644
>> >> >> >> --- a/include/linux/pm.h
>> >> >> >> +++ b/include/linux/pm.h
>> >> >> >> @@ -607,6 +607,8 @@ extern void dev_pm_put_subsys_data(struct device *dev);
>> >> >> >>  struct dev_pm_domain {
>> >> >> >>       struct dev_pm_ops       ops;
>> >> >> >>       void (*detach)(struct device *dev, bool power_off);
>> >> >> >> +     int (*get)(struct dev_pm_domain *domain);
>> >> >> >> +     void (*put)(struct dev_pm_domain *domain);
>> >> >> >
>> >> >> > I don't like these names.  They suggest that it's always going to be about
>> >> >> > reference counting which doesn't have to be the case in principle.
>> >> >>
>> >> >> I am happy to change, you don't happen to have a proposal? :-)
>> >> >>
>> >> >> For genpd we already have these related APIs:
>> >> >>
>> >> >> pm_genpd_poweron()
>> >> >> pm_genpd_name_poweron()
>> >> >> pm_genpd_poweroff_unused()
>> >> >>
>> >> >> Theoretically we should be able to replace these with
>> >> >> dev_pm_domain_get|put() or whatever we decide to name them to.
>> >> >>
>> >> >> >
>> >> >> > Also what about calling these from the driver core, ie. really_probe()?
>> >> >>
>> >> >> I like that!
>> >> >>
>> >> >> That also implies moving the calls to dev_pm_domain_attach|detach()
>> >> >> out of the buses and into the drivercore, since we need the PM domain
>> >> >> to be attached before calling dev_pm_domain_get|put(). I assume that's
>> >> >> what you also propose me to change, right?
>> >> >
>> >> > Not really.  I don't want to inflict the ACPI PM domain on every bus type
>> >> > that may not be prepared for using it or even may not want to use it (like
>> >> > PCI or PNP).  That applies to genpd too to some extent.
>> >> >
>> >> > So bus types need to be able to opt in for using "default" PM domains, but
>> >> > at the same time if they do, the core is a better place to invoke the
>> >> > callbacks.
>> >>
>> >> Okay!
>> >>
>> >> >
>> >> > The patch below shows how that can be done.  For the bus types using
>> >> > genpd or the ACPI PM domain today ->pm_domain_init and ->pm_domain_exit
>> >> > may point to the routines initializing/detaching those (which also will help
>> >> > to reduce code duplication somewhat) and that guarantees that the domains
>> >> > will be attached to devices before probing and the core can do the ->pre_probe
>> >> > and ->post_probe things for everybody.
>> >>
>> >> Overall, this seem like a very good idea!
>> >>
>> >> >
>> >> > Rafael
>> >> >
>> >> >
>> >> > ---
>> >> >  drivers/base/bus.c     |   12 +++++++++++-
>> >> >  drivers/base/dd.c      |    9 +++++++++
>> >> >  include/linux/device.h |    3 +++
>> >> >  include/linux/pm.h     |    2 ++
>> >> >  4 files changed, 25 insertions(+), 1 deletion(-)
>> >> >
>> >> > Index: linux-pm/drivers/base/bus.c
>> >> > ===================================================================
>> >> > --- linux-pm.orig/drivers/base/bus.c
>> >> > +++ linux-pm/drivers/base/bus.c
>> >> > @@ -509,10 +509,15 @@ int bus_add_device(struct device *dev)
>> >> >         int error = 0;
>> >> >
>> >> >         if (bus) {
>> >> > +               if (bus->pm_domain_init) {
>> >> > +                       error = bus->pm_domain_init(dev);
>> >> > +                       if (error)
>> >> > +                               goto out_put;
>> >> > +               }
>> >> >                 pr_debug("bus: '%s': add device %s\n", bus->name, dev_name(dev));
>> >> >                 error = device_add_attrs(bus, dev);
>> >> >                 if (error)
>> >> > -                       goto out_put;
>> >> > +                       goto out_pm_domain;
>> >> >                 error = device_add_groups(dev, bus->dev_groups);
>> >> >                 if (error)
>> >> >                         goto out_groups;
>> >> > @@ -534,6 +539,9 @@ out_groups:
>> >> >         device_remove_groups(dev, bus->dev_groups);
>> >> >  out_id:
>> >> >         device_remove_attrs(bus, dev);
>> >> > +out_pm_domain:
>> >> > +       if (bus->pm_domain_exit)
>> >> > +               bus->pm_domain_exit(dev);
>> >> >  out_put:
>> >> >         bus_put(dev->bus);
>> >> >         return error;
>> >>
>> >> To make this work for bus_add_device(), we first need to change the
>> >> registration procedure for genpd DT providers. Currently that's done
>> >> when "PM domain drivers" invokes the __of_genpd_add_provider() API,
>> >> from SoC specific code and from different init levels.
>> >>
>> >> We need to have the available gendp DT providers registered when the
>> >> ->pm_domain_init() callback is invoked.
>> >>
>> >> Besides the changes above, genpd also needs to deal with attached
>> >> devices, but which don't have a corresponding driver bound. I believe
>> >> we have some corner cases to fix around this as well.
>> >>
>> >> As an intermediate step, how about adding the similar code as above
>> >> but into really_probe()? For the code in bus_remove_device() below, we
>> >> could add that into __device_release_driver()?
>> >
>> > Well, I wouldn't really like to add new callbacks to struct bus_type for
>> > intermediate steps, because that's guaranteed to lead to confusion.
>> >
>> > So I think the infrastructure is better added first and users may be
>> > switched over to it gradually.
>> >
>> > I don't see any particular problems with moving the ACPI PM domain
>> > attach/detach to bus_add/remove_device(), so that can be done as the first
>> > step.  As for genpd, it can implement the ->post_probe thing first and do
>> > the rest in the bus type ->probe until the generic code is ready.
>>
>> Yes, that works.
>>
>> I will cook a new version of the patchset according to your suggestions.
>
> I'll send a cleaner version of my patch tomorrow (I actually would like to
> use different names for the new callbacks).

Okay, great!

>
> Also I can do the ACPI part of the work, please let me know if you want me to.

Appreciate your help! I wouldn't mind giving this a quick try. If I am
way off, just nack the patches and then please help out implement it.

Kind regards
Uffe
