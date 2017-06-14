From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v15 2/7] power: add power sequence library
Date: Wed, 14 Jun 2017 09:53:39 +0800
Message-ID: <20170614015338.GA4635@b29397-desktop>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
 <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, frank.li-3arQi8VN3Tc@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Maciej S. Szmigiero" <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 13, 2017 at 12:24:42PM +0200, Ulf Hansson wrote:
> [...]
> 
> > +
> > +/**
> > + * of_pwrseq_on - Carry out power sequence on for device node
> > + *
> > + * @np: the device node would like to power on
> > + *
> > + * Carry out a single device power on.  If multiple devices
> > + * need to be handled, use of_pwrseq_on_list() instead.
> > + *
> > + * Return a pointer to the power sequence instance on success,
> > + * or an error code otherwise.
> > + */
> > +struct pwrseq *of_pwrseq_on(struct device_node *np)
> > +{
> > +       struct pwrseq *pwrseq;
> > +       int ret;
> > +
> > +       pwrseq = pwrseq_find_available_instance(np);
> > +       if (!pwrseq)
> > +               return ERR_PTR(-ENOENT);
> 
> In case the pwrseq instance hasn't been registered yet, then there is
> no way to deal with -EPROBE_DEFER properly here.
> 
> I haven't been following the discussions in-depth during all
> iterations, so perhaps you have already discussed why doing it like
> this.

Yes, it has been discussed. In order to compare with compatible string
at dts, we need to have one registered pwrseq instance for each
pwrseq library, this pre-registered one is allocated using
postcore_initcall, and the new (eg, second) instance is registered
after pwrseq_get has succeeded.

Peter

> 
> Anyway, that means all pwrseq instances needs to be registered an
> early boot level, to be safe. To me, that seems like poor design
> choice.
> 
> Otherwise I think this looks okay to me.
> 

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
