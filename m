From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 4/5] PM / runtime: Use device links
Date: Mon, 19 Dec 2016 13:38:50 +0100
Message-ID: <CAJZ5v0gQ5zSkJ9nkqnCsUXy5VSPt7+Po19wkukVJpuw8fA2pNw@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <11468990.WB1J8sxXpS@vostro.rjw.lan>
 <5653461.FkScaTIbLn@vostro.rjw.lan> <20161218140122.GA13141@wunner.de>
 <CAJZ5v0gacPK2BOjZ_=tPbSnRjWjW5BrZQDUnKzD3i0qVcN5nLw@mail.gmail.com> <20161218163725.GA13273@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35675 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcLSMiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 07:38:51 -0500
In-Reply-To: <20161218163725.GA13273@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Sun, Dec 18, 2016 at 5:37 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Sun, Dec 18, 2016 at 04:53:26PM +0100, Rafael J. Wysocki wrote:
>> On Sun, Dec 18, 2016 at 3:01 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > Hi Rafael,
>> >
>> > spotted what looks like a bug in the device links runtime PM code:
>> >
>> > When resuming a device, __rpm_callback() calls rpm_get_suppliers(dev):
>> >
>> >> +                     retval = rpm_get_suppliers(dev);
>> >> +                     if (retval)
>> >> +                             goto fail;
>> >
>> >
>> > This will walk the list of suppliers and call pm_runtime_get_sync()
>> > for each of them:
>> >
>> >> +static int rpm_get_suppliers(struct device *dev)
>> >> +{
>> >> +     struct device_link *link;
>> >> +
>> >> +     list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
>> >> +             int retval;
>> > [...]
>> >> +             retval = pm_runtime_get_sync(link->supplier);
>> >> +             if (retval < 0) {
>> >> +                     pm_runtime_put_noidle(link->supplier);
>> >> +                     return retval;
>> >
>> >
>> > If pm_runtime_get_sync() failed, e.g. because runtime PM is disabled
>> > on a supplier, the function will put the reference of the failed
>> > supplier and return.
>> >
>> > Back in __rpm_callback() we jump to the fail mark, where we call
>> > rpm_put_suppliers().
>> >
>> >> + fail:
>> >> +                     rpm_put_suppliers(dev);
>> >> +
>> >> +                     device_links_read_unlock(idx);
>> >
>> >
>> > This walks the list of suppliers and releases a ref for each of them:
>> >
>> >> +static void rpm_put_suppliers(struct device *dev)
>> >> +{
>> >> +     struct device_link *link;
>> >> +
>> >> +     list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
>> >> +             if (link->rpm_active &&
>> >> +                 READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
>> >> +                     pm_runtime_put(link->supplier);
>> >> +                     link->rpm_active = false;
>> >> +             }
>> >> +}
>> >
>> >
>> > This looks wrong:  We've already put a ref on the failed supplier, so here
>> > we're putting another one.
>>
>> Are we?  I would think link->rpm_active would be false for the failed
>> one, wouldn't it?
>
> Ah, so link->rpm_active means the consumer is holding a ref on the supplier.

Yes, that's the idea. :-)

> Missed that, sorry for the false alarm and thanks for the clarification.

No problem.

Thanks,
Rafael
