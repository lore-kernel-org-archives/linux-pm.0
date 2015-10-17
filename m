From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 17 Oct 2015 13:22:23 -0700
Message-ID: <20151017202223.GB6602@kroah.com>
References: <20151017065750.GA18607@kroah.com>
 <CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com>
 <20151017154709.GE4059@kroah.com>
 <CAL_JsqJvtKt6FpZgnYcsEm_opr9gK_a013BVpZGvnB=51oSUXg@mail.gmail.com>
 <20151017165617.GC25156@kroah.com>
 <CAF6AEGvbYYeZx=YVCv9r5K0xjtLf3gN69gX5DyQ3j0S1qT0Yog@mail.gmail.com>
 <20151017182755.GA28072@kroah.com>
 <CAF6AEGuvr6XMMufY0iDCSkp2BNcWa2=xUxjN66+FtQ6ygS-nyQ@mail.gmail.com>
 <20151017185915.GA28826@kroah.com>
 <CAF6AEGtqiMv6WSk_NVZqu8tMmVvyZQMK=Ta2dr0c=11ebmPJVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38977 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbJQUWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 16:22:24 -0400
Content-Disposition: inline
In-Reply-To: <CAF6AEGtqiMv6WSk_NVZqu8tMmVvyZQMK=Ta2dr0c=11ebmPJVw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

On Sat, Oct 17, 2015 at 03:39:20PM -0400, Rob Clark wrote:
> On Sat, Oct 17, 2015 at 2:59 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Oct 17, 2015 at 02:45:34PM -0400, Rob Clark wrote:
> >> On Sat, Oct 17, 2015 at 2:27 PM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > On Sat, Oct 17, 2015 at 01:54:43PM -0400, Rob Clark wrote:
> >> >> On Sat, Oct 17, 2015 at 12:56 PM, Greg Kroah-Hartman
> >> >> <gregkh@linuxfoundation.org> wrote:
> >> >> >> I'm guessing the time is a matter of probing and undoing the probes
> >> >> >> rather than slow h/w. We could maybe improve things by making sure
> >> >> >> drivers move what they defer on to the beginning of probe, but that
> >> >> >> seems like a horrible, fragile hack.
> >> >> >
> >> >> > How can calling probe and failing cause 2 seconds?  How many different
> >> >> > probe calls are failing here?  Again, a boot log graph would be great to
> >> >> > see as it will show the root cause, not just guessing at this.
> >> >>
> >> >>
> >> >> just fwiw, but when you have a driver that depends on several other
> >> >> drivers (which in turn depend on other drivers and so on), the amount
> >> >> of probe-defer we end up seeing is pretty comical.  Yeah, there
> >> >> probably is some room to optimize by juggling around order drivers do
> >> >> things in probe.  But that doesn't solve the fundamental problem with
> >> >> the current state, about probe order having no clue about
> >> >> dependencies..
> >> >
> >> > I can imagine it is a lot of iterations, but how long does it really
> >> > take?  How many different devices are involved that it takes multiple
> >> > loops in order to finally work out the correct order?  Where is the time
> >> > delays here, just calling probe() and having it instantly return
> >> > shouldn't take all that long.
> >>
> >> offhand, I think the dependencies go at *least* three levels deep..
> >> I'd say, from memory, I see drm/msm taking at least 5 or 6 tries to
> >> get all the way through requesting it's various different
> >> regulators/clks/gpios.
> >
> > And how long does that really take?  Numbers please :)
> >
> >> I hadn't really paid attention to how many
> >> tries the drivers I depend on go through.  (Of those, I take clks from
> >> two different clk drivers (which have dependency on a 3rd clk driver),
> >> and regulators and gpio's come from at least two places, which in turn
> >> have dependencies on clks, etc.)  I don't have really good hard
> >> numbers handy (since my observations of this are w/ console over uart
> >> which effects timings, and so I see it taking much longer than 2sec)..
> >> but the 2sec figure that Tomeu mentioned seemed pretty plausible to
> >> me.
> >>
> >> I can try to get better #'s... I should have my kernel hat on at least
> >> some of the time next week.. but the 2sec figure didn't seem
> >> unrealistic to me.
> >
> > Based on the time it takes a modern laptop to boot, 2 seconds is
> > forever, there has to be something else going on here other than just
> > calling probe() a bunch of times.  Please use the tools we have to
> > determine this before trying to change the driver core.
> 
> yes, I am aware of the tools.. although so far I spend most of my time
> just trying to get things working in the first place ;-)

And that's where most people stop, if you want to make it fast, you have
to put in more effort, sorry.  Don't expect the driver core to work
around driver bugs for you.

> All I was trying to point out was that Tomeu's figures didn't really
> seem unrealistic.  I mean, given that the average SoC driver probably
> depends on at least one clock and at least one regulator, having to
> probe each driver at least twice seems plausible.  And that having a
> noticeable effect on boot time doesn't seem surprising.  I'm not sure
> that saying 'modern laptop can boot in 2sec' adds much to the
> discussion since I don't think you have quite so much interdependency
> between devices vs random probe order.  I have seen arm devices boot
> to UI in similar times, but that was pre-devicetree days.

2 extra probes add a second to the boot time?  Those sound like really
broken drivers to me :)

thanks,

greg k-h
