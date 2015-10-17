From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 17 Oct 2015 11:27:55 -0700
Message-ID: <20151017182755.GA28072@kroah.com>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com>
 <20151017154709.GE4059@kroah.com>
 <CAL_JsqJvtKt6FpZgnYcsEm_opr9gK_a013BVpZGvnB=51oSUXg@mail.gmail.com>
 <20151017165617.GC25156@kroah.com>
 <CAF6AEGvbYYeZx=YVCv9r5K0xjtLf3gN69gX5DyQ3j0S1qT0Yog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGvbYYeZx=YVCv9r5K0xjtLf3gN69gX5DyQ3j0S1qT0Yog@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 17, 2015 at 01:54:43PM -0400, Rob Clark wrote:
> On Sat, Oct 17, 2015 at 12:56 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >> I'm guessing the time is a matter of probing and undoing the probes
> >> rather than slow h/w. We could maybe improve things by making sure
> >> drivers move what they defer on to the beginning of probe, but that
> >> seems like a horrible, fragile hack.
> >
> > How can calling probe and failing cause 2 seconds?  How many different
> > probe calls are failing here?  Again, a boot log graph would be great to
> > see as it will show the root cause, not just guessing at this.
> 
> 
> just fwiw, but when you have a driver that depends on several other
> drivers (which in turn depend on other drivers and so on), the amount
> of probe-defer we end up seeing is pretty comical.  Yeah, there
> probably is some room to optimize by juggling around order drivers do
> things in probe.  But that doesn't solve the fundamental problem with
> the current state, about probe order having no clue about
> dependencies..

I can imagine it is a lot of iterations, but how long does it really
take?  How many different devices are involved that it takes multiple
loops in order to finally work out the correct order?  Where is the time
delays here, just calling probe() and having it instantly return
shouldn't take all that long.

thanks,

greg k-h
