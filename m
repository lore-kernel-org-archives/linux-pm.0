From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 17 Nov 2015 13:44:59 +0100
Message-ID: <564B214B.8030602@samsung.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Please forgive me late reply, but I have missed this thread before.

On 10/27/2015 04:24 PM, Rafael J. Wysocki wrote:
> Hi All,
> 
> As discussed in the recent "On-demand device probing" thread and in a Kernel
> Summit session earlier today, there is a problem with handling cases where
> functional dependencies between devices are involved.
> 
> What I mean by a "functional dependency" is when the driver of device B needs
> both device A and its driver to be present and functional to be able to work.
> This implies that the driver of A needs to be working for B to be probed
> successfully and it cannot be unbound from the device before the B's driver.
> This also has certain consequences for power management of these devices
> (suspend/resume and runtime PM ordering).

I think the real dependency is when some entity asks for some resource (irq,
clock, gpio,...). Usually the entity is some device driver during probing and
the resource is provided by some bound device but there are many exceptions for
this scenario:
- many clock providers, irq domains are not provided by devices,
- there are also dependencies between clock providers, ie. some clock provider
requires clocks provided by another clock provider, so the entity is also not a
device driver,
- there are resources which can be requested after probe - case of componentized
devices (DRM for example), more precisely they can be requested during probe of
random component or master of componentized device,
- another case are requests for some additional/optional resources after device
driver probe, for example phone usually does not require HDMI related resources
until user attach HDMI cable,
- (semi-)circular dependencies - 1st device provides clock used by other devices
which provides other resources used by the 1st device, scenario present in some
video pipelines, like camera subsystem + sensors.

These examples shows that dependencies between bound device drivers are just
subset of bigger issue, maybe it is worth to look for more general solution.


> 
> So I want to be able to represent those functional dependencies between devices
> and I'd like the driver core to track them and act on them in certain cases
> where they matter.  The argument for doing that in the driver core is that
> there are quite a few distinct use cases related to that, they are relatively
> hard to get right in a driver (if one wants to address all of them properly)
> and it only gets worse if multiplied by the number of drivers potentially
> needing to do it.  Morever, at least one case (asynchronous system suspend/resume)
> cannot be handled in a single driver at all, because it requires the driver of A
> to wait for B to suspend (during system suspend) and the driver of B to wait for
> A to resume (during system resume).

Could you elaborate these distinct use cases. I am curious because I have
proposed resource tracking framework [1] which should solve most of the issues
described here. It was not designed to solve suspend/resume issues, but it could
be easily extended to support it, I suppose.

[1]: https://lkml.org/lkml/2014/12/10/342

> 
> My idea is to represent a supplier-consumer dependency between devices (or
> more precisely between device+driver combos) as a "link" object containing
> pointers to the devices in question, a list node for each of them and some
> additional information related to the management of those objects, ie.
> something like:
> 
> struct device_link {
> 	struct device *supplier;
> 	struct list_head supplier_node;
> 	struct device *consumer;
> 	struct list_head consumer_node;
> 	<flags, status etc>
> };
> 
> In general, there will be two lists of those things per device, one list
> of links to consumers and one list of links to suppliers.
> 
> In that picture, links will be created by calling, say:
> 
> int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);
> 
> and they will be deleted by the driver core when not needed any more.  The
> creation of a link should also cause dpm_list and the list used during shutdown
> to be reordered if needed.
> 
> In principle, it seems usefult to consider two types of links, one created
> at device registration time (when registering the second device from the linked
> pair, whichever it is) and one created at probe time (of the consumer device).
> I'll refer to them as "permanent" and "probe-time" links, respectively.
> 
> The permanent links (created at device registration time) will stay around
> until one of the linked devices is unregistered (at which time the driver
> core will drop the link along with the device going away).  The probe-time
> ones will be dropped (automatically) at the consumer device driver unbind time.

What about permanent links in case provider is unregistered? Should they
disappear? It will not make consumers happy. What if the provider will be
re-registered.

> 
> There's a question about what if the supplier device is being unbound before
> the consumer one (for example, as a result of a hotplug event).  My current
> view on that is that the consumer needs to be force-unbound in that case too,
> but I guess I may be persuaded otherwise given sufficiently convincing
> arguments.

Some devices can have 'weak' dependencies - they will be still functional
without some resources. In fact two last examples from my 1st paragraph are
counter-examples for this. I suspect there should be some kind of notification
for them about removal of the resource.

> Anyway, there are reasons to do that, like for example it may
> help with the synchronization.  Namely, if there's a rule that suppliers
> cannot be unbound before any consumers linked to them, than the list of links
> to suppliers for a consumer can only change at its registration/probe or
> unbind/remove times (which simplifies things quite a bit).
> 
> With that, the permanent links existing at the probe time for a consumer
> device can be used to check whether or not to defer the probing of it
> even before executing its probe callback.  In turn, system suspend
> synchronization should be a matter of calling device_pm_wait_for_dev()
> for all consumers of a supplier device, in analogy with dpm_wait_for_children(),
> and so on.
> 
> Of course, the new lists have to be stable during those operations and ensuring
> that is going to be somewhat tricky (AFAICS right now at least), but apart from
> that the whole concept looks reasonably straightforward to me.
> 
> So, the question to everybody is whether or not this sounds reasonable or there
> are concerns about it and if so what they are.  At this point I mostly need to
> know if I'm not overlooking anything fundamental at the general level.

Regarding fundamental things, maybe it is just my impression but parsing private
DT device nodes by kernel core assumes that convention about using resource
specifiers in DT is a strict rule, it should not be true.

As I wrote before I have send some early RFC with framework which solves most of
the problems described here[1], the missing part is suspend/resume support which
should be quite easy to add, I suspect. Moreover it solves problem of device
driver hot bind/unbind.
Could you take a look at it, I will be glad to know it is worth to continue work
on it?

[1]: https://lkml.org/lkml/2014/12/10/342


Regards
Andrzej

> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
