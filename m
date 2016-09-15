From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 2/7] driver core: Functional dependencies tracking support
Date: Thu, 15 Sep 2016 03:11:55 +0200
Message-ID: <1763647.dzavfRICAb@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <2169291.li0uc2Ryoq@vostro.rjw.lan> <CAPDyKFpTeB8MLXihpTnyk9RerVC_PNp8ogXG6aATLT2xLkp9mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54151 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755955AbcIOBF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 21:05:57 -0400
In-Reply-To: <CAPDyKFpTeB8MLXihpTnyk9RerVC_PNp8ogXG6aATLT2xLkp9mA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Mark Brown <broonie@kernel.org>

On Friday, September 09, 2016 10:25:30 AM Ulf Hansson wrote:
> + Mark
> 
> On 8 September 2016 at 23:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Currently, there is a problem with handling cases where functional
> > dependencies between devices are involved.
> >
> > What I mean by a "functional dependency" is when the driver of device
> > B needs both device A and its driver to be present and functional to
> > be able to work.  This implies that the driver of A needs to be
> > working for B to be probed successfully and it cannot be unbound from
> > the device before the B's driver.  This also has certain consequences
> > for power management of these devices (suspend/resume and runtime PM
> > ordering).
> >
> > Add support for representing those functional dependencies between
> > devices to allow the driver core to track them and act on them in
> > certain cases where they matter.
> >
> > The argument for doing that in the driver core is that there are
> > quite a few distinct use cases related to that, they are relatively
> > hard to get right in a driver (if one wants to address all of them
> > properly) and it only gets worse if multiplied by the number of
> > drivers potentially needing to do it.  Morever, at least one case
> > (asynchronous system suspend/resume) cannot be handled in a single
> > driver at all, because it requires the driver of A to wait for B to
> > suspend (during system suspend) and the driver of B to wait for
> > A to resume (during system resume).
> >
> > To that end, represent links between devices (or more precisely
> > between device+driver combos) as a struct device_link object
> > containing pointers to the devices in question, a list node for
> > each of them, status information, flags, a lock and an RCU head
> > for synchronization.
> >
> > Also add two new list heads, links_to_consumers and links_to_suppliers,
> > to struct device to represent the lists of links to the devices that
> > depend on the given one (consumers) and to the devices depended on
> > by it (suppliers), respectively.
> >
> > The entire data structure consisting of all of the lists of link
> > objects for all devices is protected by SRCU (for list walking)
> > and a by mutex (for link object addition/removal).  In addition
> > to that, each link object has an internal status field whose
> > value reflects what's happening to the devices pointed to by
> > the link.  That status field is protected by an internal spinlock.
> >
> > New links are added by calling device_link_add() which may happen
> > either before the consumer device is probed or when probing it, in
> > which case the caller must ensure that the driver of the supplier
> > device is present and functional and the DEVICE_LINK_SUPPLIER_READY
> > flag must be passed to device_link_add() to reflect that.
> >
> > Link objects are deleted either explicitly, by calling
> > device_link_del() on the link object in question, or automatically,
> > when the consumer device is unbound from its driver or when one
> > of the target devices is deleted, depending on the link type.
> >
> > There are two types of link objects, persistent and non-persistent.
> > The persistent ones stay around until one of the target devices is
> > deleted, while the non-persistent ones are deleted when the consumer
> > driver is unbound from its device (ie. they are assumed to be valid
> > only as long as the consumer device has a driver bound to it).  The
> > DEVICE_LINK_PERSISTENT flag is passed to device_link_add() to create
> > a persistent link and it cannot be used for links created at the
> > consumer probe time (that is, persistent links must be created before
> > probing the consumer devices).
> >
> > One of the actions carried out by device_link_add() is to reorder
> > the lists used for device shutdown and system suspend/resume to
> > put the consumer device along with all of its children and all of
> > its consumers (and so on, recursively) to the ends of those list
> > in order to ensure the right ordering between the all of the supplier
> > and consumer devices.
> 
> Rafael, thanks for working on this and re-spinning this series. It's
> indeed very interesting!

Well, you're welcome. :-)

> I am hoping "device links" should be able to solve some of those
> device ordering issues I have observed for several SoCs, particularly
> during system PM and in combination with runtime PM.
> 
> I intend to test the series as soon as I can and try to deploy it to
> see if it solves some of the issues I have seen. I will also try to
> review in more detail. No promises short term though. :-)

All feedback will be appreciated.

I think I'll send an update of it tomorrow, though.

> BTW, as I am mostly working on DT based platforms, I guess we would
> later on need to discuss with the DT maintainers how to describe
> device links.
> 
> A minor comment to the change-log. I would appreciate some information
> about "error" handling. Especially, what happens in the driver core
> when it's about to probe a device with a configured device link, but
> the link hasn’t been established yet (the other device isn't
> successfully probed). In the ideal scenario this shouldn't happen, but
> of course it will. So I assume the driver core relies on the existing
> deferred probe mechanism for this.

Yes, it does.  I'll update the changelog with this information.

Thanks,
Rafael

