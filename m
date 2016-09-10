From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Sun, 11 Sep 2016 00:04:36 +0200
Message-ID: <CAJZ5v0hS1FtqmsaqT03sMyGW8==UxTo-uFZkzueF=pFPHWjOdA@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <20160910113916.GA29698@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160910113916.GA29698@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 10, 2016 at 1:39 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Sep 08, 2016 at 11:25:44PM +0200, Rafael J. Wysocki wrote:
>> As discussed in the recent "On-demand device probing" thread and in a
>> Kernel Summit session earlier today, there is a problem with handling
>> cases where functional dependencies between devices are involved.
>>
>> What I mean by a "functional dependency" is when the driver of device B
>> needs both device A and its driver to be present and functional to be
>> able to work.  This implies that the driver of A needs to be working
>> for B to be probed successfully and it cannot be unbound from the
>> device before the B's driver.  This also has certain consequences for
>> power management of these devices (suspend/resume and runtime PM
>> ordering).
>
> As a general observation, this series seems to conflate two
> separate issues:
>
> (a) non-hierarchical device dependencies
>     (a device depends on another device which is not its parent
>     with regards to (runtime) suspend/resume ordering)

You need to say what it means that one device depends on another one.
Without that you don't get anything useful.

> (b) driver-presence dependencies
>     (a device depends on another device to be bound to a driver
>     before it can probe / must be unbound before the other device
>     can unbind)
>
> Those two issues are orthogonal.

No, they aren't.

At least for a number of devices (quite likely it would be safe to say
that for the majority of them I think) the supplier can only provide
any useful service to its consumers when it has a driver bound to it
and running and the consumers cannot operate correctly without that
service.  That's why the "unbind consumers before unbinding the
supplier" logic is in there.

And in the context of this series a "dependency" boils down to the
ordering of execution of callbacks of certain type.  Like, for
example, "can I execute ->runtime_suspend() for device A before
executing it for device B?"  If there's a link between A and B where
the former is the supplier, the answer is "no".  The reason why is the
assumption that after ->runtime_suspend() A will stop responding and
will not be able to provide the service in question to B any more.

Likewise, if the driver of A goes away, this device will not be able
to provide the service in question to B any more, so it doesn't make
sense for the driver of B to still be running then.

This is the case I wanted to cover with this series if it was not clear before.

Of course, you don't like what device_links_unbind_consumers() does
because of your "Thunderbolt on Macs" use case, but guess what, you
can add a link flag to keep the consumer around when the supplier
driver goes away.  I just don't want that to be the default behavior.

> E.g. a driver-presence dependency may exist between a child and a
> parent, or between siblings, whereas a non-hierarchical device
> dependency by definition cannot exist between child/parent.
>
> Let's say I need a driver-presence dependency between parent/child.
> The PM core already guarantees correct (runtime) suspend/resume
> ordering between child. Device links duplicate that functionality.
> Oops?

No, they don't and that should be clear.

They are for out-of-the-tree dependencies only and the parent-child
one is *in* the tree.

Thanks,
Rafael
