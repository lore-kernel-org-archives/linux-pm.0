From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/6] power: add power sequence library
Date: Thu, 4 Aug 2016 14:04:57 +0800
Message-ID: <20160804060457.GA27272@shlinux2>
References: <1470108652-16812-1-git-send-email-peter.chen@nxp.com>
 <1470108652-16812-3-git-send-email-peter.chen@nxp.com>
 <20160803221658.GD1405@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160803221658.GD1405-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 03, 2016 at 03:16:58PM -0700, Matthias Kaehlcke wrote:
> El Tue, Aug 02, 2016 at 11:30:48AM +0800 Peter Chen ha dit:
> 
> > diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
> >
> > ...
> >
> > +static DEFINE_MUTEX(pwrseq_list_mutex);
> > +static LIST_HEAD(pwrseq_list);
> > +
> > +int pwrseq_get(struct device_node *np, struct pwrseq *p)
> > +{
> > +	if (p && p->get)
> > +		return p->get(np, p);
> > +
> > +	return -ENOTSUPP;
> > +}
> > +
> > +int pwrseq_on(struct device_node *np, struct pwrseq *p)
> > +{
> > +	if (p && p->on)
> > +		return p->on(np, p);
> > +
> > +	return -ENOTSUPP;
> > +}
> > +
> > +void pwrseq_off(struct pwrseq *p)
> > +{
> > +	if (p && p->off)
> > +		p->off(p);
> > +}
> > +
> > +void pwrseq_put(struct pwrseq *p)
> > +{
> > +	if (p && p->put)
> > +		p->put(p);
> > +}
> > +
> > +void pwrseq_free(struct pwrseq *p)
> > +{
> > +	if (p && p->free)
> > +		p->free(p);
> > +}
> > +
> > +void pwrseq_register(struct pwrseq *pwrseq)
> > +{
> > +	mutex_lock(&pwrseq_list_mutex);
> > +	list_add(&pwrseq->node, &pwrseq_list);
> > +	mutex_unlock(&pwrseq_list_mutex);
> > +}
> > +
> > +void pwrseq_unregister(struct pwrseq *pwrseq)
> > +{
> > +	mutex_lock(&pwrseq_list_mutex);
> > +	list_del(&pwrseq->node);
> > +	mutex_unlock(&pwrseq_list_mutex);
> > +}
> 
> What is the purpose of pwrseq_register/unregister()? The pwrseq
> structs are added and removed from pwrseq_list, but besides that
> pwrseq_list is not used.
> 

I had thought we may need to dump the pwrseq list in future for debug
purpose. I will delete this unnecessary code.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
