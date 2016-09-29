From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [Update][RFC/RFT][PATCH v3 2/5] driver core: Functional
 dependencies tracking support
Date: Thu, 29 Sep 2016 12:36:03 +0200
Message-ID: <20160929103603.GA6550@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <5257325.y9rG1UM74b@vostro.rjw.lan>
 <2480829.3iNV7K5Pdo@vostro.rjw.lan>
 <2141382.sMORCbDyAF@vostro.rjw.lan>
 <20160927085413.GA5744@wunner.de>
 <CAJZ5v0h99yO8R28BkW-v3NZdc1GxupYx-4yeedduqpLfsxW01Q@mail.gmail.com>
 <20160928104318.GA6064@wunner.de>
 <CAJZ5v0gwJq=s5pJqOx-_J5+6s8HZ3nr9aHFQF59P63BEcsR-gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:36655 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbcI2KfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 06:35:25 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwJq=s5pJqOx-_J5+6s8HZ3nr9aHFQF59P63BEcsR-gg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Wed, Sep 28, 2016 at 01:31:36PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 28, 2016 at 12:43 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Tue, Sep 27, 2016 at 01:52:48PM +0200, Rafael J. Wysocki wrote:
> >> On Tue, Sep 27, 2016 at 10:54 AM, Lukas Wunner <lukas@wunner.de> wrote:
> >> > On Fri, Sep 16, 2016 at 02:33:55PM +0200, Rafael J. Wysocki wrote:
> >> >> +void device_links_unbind_consumers(struct device *dev)
> >> >> +{
> >> >> +     struct device_link *link;
> >> >> +     int idx;
> >> >> +
> >> >> + start:
> >> >> +     idx = device_links_read_lock();
> >> >> +
> >> >> +     list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
> >> >> +             enum device_link_status status;
> >> >> +
> >> >> +             if (link->flags & DEVICE_LINK_STATELESS)
> >> >> +                     continue;
> >> >> +
> >> >> +             spin_lock(&link->lock);
> >> >> +             status = link->status;
> >> >> +             if (status == DEVICE_LINK_CONSUMER_PROBE) {
> >> >> +                     spin_unlock(&link->lock);
> >> >> +
> >> >> +                     device_links_read_unlock(idx);
> >> >> +
> >> >> +                     wait_for_device_probe();
> >> >> +                     goto start;
> >> >> +             }
> >> >> +             link->status = DEVICE_LINK_SUPPLIER_UNBIND;
> >> >
> >> > While revisiting this function it just occurred to me that there's
> >> > a theoretical infinite loop here if the consumer probes, is unbound
> >> > by the supplier, then reprobes again before the supplier had a chance
> >> > to update the link to DEVICE_LINK_SUPPLIER_UNBIND.  Perhaps this isn't
> >> > a problem in practice, but noting anyway.
> >>
> >> But the consumer is unbound only after setting the link status to
> >> DEVICE_LINK_SUPPLIER_UNBIND and then it won't probe again.
> >
> > Sorry, looking at the code with a fresh pair of eyeballs I realize the
> > scenario for the infinite loop is different from what I've written above:
> > The infinite loop can occur if the consumer probes continuously but never
> > succeeds, e.g. due to some unfulfilled condition in its ->probe hook.
> 
> I'm not sure how that can happen.
> 
> If it doesn't succeed, the driver's ->probe() will return an error, so
> that driver is not going to be tried again, unless the error is
> -EPROBE_DEFER, but that will cause it to wait for another driver to
> probe successfully in the meantime.

You're right, it seems that the code is safe.  Sorry for the noise. :)

Best regards,

Lukas
