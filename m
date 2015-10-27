From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFD] Functional dependencies between devices
Date: Tue, 27 Oct 2015 16:24:14 +0100
Message-ID: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46934 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932425AbbJ0OzT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 10:55:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

Hi All,

As discussed in the recent "On-demand device probing" thread and in a Kernel
Summit session earlier today, there is a problem with handling cases where
functional dependencies between devices are involved.

What I mean by a "functional dependency" is when the driver of device B needs
both device A and its driver to be present and functional to be able to work.
This implies that the driver of A needs to be working for B to be probed
successfully and it cannot be unbound from the device before the B's driver.
This also has certain consequences for power management of these devices
(suspend/resume and runtime PM ordering).

So I want to be able to represent those functional dependencies between devices
and I'd like the driver core to track them and act on them in certain cases
where they matter.  The argument for doing that in the driver core is that
there are quite a few distinct use cases related to that, they are relatively
hard to get right in a driver (if one wants to address all of them properly)
and it only gets worse if multiplied by the number of drivers potentially
needing to do it.  Morever, at least one case (asynchronous system suspend/resume)
cannot be handled in a single driver at all, because it requires the driver of A
to wait for B to suspend (during system suspend) and the driver of B to wait for
A to resume (during system resume).

My idea is to represent a supplier-consumer dependency between devices (or
more precisely between device+driver combos) as a "link" object containing
pointers to the devices in question, a list node for each of them and some
additional information related to the management of those objects, ie.
something like:

struct device_link {
	struct device *supplier;
	struct list_head supplier_node;
	struct device *consumer;
	struct list_head consumer_node;
	<flags, status etc>
};

In general, there will be two lists of those things per device, one list
of links to consumers and one list of links to suppliers.

In that picture, links will be created by calling, say:

int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);

and they will be deleted by the driver core when not needed any more.  The
creation of a link should also cause dpm_list and the list used during shutdown
to be reordered if needed.

In principle, it seems usefult to consider two types of links, one created
at device registration time (when registering the second device from the linked
pair, whichever it is) and one created at probe time (of the consumer device).
I'll refer to them as "permanent" and "probe-time" links, respectively.

The permanent links (created at device registration time) will stay around
until one of the linked devices is unregistered (at which time the driver
core will drop the link along with the device going away).  The probe-time
ones will be dropped (automatically) at the consumer device driver unbind time.

There's a question about what if the supplier device is being unbound before
the consumer one (for example, as a result of a hotplug event).  My current
view on that is that the consumer needs to be force-unbound in that case too,
but I guess I may be persuaded otherwise given sufficiently convincing
arguments.  Anyway, there are reasons to do that, like for example it may
help with the synchronization.  Namely, if there's a rule that suppliers
cannot be unbound before any consumers linked to them, than the list of links
to suppliers for a consumer can only change at its registration/probe or
unbind/remove times (which simplifies things quite a bit).

With that, the permanent links existing at the probe time for a consumer
device can be used to check whether or not to defer the probing of it
even before executing its probe callback.  In turn, system suspend
synchronization should be a matter of calling device_pm_wait_for_dev()
for all consumers of a supplier device, in analogy with dpm_wait_for_children(),
and so on.

Of course, the new lists have to be stable during those operations and ensuring
that is going to be somewhat tricky (AFAICS right now at least), but apart from
that the whole concept looks reasonably straightforward to me.

So, the question to everybody is whether or not this sounds reasonable or there
are concerns about it and if so what they are.  At this point I mostly need to
know if I'm not overlooking anything fundamental at the general level.

Thanks,
Rafael

