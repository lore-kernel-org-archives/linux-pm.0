From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Sat, 10 Sep 2016 13:39:16 +0200
Message-ID: <20160910113916.GA29698@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:45857 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbcIJLjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2016 07:39:05 -0400
Content-Disposition: inline
In-Reply-To: <27296716.H9VWo8ShOm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Thu, Sep 08, 2016 at 11:25:44PM +0200, Rafael J. Wysocki wrote:
> As discussed in the recent "On-demand device probing" thread and in a
> Kernel Summit session earlier today, there is a problem with handling
> cases where functional dependencies between devices are involved.
> 
> What I mean by a "functional dependency" is when the driver of device B
> needs both device A and its driver to be present and functional to be
> able to work.  This implies that the driver of A needs to be working
> for B to be probed successfully and it cannot be unbound from the
> device before the B's driver.  This also has certain consequences for
> power management of these devices (suspend/resume and runtime PM
> ordering).

As a general observation, this series seems to conflate two
separate issues:

(a) non-hierarchical device dependencies
    (a device depends on another device which is not its parent
    with regards to (runtime) suspend/resume ordering)

(b) driver-presence dependencies
    (a device depends on another device to be bound to a driver
    before it can probe / must be unbound before the other device
    can unbind)

Those two issues are orthogonal.

E.g. a driver-presence dependency may exist between a child and a
parent, or between siblings, whereas a non-hierarchical device
dependency by definition cannot exist between child/parent.

Let's say I need a driver-presence dependency between parent/child.
The PM core already guarantees correct (runtime) suspend/resume
ordering between child. Device links duplicate that functionality.
Oops?

In a way, the approach taken here is somewhat contrary to the UNIX
philosophy to write programs that do one thing and do that well.
It's a single tool which addresses two distinct problems and I think
that makes it more difficult to understand the consequences of
device links, in particular if used between parent/child, and ensure
correctness.

Would it be worth to address issue (b) driver-presence dependencies
with a separate tool? I could envision adding two bits to struct device,
one to indicate that the device must be bound before its children/
consumers can bind, and another to indicate that the parent/suppliers
must be bound before the device can bind. The PM core could check those
bits to decide if it should defer probing. All the code for maintaining
device link state would probably no longer be necessary.

That approach would be more coarse-grained than setting up links
between two devices, but I imagine it would probably suffice in the
majority of use cases. If drivers need something more fine-grained,
they can always test boundness of suppliers in their ->probe hook
and return -EPROBE_DEFER. And they could handle unbinding before
suppliers by listening to BUS_NOTIFY_UNBIND_DRIVER.

As for (a) non-hierarchical device dependencies, that's a gaping
hole that we currently have. Off the cuff I can name 4 such device
dependencies on MacBooks alone where we currently try to make do
with various kludges to ensure correct suspend/resume ordering.
Being able to express such dependencies in a generic way and have
the PM core take care of them would be a godsend.

As for (b) driver-presence dependencies, I only know of a single
use case: Apparently the BCM57785 Ethernet/SDHC controller needs
the Ethernet driver to be loaded for the SDHC reader to work
(https://bugzilla.kernel.org/show_bug.cgi?id=73241#c56). I imagine
some power well is needed for SDHC and is only turned on when the
Ethernet driver is loaded. The two bit solution proposed above
would suffice for this use case: The two devices are siblings
and have no children themselves. (They're functions 0 and 1 of
a PCI endpoint device.)

Thanks,

Lukas
