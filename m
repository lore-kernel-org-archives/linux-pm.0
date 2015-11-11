From: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] thermal: mediatek: Add cpu power cooling model.
Date: Wed, 11 Nov 2015 09:36:57 +0000
Message-ID: <20151111093656.GA2781@e104805>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-2-git-send-email-dawei.chien@mediatek.com>
 <20151104193958.GC14127@localhost.localdomain>
 <1446721837.4016.57.camel@mtksdaap41>
 <20151106032433.GL3773@ubuntu>
 <20151110112017.GA3551@e104805>
 <20151110184121.GC5240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151110184121.GC5240-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dawei chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 10, 2015 at 10:41:22AM -0800, Eduardo Valentin wrote:
> On Tue, Nov 10, 2015 at 11:20:18AM +0000, Javi Merino wrote:
> > On Fri, Nov 06, 2015 at 08:54:33AM +0530, Viresh Kumar wrote:
> > > Cc'ing Javi (which you should have as he wrote the power-thing for
> > > cpu-cooling).
> > > 
> > > On 05-11-15, 19:10, dawei chien wrote:
> > > > This is because our platform currently only support mt8173_cpufreq.c, so
> > > > that I only add static power model for our owner IC.
> > > 
> > > Bindings are (normally) supposed to be general than a platform
> > > specific.
> > > 
> > > > Please understanding that I wouldn't give a DT binding document since I
> > > > will remove static power table on next version, but I can try to explain
> > > > it.
> > > 
> > > Then just don't add things in the first place.
> > > 
> > > > As far as I know, static power is somewhat leakage of CPU clusters, so
> > > > that we hardly to find a formula, which can suitable all kinds of CPUs
> > > > since leakage is different. In ARM IPA framework, static power only need
> > > > to be defined by who register cpufreq_power_cooling_register. The
> > > > voltage/power table is just one way to present leakage power of CPUs.
> > > 
> > > The bindings don't fix the values for static power, but just provides
> > > a field for platforms to use. Everyone can then send its own power
> > > figures. Why do you thing it can't be generalized?
> > 
> > The way they are described here is useful only for this platform, but
> > it's not generic.  It only takes into account voltage as (I assume)
> > it's the only variable that affects it in this implementation.  A
> > generalized version of the static power should take into account the
> > temperature and the idle state.
> 
> Still, why would we have one binding to describe static power per platform?
> 
> I would prefer we go towards a generalized binding description.

Sure, I wasn't saying that we want one binding per platform.  I was
just saying that this binding can't be made generic because it's not.

Cheers,
Javi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
