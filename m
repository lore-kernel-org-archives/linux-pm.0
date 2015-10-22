From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Thu, 22 Oct 2015 12:26:39 -0700
Message-ID: <20151022192639.GC27248@kroah.com>
References: <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com>
 <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
 <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
 <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
 <20151022144405.GC21861@kroah.com>
 <562930AB.1070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <562930AB.1070203@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jingoo
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 22, 2015 at 11:53:31AM -0700, Frank Rowand wrote:
> On 10/22/2015 7:44 AM, Greg Kroah-Hartman wrote:
> > <oops, sent too early...>
> > 
> > On Thu, Oct 22, 2015 at 11:05:11AM +0200, Tomeu Vizoso wrote:
> >> But that's moot currently because Greg believes that the time spent
> >> probing devices at boot time could be reduced enough so that the order
> >> in which devices are probed becomes irrelevant. IME that would have to
> >> be under 200ms so that the user doesn't notice and that's unicorn-far
> >> from any bootlog I have ever seen.
> > 
> > But as no one has actually produced a bootlog, how do you know that?
> > Where exactly is your time being spent?  What driver is causing long
> > delays?  Why is the long-delay-drivers not being done in their own
> > thread?  And most importantly, why are you ignoring the work that people
> > did back in 2008 to solve the issue on other hardware platforms?
> > 
> >> Given that downstreams are already carrying as many hacks as they
> >> could think of to speed total boot up, I think this is effectively
> >> telling them to go away.
> > 
> > No I'm not, I'm asking for real data, not hand-wavy-this-is-going-to
> > solve-the-random-issue-i'm-having type patch by putting random calls in
> > semi-random subsystems all over the kernel.
> > 
> > And when I ask for real data, you respond with the fact that you aren't
> > trying to speed up boot time here at all, so what am I supposed to think
> 
> I also had the understanding that this patch series was about improving
> boot time.  But I was kindly corrected that the behavior change was
> getting the panel displaying stuff at an earlier point in the boot sequence,
> _not_ completing the entire boot faster. 
> 
> The claim for the current series, in patch 0 in v7 is:
> 
>    With this series I get the kernel to output to the panel in 0.5s,
>    instead of 2.8s.
> 
> Just to get side-tracked, one other approach at ordering to reduce
> deferrals reported a modest boot time reduction for four boards and a
> very slight boot time increase for one other board.) The report of boot
> times with that approach was in:
> 
>   http://article.gmane.org/gmane.linux.drivers.devicetree/133010
> 
> from Alexander Holler.
> 
> I have not searched further to see if there is more data of boot time
> reductions from any of the other attempts to change driver binding
> order to move dependencies before use of a resource.  But whether
> there is a performance improvement or not, there continues to be
> a stream of developers creatively impacting the binding order for
> their specific driver(s) or board.  So it seems that maybe there
> is an underlying problem, or we don't have adequate documentation
> explaining how to avoid a need to order bindings, or the
> documentation exists and is not being read.
> 
> I have been defaulting to the position that has been asserted by
> the device tree maintainters, that probe deferrals work just fine
> for at least the majority of cases (and is the message I have been
> sharing in my conference presentations about device tree).  But I
> suspect that there is at least a small minority of cases that are not
> well served by probe deferral.  (Not to be read as an endorsement of
> this specific patch series, just a generic observation.)

I agree, there might be some small numbers that this is a problem for,
and if so, great, show us the boot logs where things are taking up all
of the time, and we can work on resolving those issues.

But without hard numbers / details, this all is just random hand-waving,
and I don't like making core kernel changes on that basis.  And no one
else should ever want us to do that either.

thanks,

greg k-h
