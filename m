From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Tue, 30 Aug 2016 17:11:58 +0100
Message-ID: <20160830161158.GE9337@e106622-lin>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-2-git-send-email-juri.lelli@arm.com>
 <CAKfTPtC_tzc8xJkL1QUgn35dZ53g3-+V=qX7aefG89AGKJkQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtC_tzc8xJkL1QUgn35dZ53g3-+V=qX7aefG89AGKJkQOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 16/08/16 11:02, Vincent Guittot wrote:
> On 19 July 2016 at 14:40, Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org> wrote:
> > ARM systems may be configured to have cpus with different power/performance
> > characteristics within the same chip. In this case, additional information
> > has to be made available to the kernel (the scheduler in particular) for it
> > to be aware of such differences and take decisions accordingly.
> >
> > Therefore, this patch aims at standardizing cpu capacities device tree
> > bindings for ARM platforms. Bindings define cpu capacity-dmips-mhz
> > parameter, to allow operating systems to retrieve such information from
> > the device tree and initialize related kernel structures, paving the way
> > for common code in the kernel to deal with heterogeneity.
> >

[...]

> 
> FWIW, Acked-by Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 

Thanks!

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
