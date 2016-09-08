From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Thu, 08 Sep 2016 23:25:44 +0200
Message-ID: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.og>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi Everyone,

This is a refresh of the functional dependencies series that I posted last
year and which has picked up by Marek quite recently.  For reference, appended
is my introductory message sent previously (which may be slightly outdated now).

As last time, the first patch rearranges the code around __device_release_driver()
a bit to prepare it for the next one (it actually hasn't changed AFAICS).

The second patch introduces the actual device links mechanics, but without
system suspend/resume and runtime PM support which are added by the subsequent
patches.

Some bugs found by Marek during his work on these patches should be fixed
here.  In particular, the endless recursion in device_reorder_to_tail()
which simply was broken before.

There are two additional patches to address the issue with runtime PM support
that occured when runtime PM was disabled for some suppliers due to a PM
sleep transition in progress.  Those patches simply make runtime PM helpers
return 0 in that case which may be controversial, so please let me know if
there are concerns about those.

The way device_link_add() works is a bit different, as it takes an additional
status argument now.  That makes it possible to create a link in any state,
with extra care of course, and should address the problem pointed to by Lukas
during the previous discussion.

Also some comments from Tomeu have been addressed.

This hasn't been really tested yet and I'm sort of relying on Marek to test
it, because he has a use case ready.  Hence, the RFT tag on the series.

Overall, please let me know what you think.

Thanks,
Rafael


Introduction:

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
