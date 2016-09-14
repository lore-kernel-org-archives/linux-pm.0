From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 2/7] driver core: Functional dependencies tracking support
Date: Wed, 14 Sep 2016 15:17:17 +0200
Message-ID: <1864613.C7h8kekz9R@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <2250917.Aes4ApWfhc@vostro.rjw.lan> <20160914082824.GA1597@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160914082824.GA1597@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 14, 2016 10:28:24 AM Lukas Wunner wrote:
> On Wed, Sep 14, 2016 at 03:21:27AM +0200, Rafael J. Wysocki wrote:
> > On Sunday, September 11, 2016 10:43:36 PM Lukas Wunner wrote:
> > > On Sun, Sep 11, 2016 at 03:40:58PM +0200, Lukas Wunner wrote:
> > > > On Thu, Sep 08, 2016 at 11:27:45PM +0200, Rafael J. Wysocki wrote:
> > > > > +/**
> > > > > + * device_is_dependent - Check if one device depends on another one
> > > > > + * @dev: Device to check dependencies for.
> > > > > + * @target: Device to check against.
> > > > > + *
> > > > > + * Check if @dev or any device dependent on it (its child or its consumer etc)
> > > > > + * depends on @target.  Return 1 if that is the case or 0 otherwise.
> > > > > + */
> > > > > +static int device_is_dependent(struct device *dev, void *target)
> > > > > +{
> > > > > +	struct device_link *link;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = device_for_each_child(dev, target, device_is_dependent);
> > > > > +	list_for_each_entry(link, &dev->links_to_consumers, s_node) {
> > > > > +		if (WARN_ON(link->consumer == target))
> > > > > +			return 1;
> > > > > +
> > > > > +		ret = ret || device_is_dependent(link->consumer, target);
> > > > > +	}
> > > > > +	return ret;
> > > > > +}
> > > > 
> > > > What happens if someone tries to add a device link from a parent
> > > > (as the consumer) to a child (as a supplier)?  You're only checking
> > > > if target is a consumer of dev, for full correctness you'd also have
> > > > to check if target is a parent of dev.  (Or grandparent, or great-
> > > > grandparent, ... you need to walk the tree up to the root.)
> > > > 
> > > > 
> > > > The function can be sped up by returning immediately if a match
> > > > is found instead of continuing searching and accumulating the
> > > > result in ret, i.e.:
> > > > 
> > > > 	if (device_for_each_child(dev, target, device_is_dependent))
> > > > 		return 1;
> > > > 
> > > > and in the list_for_each_entry block:
> > > > 
> > > > 	if (device_is_dependent(link->consumer, target))
> > > > 		return 1;
> > > > 
> > > > Then at the end of the function "return 0".
> > > > 
> > > > 
> > > > I'd move the WARN_ON() to the single invocation of this function in
> > > > device_link_add(), that way it's possible to use the function as a
> > > > helper elsewhere should the need arise.
> > > 
> > > Oh I'm grasping only now, you want to emit a WARN for *every*
> > > infringing child/consumer. That could lead to a WARN flood if
> > > a developer accidentally does something really dumb, like linking
> > > the PCI root to some PCI endpoint device, but fair enough.
> > > 
> > > The point about linking a parent to a child still stands however.
> > > I think a simple way to check this is to just add
> > > 
> > > 	if (WARN_ON(dev == target))
> > > 		return 1;
> > > 
> > > at the top of the function, because when someone tries to link
> > > a parent to a child, when recursing from the parent downward
> > > one will eventually hit that child. This will also prevent
> > > someone from linking a device to itself.
> > 
> > I actually would prefer to make it impossible to link a parent to
> > a child at all.
> 
> Which is precisely what the code snippet above does.

All right, this means I shouldn't reply to email late in the night.  But
at least we seem to be in agreement here.

Thanks,
Rafael
