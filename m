From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 4/8] usb: core: add power sequence handling for USB
 devices
Date: Tue, 23 Aug 2016 11:10:21 +0800
Message-ID: <20160823031021.GB13986@shlinux2>
References: <20160822065335.GC4362@shlinux2>
 <Pine.LNX.4.44L0.1608221156210.1543-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1608221156210.1543-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 22, 2016 at 12:09:54PM -0400, Alan Stern wrote:
> > > +
> > > +static int hub_of_pwrseq_on(struct device_node *np, struct usb_hub *hub)
> > > +{
> > > +	struct pwrseq *pwrseq;
> > > +	struct usb_pwrseq_node *pwrseq_node;
> > > +	int ret;
> > > +
> > > +	pwrseq = pwrseq_alloc_generic();
> > > +	if (IS_ERR(pwrseq))
> > > +		return PTR_ERR(pwrseq);
> > > +
> > > +	ret = pwrseq_get(np, pwrseq);
> > > +	if (ret)
> > > +		goto pwr_free;
> > > +
> > > +	ret = pwrseq_on(np, pwrseq);
> > > +	if (ret)
> > > +		goto pwr_put;
> > > +
> > > +	pwrseq_node = kzalloc(sizeof(*pwrseq_node), GFP_KERNEL);
> 
> You need to check that the kzalloc succeeded.

Ok.

> 
> > > +	pwrseq_node->pwrseq = pwrseq;
> > > +	list_add(&pwrseq_node->list, &hub->pwrseq_on_list);
> > > +
> > > +	return 0;
> > > +
> > > +pwr_put:
> > > +	pwrseq_put(pwrseq);
> > > +pwr_free:
> > > +	pwrseq_free(pwrseq);
> > > +	return ret;
> > > +}
> 
> This subroutine looks very generic.  The only place where it cares that
> it was called for a USB hub is the list_add(), and that could easily
> become generic also (make this function take &hub->pwrseq_on_list as
> its second argument, instead of hub).
> 
> It looks like this routine really belongs in the power sequence 
> library.
> 

I will export below two generic functions at pwrseq library:

int generic_pwrseq_on(struct device_node *np, struct list_head *head)
void generic_pwrseq_off(struct list_head *head)

delete this file, and call above APIs at hub.c.

> > > +
> > > +int hub_pwrseq_on(struct usb_hub *hub)
> > > +{
> 
> The names of this routine and the subroutine above are too similar.  
> After all, both functions require OF support.
> 

I will add #ifdef CONFIG_OF for related code. And put the content at
hub_pwrseq_on at hub_probe directly, how about below?

hub_probe() {

	...

	if (hub_configure(hub, endpoint) >= 0) {
#ifdef CONFIG_OF
		for_each_child_of_node(parent->of_node, np) {
			ret = generic_pwrseq_on(np, hub);
			if (ret)
				return ret;
		}
#else
		return 0;
#endif
	}

	hub_disconnect(intf);
	return ret;
}

-- 

Best Regards,
Peter Chen
