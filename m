From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Thu, 29 Oct 2015 16:38:00 -0700
Message-ID: <20151029233800.GB19782@codeaurora.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <20151016002243.GA23912@codeaurora.org>
 <20151016060227.GS19018@linux>
 <20151016191658.GA16437@codeaurora.org>
 <20151017041055.GZ19018@linux>
 <20151022163942.GX8232@sirena.org.uk>
 <20151027081917.GD5505@ubuntu>
 <20151028081742.GC28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151028081742.GC28319-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/28, Mark Brown wrote:
> On Tue, Oct 27, 2015 at 01:49:17PM +0530, Viresh Kumar wrote:
> > On 23-10-15, 01:39, Mark Brown wrote:
> 
> > > I'm not sure that's
> > > a place we want to end up just yet, I think it's safer to just have a
> > > little bit of code in the kernel that glues things together in the cases
> > > where this is needed.  
> 
> > So you are effectively saying that we shouldn't go ahead with multi
> > regulator support in OPP library, right?
> 
> Well, I think things like libraries for getting the data tables out of
> DT are fine but I'm not convinced that trying to avoid having any device
> specific code at all is sufficiently clear yet - as far as I know we're
> mostly looking at a fairly small subset of devices still and with things
> like sequencing in the mix it's a bit worrying to me to be putting it
> all into an ABI intended to be used with no knowledge of the platform.

Agreed. Looking at the current oppv2 binding I'm confused how it
even works. It shows cpu-supply = <&phandle1>, <&phandle2>, etc.
which doesn't work with the regulator bindings design. It seems
that Viresh figured that out when implementing support for
multiple regulators, so the binding was changed to put names in
the opp tables and then use that to get regulators in the opp
core. Urgh.

I think I understand the goal here though. The goal is to move
all the clk_get()/regulator_get() and clock and regulator API
interactions into the OPP framework so that we can say "go to OPP
at index 4" from the cpufreq core and the OPP framework takes
care of actually doing the transition. Given that doing such a
transition could be very machine specific, we probably ought to
make the OPP framework flexible enough to let us decide how to do
that.

Perhaps we need to expand on the compatible string in the opp
node to have compatible = "vendor,cool-transition",
"operating-points-v2"? Then we can plug in vendor specific
drivers that handle the frequency/voltage transition and they'll
know that the fourth column in the voltage entry corresponds to
this particular device's foo-supply and in what order to change
voltages. A generic driver could exist for the simple case of one
regulator and one clock that matches on "operating-points-v2".

Or we can avoid doing any clk_get()/regulator_get() stuff inside
the OPP framework, and let OPP consumers tell the OPP framework
about each clock and regulator it wants the framework to manage
on the consumer's behalf. It could even tell the framework which
regulator corresponds to which voltage column and in what order
to change the voltages so that the OPP framework doesn't need to
know these device specific details. Then the consumer can still
say go to OPP level 4 and that all works without introducing some
new DT ABI.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
