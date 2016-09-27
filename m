From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][RFC/RFT][PATCH v3 2/5] driver core: Functional
 dependencies tracking support
Date: Tue, 27 Sep 2016 13:52:48 +0200
Message-ID: <CAJZ5v0h99yO8R28BkW-v3NZdc1GxupYx-4yeedduqpLfsxW01Q@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <5257325.y9rG1UM74b@vostro.rjw.lan>
 <2480829.3iNV7K5Pdo@vostro.rjw.lan> <2141382.sMORCbDyAF@vostro.rjw.lan> <20160927085413.GA5744@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33769 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933499AbcI0Lwv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 07:52:51 -0400
In-Reply-To: <20160927085413.GA5744@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Tue, Sep 27, 2016 at 10:54 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Fri, Sep 16, 2016 at 02:33:55PM +0200, Rafael J. Wysocki wrote:
>> +void device_links_unbind_consumers(struct device *dev)
>> +{
>> +     struct device_link *link;
>> +     int idx;
>> +
>> + start:
>> +     idx = device_links_read_lock();
>> +
>> +     list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
>> +             enum device_link_status status;
>> +
>> +             if (link->flags & DEVICE_LINK_STATELESS)
>> +                     continue;
>> +
>> +             spin_lock(&link->lock);
>> +             status = link->status;
>> +             if (status == DEVICE_LINK_CONSUMER_PROBE) {
>> +                     spin_unlock(&link->lock);
>> +
>> +                     device_links_read_unlock(idx);
>> +
>> +                     wait_for_device_probe();
>> +                     goto start;
>> +             }
>
> While revisiting this function it just occurred to me that there's
> a theoretical infinite loop here if the consumer probes, is unbound
> by the supplier, then reprobes again before the supplier had a chance
> to update the link to DEVICE_LINK_SUPPLIER_UNBIND.  Perhaps this isn't
> a problem in practice, but noting anyway.

But the consumer is unbound only after setting the link status to
DEVICE_LINK_SUPPLIER_UNBIND and then it won't probe again.

Or am I overlooking something?

Thanks,
Rafael
