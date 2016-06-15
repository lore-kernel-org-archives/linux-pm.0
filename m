From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Wed, 15 Jun 2016 15:24:32 +0100
Message-ID: <20160615142432.GE5981@e106622-lin>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
 <CAKfTPtBnwepf3gpR2zFXHvkaxB_mSiVM1Wv3RD+iuX72HN8bcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtBnwepf3gpR2zFXHvkaxB_mSiVM1Wv3RD+iuX72HN8bcg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sai Charan Gurrappadi <sgurrappadi-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof
List-Id: linux-pm@vger.kernel.org

On 15/06/16 14:51, Vincent Guittot wrote:
> On 15 June 2016 at 12:17, Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org> wrote:

[...]

> > +==========================================
> > +ARM CPUs capacity bindings
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems may be configured to have cpus with different power/performance
> > +characteristics within the same chip. In this case, additional information
> > +has to be made available to the kernel (the scheduler in particular) for
> 
> not sure that it's worth mentioning the scheduler in particular here
> 

OK. I can remove that bit.

> > +it to be aware of such differences and take decisions accordingly.
> > +

[...]

> > +==========================================
> > +3 - capacity-dmips-mhz
> > +==========================================
> > +
> > +capacity-dmips-mhz is an optional cpu node [1] property: u32 value
> > +representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
> > +maximum frequency available to the cpu is then used to calculate the capacity
> > +value internally used by the kernel.
> > +
> > +capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
> > +node, it has to be specified for every other cpu nodes, or the system will
> > +fall back to the default capacity value for every CPU. If cpufreq is not
> > +available, final capacities are calculated by directly using capacity-dmips-
> > +mhz values (normalized w.r.t. the highest value found while parsing the DT).
> 
> looks good to me
> 

Great! Thanks for reviewing this.

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
