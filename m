From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2 3/5] thermal: Add a driver for the
 Allwinner THS sensor
Date: Mon, 30 Nov 2015 20:58:23 +0100
Message-ID: <20151130195823.GE3664@lukather>
References: <20151124084342.GJ32142@lukather>
 <cover.1448263428.git.atx@atx.name>
 <ea5d8edefd251f2b76660b43a4ea4dc89c3b2f38.1448263428.git.atx@atx.name>
 <0edf1031924124377647dfb0f62ec6c8@rainloop.atalax.net>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBYOU6KZAKGQEVVYV2XQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0edf1031924124377647dfb0f62ec6c8-DwCxqXnXFIKSaDSPXN/tZNHuzzzSOjJt@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Nov 25, 2015 at 11:02:34AM +0000, Josef Gajdusek wrote:
> >> +struct sun8i_ths_type {
> >> + int (*init)(struct platform_device *, struct sun8i_ths_data *);
> >> + int (*get_temp)(struct sun8i_ths_data *, int *out);
> >> + void (*irq)(struct sun8i_ths_data *);
> >> + void (*deinit)(struct sun8i_ths_data *);
> >> +};
> > 
> > AFAIK, you never got back on why it was actually needed, instead of
> > directly calling these functions.
> 
> It is preparation for supporting the other SoCs with THS as they have
> slightly different register layouts and thus cannot be controlled by the
> same code.

Do you have support and / or informations on what's going to be needed
for these other SoCs yet?

Which SoCs are we talking about?

> >> + /* The final sample period is calculated as follows:
> >> + * (THERMAL_PER + 1) * 4096 / f_clk * 2^(FILTER_TYPE + 1)
> >> + *
> >> + * This results to about 1Hz with these settings.
> >> + */
> >> + ret = clk_set_rate(data->clk, 4000000);
> > 
> > I don't follow you here. You have a complicated math function, that
> > has many input variables, and then, you just set the clock rate to a
> > constant?
> 
> How should this be handled then? I guess the sampling rate could
> be set in the device tree and then the values calculated, but none
> of the other thermal drivers seem to have configurable sample rate.

I don't know, I would have expected some actual computation, like a
function taking the frequency as a parameter and returning the clock
rate. At least that way we now what we're doing and which part might
change and which will not.

But you do not need to change the sample rate itself.

> >> +static int sun8i_ths_h3_get_temp(struct sun8i_ths_data *data, int *out)
> >> +{
> >> + int val = readl(data->regs + THS_H3_DATA);
> >> + *out = sun8i_ths_reg_to_temperature(val, 8253, 217000);
> >> + return 0;
> > 
> > Can't you just return the value directly?
> 
> I did that in the v1, clabbe.montjoie suggested to use temp variable to
> avoid column wrap.

I was talking about the out pointer. Can the value not be returned?

> >> + ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> >> + sun8i_ths_irq_thread, IRQF_ONESHOT,
> >> + dev_name(&pdev->dev), data);
> > 
> > Why a threaded irq?
> 
> I thought threaded IRQs are preferred? Other thermal drivers
> use them too.

It's close to pointless in this case. You're not doing much more than
what the default handler will do anyway, and you avoid scheduling a
thread doing so.

And other thermal drivers use a regular interrupt handler too :)

> I am also not really sure thermal_zone_device_update() can even be
> called in interrupt context.

I can't really tell on this one. Judging from a quick look, I can't
see anything that could prevent it, and since others are using it, it
seems doable.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--KlAEzMkarCnErv5Q--
