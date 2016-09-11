From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 2/7] driver core: Functional dependencies
 tracking support
Date: Sun, 11 Sep 2016 22:43:36 +0200
Message-ID: <20160911204336.GA371@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <2169291.li0uc2Ryoq@vostro.rjw.lan>
 <20160911134058.GA189@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:50685 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753693AbcIKUnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2016 16:43:24 -0400
Content-Disposition: inline
In-Reply-To: <20160911134058.GA189@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Sun, Sep 11, 2016 at 03:40:58PM +0200, Lukas Wunner wrote:
> On Thu, Sep 08, 2016 at 11:27:45PM +0200, Rafael J. Wysocki wrote:
> > +/**
> > + * device_is_dependent - Check if one device depends on another one
> > + * @dev: Device to check dependencies for.
> > + * @target: Device to check against.
> > + *
> > + * Check if @dev or any device dependent on it (its child or its consumer etc)
> > + * depends on @target.  Return 1 if that is the case or 0 otherwise.
> > + */
> > +static int device_is_dependent(struct device *dev, void *target)
> > +{
> > +	struct device_link *link;
> > +	int ret;
> > +
> > +	ret = device_for_each_child(dev, target, device_is_dependent);
> > +	list_for_each_entry(link, &dev->links_to_consumers, s_node) {
> > +		if (WARN_ON(link->consumer == target))
> > +			return 1;
> > +
> > +		ret = ret || device_is_dependent(link->consumer, target);
> > +	}
> > +	return ret;
> > +}
> 
> What happens if someone tries to add a device link from a parent
> (as the consumer) to a child (as a supplier)?  You're only checking
> if target is a consumer of dev, for full correctness you'd also have
> to check if target is a parent of dev.  (Or grandparent, or great-
> grandparent, ... you need to walk the tree up to the root.)
> 
> 
> The function can be sped up by returning immediately if a match
> is found instead of continuing searching and accumulating the
> result in ret, i.e.:
> 
> 	if (device_for_each_child(dev, target, device_is_dependent))
> 		return 1;
> 
> and in the list_for_each_entry block:
> 
> 	if (device_is_dependent(link->consumer, target))
> 		return 1;
> 
> Then at the end of the function "return 0".
> 
> 
> I'd move the WARN_ON() to the single invocation of this function in
> device_link_add(), that way it's possible to use the function as a
> helper elsewhere should the need arise.

Oh I'm grasping only now, you want to emit a WARN for *every*
infringing child/consumer. That could lead to a WARN flood if
a developer accidentally does something really dumb, like linking
the PCI root to some PCI endpoint device, but fair enough.

The point about linking a parent to a child still stands however.
I think a simple way to check this is to just add

	if (WARN_ON(dev == target))
		return 1;

at the top of the function, because when someone tries to link
a parent to a child, when recursing from the parent downward
one will eventually hit that child. This will also prevent
someone from linking a device to itself.

Best regards,

Lukas
