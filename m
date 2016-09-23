From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [Update][RFC/RFT][PATCH v3 2/5] driver core: Functional
 dependencies tracking support
Date: Fri, 23 Sep 2016 15:03:15 +0200
Message-ID: <20160923130315.GA4077@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <5257325.y9rG1UM74b@vostro.rjw.lan>
 <2480829.3iNV7K5Pdo@vostro.rjw.lan>
 <2141382.sMORCbDyAF@vostro.rjw.lan>
 <20160919224630.GA2933@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:55373 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757964AbcIWNCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 09:02:47 -0400
Content-Disposition: inline
In-Reply-To: <20160919224630.GA2933@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Tue, Sep 20, 2016 at 12:46:30AM +0200, Lukas Wunner wrote:
> On Fri, Sep 16, 2016 at 02:33:55PM +0200, Rafael J. Wysocki wrote:
> > +void device_links_unbind_consumers(struct device *dev)
> > +{
> > +	struct device_link *link;
> > +	int idx;
> > +
> > + start:
> > +	idx = device_links_read_lock();
> > +
> > +	list_for_each_entry_rcu(link, &dev->links_to_consumers, s_node) {
> > +		enum device_link_status status;
> > +
> > +		if (link->flags & DEVICE_LINK_STATELESS)
> > +			continue;
> > +
> > +		spin_lock(&link->lock);
> > +		status = link->status;
> > +		if (status == DEVICE_LINK_CONSUMER_PROBE) {
> > +			spin_unlock(&link->lock);
> > +
> > +			device_links_read_unlock(idx);
> > +
> > +			wait_for_device_probe();
> > +			goto start;
> > +		}
> > +		link->status = DEVICE_LINK_SUPPLIER_UNBIND;
> > +		if (status == DEVICE_LINK_ACTIVE) {
> > +			struct device *consumer = link->consumer;
> > +
> > +			get_device(consumer);
> 
> As long as the struct device_link exists, a ref is held on the
> supplier and consumer.  Why acquire another ref here?

I'm withdrawing this particular comment as I failed to see that
device_links_read_unlock() is called next, so nothing prevents
the device link from being deleted, same for the consumer, thus
the ref needs to be acquired for device_release_driver_internal()
and this portion of Rafael's code seems perfectly correct.

Thanks & sorry for the noise,

Lukas
