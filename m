From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][RFC/RFT][PATCH v3 2/5] driver core: Functional
 dependencies tracking support
Date: Tue, 27 Sep 2016 14:16:15 +0200
Message-ID: <CAJZ5v0j59XEMhJte_-A-T6sLWru4S6eqvE29_Sn7xbpFDpDPKA@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <2141382.sMORCbDyAF@vostro.rjw.lan>
 <20160919224630.GA2933@wunner.de> <2576815.LnbrnvuK3u@vostro.rjw.lan> <20160926165121.GA5353@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36354 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbcI0MQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 08:16:17 -0400
In-Reply-To: <20160926165121.GA5353@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Mon, Sep 26, 2016 at 6:51 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Fri, Sep 23, 2016 at 03:42:31PM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, September 20, 2016 12:46:30 AM Lukas Wunner wrote:
>> > On Fri, Sep 16, 2016 at 02:33:55PM +0200, Rafael J. Wysocki wrote:
>> > > +void device_links_no_driver(struct device *dev)
>> > > +{
>> > > + struct device_link *link, *ln;
>> > > +
>> > > + mutex_lock(&device_links_lock);
>> > > +
>> > > + list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
>> > > +         if (link->flags & DEVICE_LINK_STATELESS)
>> > > +                 continue;
>> > > +
>> > > +         if (link->flags & DEVICE_LINK_AUTOREMOVE) {
>> > > +                 __device_link_del(link);
>> >
>> > The link will be autoremoved not only when the consumer unbinds,
>> > but also when probing the consumer fails.
>> >
>> > Looks like a bug.
>>
>> It really was intentional, because the use case I see for AUTOREMOVE (and
>> the only one to be honest) is when the link is created by the consumer
>> probe in which case it wants to avoid worrying about the cleanup part.
>>
>> Which also is applicable to the cleanup when the probe fails IMO.
>
> You're right, makes sense.
>
>
>> > > +void device_links_unbind_consumers(struct device *dev)
>> > > +{
>> > > + struct device_link *link;
>> > > + int idx;
>> > > +
>> > > + start:
>> > > + idx = device_links_read_lock();
>> > > +
>> > > + list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
>> > > +         enum device_link_status status;
>> > > +
>> > > +         if (link->flags & DEVICE_LINK_STATELESS)
>> > > +                 continue;
>> > > +
>> > > +         spin_lock(&link->lock);
>> > > +         status = link->status;
>> > > +         if (status == DEVICE_LINK_CONSUMER_PROBE) {
>> > > +                 spin_unlock(&link->lock);
>> > > +
>> > > +                 device_links_read_unlock(idx);
>> > > +
>> > > +                 wait_for_device_probe();
>> > > +                 goto start;
>> > > +         }
>> > > +         link->status = DEVICE_LINK_SUPPLIER_UNBIND;
>> > > +         if (status == DEVICE_LINK_ACTIVE) {
>> > > +                 struct device *consumer = link->consumer;
>> > > +
>> > > +                 get_device(consumer);
>> > > +                 spin_unlock(&link->lock);
>> >
>> > The lock is released both at the beginning of this if-block and
>> > immediately after the if-block (in case the if-condition is false).
>> > Why not simply release the lock *before* the if-block?
>>
>> Because the get_device() needs to be done under the lock.
>
> According to the commit message, the spinlock only protects the status
> field and the consumer device is prevented from disappearing with the RCU.
> So the spin lock could be released before the if-block AFAICS.
> (But perhaps there are style/readability reasons to have the unlock both
> in the if-block and afterwards.)

OK

Apparently, I was worrying about that the link might go away after the
device_links_read_unlock() in the if () block, so the object pointed
to by "consumer" had to be prevented from going away as well at that
point, but you are right that it's sufficient to call the get_device()
before the device_links_read_unlock() for that and it doesn't have to
go under the spinlock.

>> > > @@ -1233,6 +1680,7 @@ void device_del(struct device *dev)
>> > >  {
>> > >   struct device *parent = dev->parent;
>> > >   struct class_interface *class_intf;
>> > > + struct device_link *link, *ln;
>> > >
>> > >   /* Notify clients of device removal.  This call must come
>> > >    * before dpm_sysfs_remove().
>> > > @@ -1240,6 +1688,30 @@ void device_del(struct device *dev)
>> > >   if (dev->bus)
>> > >           blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> > >                                        BUS_NOTIFY_DEL_DEVICE, dev);
>> > > +
>> > > + /*
>> > > +  * Delete all of the remaining links from this device to any other
>> > > +  * devices (either consumers or suppliers).
>> > > +  *
>> > > +  * This requires that all links be dormant, so warn if that's no the
>> > > +  * case.
>> > > +  */
>> > > + mutex_lock(&device_links_lock);
>> > > +
>> > > + list_for_each_entry_safe_reverse(link, ln, &dev->links_to_suppliers, c_node) {
>> > > +         WARN_ON(link->status != DEVICE_LINK_DORMANT &&
>> > > +                 !(link->flags & DEVICE_LINK_STATELESS));
>> > > +         __device_link_del(link);
>> > > + }
>> >
>> > Shouldn't it also be legal for the supplier links to be in
>> > DEVICE_LINK_AVAILABLE state upon removal of a consumer device?
>> >
>> > (And perhaps also DEVICE_LINK_SUPPLIER_UNBIND?)
>> >
>> > Looks like a bug.
>>
>> But this is done after removing the supplier driver, so the state should be
>> DORMANT (unless the link is stateless), shouldn't it?
>
> The scenario I have in mind is that the supplier device is bound to a
> driver and the consumer device has no driver and is being removed.
> In that case the status will be DEVICE_LINK_AVAILABLE and the user
> will get a WARN splat, which seems gratuitous because it should be legal.
>
> And the other scenario is when the supplier is unbinding. It iterates
> over the links to consumers and puts them in DEVICE_LINK_SUPPLIER_UNBIND.
> Let's say the link to consumer A was put into that state, but there's
> a consumer B remaining which is bound.  The RCU and spinlock are unlocked
> before device_release_driver_internal() is called for that consumer.
> If at that point consumer device A is removed for whatever reason,
> the link will also be removed and the user will again get a gratuitous
> WARN splat.

Well, it all boils down to the observation that the consumer device
may be deleted when the supplier still has a driver or is unbinding,
which is a good point.

Thanks,
Rafael
