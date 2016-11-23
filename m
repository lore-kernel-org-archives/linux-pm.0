From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Wed, 23 Nov 2016 08:52:18 +0530
Message-ID: <20161123032218.GA22335@vireshk-i7>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
 <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
 <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
 <20161122031717.GE10014@vireshk-i7>
 <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Thanks for explaining on my behalf Vincent :)

On 22-11-16, 19:34, Vincent Guittot wrote:
> On 22 November 2016 at 19:12, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> > I think the question is: what does the performance-level of a domain
> > actually mean?  Or, what are the units?

There is no unit. If we have units like Hz and volts etc, then we can actually
use the existing clk/regulator frameworks straight away.

The whole problem here is that the regulator (and maybe the clock on a different
platform) for a power domain are hidden from the kernel and handled by a black
box (An M3 core in my case). All we can ask is for a performance state, a simple
positive integer value.

> > Depending on the SoC, there's probably a few things this could mean.  It
> > might mean is that an underlying bus/interconnect can be configured to
> > guarantee a specific bandwidth or throughput.

We are talking in terms of power domains here and so if the bus/interconnect has
a power domain for itself, then yes we can very much have that situation. But if
the kernel have the capability of configuring clk and voltages directly, then we
don't need this new infrastructure at all.

> > That in turn might mean
> > that that bus/interconnect might have to be set at a specific
> > frequency/voltage.
> >
> > In your case, IIUC, you're just passing some magic value to some
> > firmware running on a micro-controller, but under the hood that uC is
> > probably configuring a frequency/voltage someplace.
> 
> In the case described by Viresh, it's only about setting the voltage
> of a power domain that is shared between different devices. these
> devices wants to run at different frequency (set by the devices) but
> we have to select a Volateg value that will match with the constraint
> of all devices (in this case the highest voltage)

That's right.

> > So, if we're going to have a generic DT binding for this, it needs to be
> > something that's useful on platforms that are not using magic numbers
> > managed by a uC as well.

What suggestions do you have for this and I am not sure what all cases we want
to solve by this ?

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
