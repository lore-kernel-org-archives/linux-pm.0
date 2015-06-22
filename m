From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] mfd: da9150: Add support for Fuel-Gauge
Date: Mon, 22 Jun 2015 12:16:24 +0100
Message-ID: <20150622111624.GF19061@x1>
References: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
 <8d8f583fee9313f261efa96a038874e552995c17.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
 <1434732461.2385.162.camel@x220>
 <2E89032DDAA8B9408CB92943514A0337AB555F28@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB555F28-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Jun 2015, Opensource [Adam Thomson] wrote:

> On June 19, 2015 17:48, Paul Bolle wrote:
>=20
> > On Thu, 2015-06-18 at 17:06 +0100, Adam Thomson wrote:
> > > --- /dev/null
> > > +++ b/include/linux/mfd/da9150/fg.h
> >=20
> > > +/*
> > > + * Function template to provide battery temperature. Should prov=
ide
> > > + * 0.1 degrees C resolution return values.
> > > + */
> > > +typedef int (*da9150_read_temp_t)(void *context);
> > > +
> > > +/* Register temp callback function */
> > > +void da9150_fg_register_temp_cb(struct power_supply *psy,
> > da9150_read_temp_t cb,
> > > +				void *cb_context);
> >=20
> > The pedant in me noticed that this function is actually added in 3/=
4. So
> > this chunk might be moved to 3/4, if you like to entertain pedantry=
 like
> > that, that is. (But see my remark on 3/4 too.)
>=20
> This is true, but as the header is part of MFD, I included it as part=
 of that
> patch as I thought this made more sense. I guess Lee will comment as =
to whether
> that was correct or not. :)

Glanced over this (as I still have 240 unread emails to attend to).
If the question is whether to submit the prototype at the same time as
the associated function, the answer is yes.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
