From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Mon, 7 Nov 2016 22:39:54 +0100
Message-ID: <20161107213954.GI1764@wotan.suse.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35367 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbcKGVkD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Nov 2016 16:40:03 -0500
Content-Disposition: inline
In-Reply-To: <2715729.9U1nlcpFb3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Andrzej Hajda <a.hajda@samsung.com>

On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, there is a problem with taking functional dependencies
> between devices into account.
> 
> What I mean by a "functional dependency" is when the driver of device
> B needs device A to be functional and (generally) its driver to be
> present in order to work properly.  This has certain consequences
> for power management (suspend/resume and runtime PM ordering) and
> shutdown ordering of these devices.  In general, it also implies that
> the driver of A needs to be working for B to be probed successfully
> and it cannot be unbound from the device before the B's driver.
> 
> Support for representing those functional dependencies between
> devices is added here to allow the driver core to track them and act
> on them in certain cases where applicable.
> 
> The argument for doing that in the driver core is that there are
> quite a few distinct use cases involving device dependencies, they
> are relatively hard to get right in a driver (if one wants to
> address all of them properly) and it only gets worse if multiplied
> by the number of drivers potentially needing to do it.

How many drivers actually *need this* today for suspend / resume ?

How many of these are because of ACPI firmware bugs rather than
some other reason ?

Can ACPI somehow be used instead by these devices to address quirks?

> Morever, at
> least one case (asynchronous system suspend/resume) cannot be handled
> in a single driver at all, because it requires the driver of A to
> wait for B to suspend (during system suspend) and the driver of B to
> wait for A to resume (during system resume).

Why is this all of a sudden a new issue? It seems there is quite a bit of
frameworks already out there that somehow deal with some sort of device
ordering / dependencies, and I am curious if they've been addressing some of
these problems for a while now on their own somehow with their own solutions,
is that the case? For instance can DAPM the / DRM / Audio component framework
v4l async solution be used or does it already address some of these concerns ?

> For this reason, represent dependencies between devices as "links",
> with the help of struct device_link objects each containing pointers
> to the "linked" devices, a list node for each of them, status
> information, flags, and an RCU head for synchronization.
> 
> Also add two new list heads, representing the lists of links to the
> devices that depend on the given one (consumers) and to the devices
> depended on by it (suppliers), and a "driver presence status" field
> (needed for figuring out initial states of device links) to struct
> device.
> 
> The entire data structure consisting of all of the lists of link
> objects for all devices is protected by a mutex (for link object
> addition/removal and for list walks during device driver probing
> and removal) and by SRCU (for list walking in other case that will
> be introduced by subsequent change sets).  In addition, each link
> object has an internal status field whose value reflects whether or
> not drivers are bound to the devices pointed to by the link or
> probing/removal of their drivers is in progress etc.  That field
> is only modified under the device links mutex, but it may be read
> outside of it in some cases (introduced by subsequent change sets),
> so modifications of it are annotated with WRITE_ONCE().
> 
> New links are added by calling device_link_add() which takes three
> arguments: pointers to the devices in question and flags.  In
> particular, if DL_FLAG_STATELESS is set in the flags, the link status
> is not to be taken into account for this link and the driver core
> will not manage it.  In turn, if DL_FLAG_AUTOREMOVE is set in the
> flags, the driver core will remove the link automatically when the
> consumer device driver unbinds from it.
> 
> One of the actions carried out by device_link_add() is to reorder
> the lists used for device shutdown and system suspend/resume to
> put the consumer device along with all of its children and all of
> its consumers (and so on, recursively) to the ends of those lists
> in order to ensure the right ordering between all of the supplier
> and consumer devices.

There's no explanation as to why this order is ensured to be
correct, I think its important to document this. From our discussions
at Plumbers it seems the order is ensured due to the fact that order
was already implicitly provided through platform firmware (ACPI
enumeration is one), adjusting order on the dpm list is just shuffling
order between consumer / provider, but nothing else. In theory it
works because in the simple case this should suffice however I
remain unconvinced that if we have more users of this framework this
simple algorithm will suffice. Having a test driver or series of
test drivers that shows this would be good. As it stands there is simply
an assumption that this is correct, how *strongly* do you feel that
the order will *always* be correct if this is done and no cycles
can be added, even if tons of drivers start using this ?

> For this reason, it is not possible to create a link between two
> devices if the would-be supplier device already depends on the
> would-be consumer device as either a direct descendant of it or a
> consumer of one of its direct descendants or one of its consumers
> and so on.
> 
> There are two types of link objects, persistent and non-persistent.
> The persistent ones stay around until one of the target devices is
> deleted, while the non-persistent ones are removed automatically when
> the consumer driver unbinds from its device (ie. they are assumed to
> be valid only as long as the consumer device has a driver bound to
> it).  Persistent links are created by default and non-persistent
> links are created when the DL_FLAG_AUTOREMOVE flag is passed
> to device_link_add().
> 
> Both persistent and non-persistent device links can be deleted
> with an explicit call to device_link_del().
> 
> Links created without the DL_FLAG_STATELESS flag set are managed
> by the driver core using a simple state machine.  There are 5 states
> each link can be in: DORMANT (unused), AVAILABLE (the supplier driver
> is present and functional), CONSUMER_PROBE (the consumer driver is
> probing), ACTIVE (both supplier and consumer drivers are present and
> functional), and SUPPLIER_UNBIND (the supplier driver is unbinding).
> The driver core updates the link state automatically depending on
> what happens to the linked devices and for each link state specific
> actions are taken in addition to that.
> 
> For example, if the supplier driver unbinds from its device, the
> driver core will also unbind the drivers of all of its consumers
> automatically under the assumption that they cannot function
> properly without the supplier.  Analogously, the driver core will
> only allow the consumer driver to bind to its device if the
> supplier driver is present and functional (ie. the link is in
> the AVAILABLE state).  If that's not the case, it will rely on
> the existing deferred probing mechanism to wait for the supplier
> driver to become available.

This assumes drivers and subsystems support deferred probe, is
there a way to ensure that drivers that use this framework support
it instead of possibly breaking them if they use this framework ?

  Luis
