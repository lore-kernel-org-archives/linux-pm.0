From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 2/8] reset: Add reset controller API
Date: Mon, 04 Mar 2013 09:33:27 +0100
Message-ID: <1362386007.4988.34.camel@pizza.hi.pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
	 <1361878774-6382-3-git-send-email-p.zabel@pengutronix.de>
	 <513108F8.30902@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33708 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab3CDIeB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 03:34:01 -0500
In-Reply-To: <513108F8.30902@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

Hi Stephen,

Am Freitag, den 01.03.2013, 13:00 -0700 schrieb Stephen Warren:
> On 02/26/2013 04:39 AM, Philipp Zabel wrote:
> > This adds a simple API for devices to request being reset
> > by separate reset controller hardware and implements the
> > reset signal device tree binding.
> 
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> 
> > +int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
> > +			  const struct of_phandle_args *reset_spec, u32 *flags)
> > +{
> > +	if (WARN_ON(reset_spec->args_count < rcdev->of_reset_n_cells))
> > +		return -EINVAL;
> 
> Would != make more sense than < ?

I copied this from of_gpio_simple_xlate, because the parsing will work
if args_count > of_reset_n_cells. In this case the device tree contains
a #reset-cells larger than what the reset controller driver expects.
Is this reason enough to assume the whole reset_spec is invalid?

> > +
> > +	if (reset_spec->args[0] >= rcdev->nr_resets)
> > +		return -EINVAL;
> > +
> > +	if (flags)
> > +		*flags = reset_spec->args[1];
> 
> if (flags)
>     if (reset_spec->args_count > 1)
>         *flags = reset_spec->args[1];
>     else
>         *flags = 0;
> 
> ?

In gpiolib, of_get_named_gpio_flags clears the flags, so that the xlate
implementations don't have to do it. The core doesn't use the flags, so
this is not a problem. I don't see the need for
of_get_named_reset_flags, since the reset consumer drivers shouldn't
care for those. Maybe it would be better to remove the flags parameter
from the xlate function altogether.

> > +struct reset_control *reset_control_get(struct device *dev, const char *id)
> ...
> > +	mutex_lock(&reset_controller_list_mutex);
> > +	rcdev = NULL;
> > +	list_for_each_entry(r, &reset_controller_list, list) {
> > +		if (args.np == r->of_node) {
> > +			rcdev = r;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&reset_controller_list_mutex);
> 
> At this point, rcdev could be removed from that list, and perhaps even
> start to point at free'd memory.

I'll move the unlock down.

> > +	of_node_put(args.np);
> > +
> > +	if (!rcdev)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	rstc_id = rcdev->of_xlate(rcdev, &args, NULL);
> > +	if (rstc_id < 0)
> > +		return ERR_PTR(rstc_id);
> > +
> > +	try_module_get(rcdev->owner);
> 
> What about error-handling here?
>
> I think you want to drop reset_controller_list_mutex only after the call
> to try_module_get()?

I will.

> > +static int devm_reset_control_match(struct device *dev, void *res, void *data)
> > +{
> > +	struct reset_control **rstc = res;
> > +	if (!rstc || !*rstc) {
> > +		WARN_ON(!rstc || !*rstc);
> 
> I think you can if (WARN_ON(...)).

Yes.

> I'm not sure if the error-checks are quite right though;
> reset_control_get always returns an error-pointer for errors, never
> NULL, so the pointer can't ever be NULL. If it somehow was (e.g. client
> usage error), then that NULL pointer would never match anything, so the
> error-check still wouldn't be useful.

The void *res parameter of dr_match_t is given the data field of struct
devres (dr->data) when called by devres_release. A few subsystems do the
same check, so I figured there could be other devres managed resources
that could have dr->data == NULL. Looking at devres.c again, this
doesn't really seem to be the case. I'll drop it.

> I'm not sure why this is a ** here; below in devm_reset_control_put()
> you pass a just a *; are you expected to pass &rstc there instead?

dr->data is filled in and returned by devres_alloc in
devm_reset_control_get and contains a struct reset_control **ptr.
So that should be right, but ...

reset_control_get right now always allocates a new struct reset_control,
instead of keeping them around in a list and just returning a new
reference for already existing reset_controls, which kind of defeats the
purpose of the above. The idea was that drivers sharing a reset line
should also use the same struct reset_control.

thanks
Philipp

