From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 24 Nov 2015 17:28:30 +0100
Message-ID: <8237460.0xoaSWl3eB@vostro.rjw.lan>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <5195200.TAaTCrzPYp@vostro.rjw.lan> <56547AC5.8030101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52149 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753335AbbKXP6w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 10:58:52 -0500
In-Reply-To: <56547AC5.8030101@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Tuesday, November 24, 2015 03:57:09 PM Andrzej Hajda wrote:
> On 11/19/2015 11:04 PM, Rafael J. Wysocki wrote:
> > On Thursday, November 19, 2015 10:08:43 AM Andrzej Hajda wrote:
> >> On 11/18/2015 03:17 AM, Rafael J. Wysocki wrote:
> >>> On Tuesday, November 17, 2015 01:44:59 PM Andrzej Hajda wrote:
> >>>> Hi Rafael,
> >>>>
> > [cut]
> >
> >>> So the operations that need to be taken care of are:
> >>> - Probe (suppliers need to be probed before consumers if the dependencies are
> >>>   known beforehand).
> >>> - System suspend/resume (suppliers need to be suspended after consumers and
> >>>   resumed before them) which may be asynchronous (so simple re-ordering doesn't
> >>>   help).
> >>> - Runtime PM (suppliers should not be suspended if the consumers are not
> >>>   suspended).
> >> I though provider's frameworks are taking care of it already. For example
> >> clock provider cannot suspend until there are prepared/enabled clocks.
> >> Similar enabled regulators, phys should block provider from runtime pm
> >> suspending.
> >>
> >> Are there situations/frameworks which requires additional care?
> > Yes, there are, AFAICS.
> >
> > A somewhat extreme example of this is when an AML routine needed for power
> > management of one device uses something like a GPIO line or an I2C link
> > provided by another one.  We don't even have a way to track that kind of
> > thing at the provider framework level and the only information we can get
> > from the platform firmware is "this device depends on that one".
> >
> > Plus, even if the frameworks track those things, when a device suspend is
> > requested, the question really is "Are there any devices that have to be
> > suspended before this one?" rather than "Are other devices using resources
> > provided by this one?".  Of course, you may argue that answering the second
> > one will allow you to answer the first one too (that is based on the assumption
> > that you can always track all cases of resource utilization which may not be
> > entirely realistic), but getting that answer in a non-racy way may be rather
> > expensive.
> 
> In such extreme case the device itself can play a role of resource.
> But in my proposal I do not try to answer which devices/resource depends
> on which ones, we do not need such info.
> It is just matter of notifying direct consumers about change of availability
> of given resource, and this notification is necessary anyway if we want
> to support hot resource/drivers (un-)plugging.

Well, we've been supporting hotplug for quite a while without that ...

You seem to be referring to situations in which individual resources may go
away and drivers are supposed to reconfigure themselves on the fly.

This is not what the $subject proposal is about.

> >
> >>> - System shutdown (shutdown callbacks should be executed for consumers first).
> >>> - Driver unbind (a supplier driver cannot be unbound before any of its consumer
> >>>   drivers).
> >>>
> >>> In principle you can use resource tracking to figure out all of the involved
> >>> dependencies, but that would require walking complicated data structures unless
> >>> you add an intermediate "device dependency" layer which is going to be analogous
> >>> to the one discussed here.
> >> It should be enough if provider notifies consumers that the resource
> >> will be unavailable.
> > To me, this isn't going in the right direction.  You should be asking "Am I
> > allowed to suspend now?" instead of saying "I'm suspending and now you deal
> > with it" to somebody.  Why is that so?  Because the other end may simply be
> > unable to deal with the situation in the first place.
> 
> No. It is just saying "I want to suspend now, please not use my resources".
> In such case consumer should unprepare clocks, disable regulators, etc.
> But if it is not able to do so it just ignores the request. Provider
> will know
> anyway that his resources are in use and will not suspend.

This goes beyond the runtime PM framework which is based on device reference
counting and for system suspend it's not practical at all, because one driver
refusing to suspend aborts the entire operation system-wide.

> >>>>> My idea is to represent a supplier-consumer dependency between devices (or
> >>>>> more precisely between device+driver combos) as a "link" object containing
> >>>>> pointers to the devices in question, a list node for each of them and some
> >>>>> additional information related to the management of those objects, ie.
> >>>>> something like:
> >>>>>
> >>>>> struct device_link {
> >>>>> 	struct device *supplier;
> >>>>> 	struct list_head supplier_node;
> >>>>> 	struct device *consumer;
> >>>>> 	struct list_head consumer_node;
> >>>>> 	<flags, status etc>
> >>>>> };
> >>>>>
> >>>>> In general, there will be two lists of those things per device, one list
> >>>>> of links to consumers and one list of links to suppliers.
> >>>>>
> >>>>> In that picture, links will be created by calling, say:
> >>>>>
> >>>>> int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);
> >>>>>
> >>>>> and they will be deleted by the driver core when not needed any more.  The
> >>>>> creation of a link should also cause dpm_list and the list used during shutdown
> >>>>> to be reordered if needed.
> >>>>>
> >>>>> In principle, it seems usefult to consider two types of links, one created
> >>>>> at device registration time (when registering the second device from the linked
> >>>>> pair, whichever it is) and one created at probe time (of the consumer device).
> >>>>> I'll refer to them as "permanent" and "probe-time" links, respectively.
> >>>>>
> >>>>> The permanent links (created at device registration time) will stay around
> >>>>> until one of the linked devices is unregistered (at which time the driver
> >>>>> core will drop the link along with the device going away).  The probe-time
> >>>>> ones will be dropped (automatically) at the consumer device driver unbind time.
> >>>> What about permanent links in case provider is unregistered? Should they
> >>>> disappear? It will not make consumers happy. What if the provider will be
> >>>> re-registered.
> >>> If the device object is gone, it cannot be pointed to by any links (on any end)
> >>> any more.  That's just physically impossible. :-)
> >> So the link will disappear and the 'consumer' will have dependencies
> >> fulfilled.
> > That's why in my opinion the rule should be that all consumers are unbound from
> > their drivers before the supplier is unbound from its driver.
> 
> But the rule will not work with 'weak' dependencies.

No, it won't.  Enough of them are actually hard, though, for this to be
a relevant case anyway.

[cut]

> 
> Lets drop my impressions, as there is no specification to verify it.
> 
> What about resources which are present in device node, but driver do
> not use for some reason? Only driver knows which ones it requires in
> the specific scenario. Real example: HDMI node can contain links
> to SPDIF/audio clocks but since kernel is compiled without audio it
> will not use them at all. How do driver core will know about it.

It won't know about then automatically.  It needs to be told about
whether or not a dependency is there, either by a driver or by a bus type
or a framework of some sort   And since the driver core works with device
objects in general, this is the "granularity" it can handle.

[cut]

> 
> But there are cases devices can work without some resources.
> 

Yes, there are.

> > It may be a good idea to reprobe them then in case they can work without the
> > missing supplier too, or to put them into the deferred probe list in case the
> > supplier appears again.  All of that is sort of academic, though, unless we
> > have real use cases like that to deal with.
> 
> Real hardware case(it is not correctly modeled in drivers):
> HDMI generates clock, which is used by Display Controller.
> Display Controller then generates new clock based on the 1st one.
> The latter is used by HDMI.
> This is real example from latest Exynos SoCs.
> How do you want to model these dependencies using devices?

I don't want to model them with devices at all and this is not the point here.

The point (as I said once already) is to make it possible to tell the driver
core of a functional dependency between *devices* in which case it will take
that dependency into account automatically in several important situations,
so the drivers of those devices won't need to worry about their respective
ordering etc.

You seem to be saying that this is not useful and quite honestly I'm not
really sure why.

Thanks,
Rafael

