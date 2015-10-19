From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 10:52:14 +0100
Message-ID: <20151019095214.GW32532@n2100.arm.linux.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <1445247881.53393.146.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445247881.53393.146.camel@infradead.org>
Sender: linux-clk-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 10:44:41AM +0100, David Woodhouse wrote:
> On Sun, 2015-10-18 at 20:53 +0100, Mark Brown wrote:
> > On Sun, Oct 18, 2015 at 12:37:57PM -0700, Greg Kroah-Hartman wrote:
> > > On Sun, Oct 18, 2015 at 08:29:31PM +0100, Mark Brown wrote:
> > > > On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote:
> > 
> > > > > I can't see adding calls like this all over the tree just to solve a
> > > > > bus-specific problem, you are adding of_* calls where they aren't
> > > > > needed, or wanted, at all.
> > 
> > > > This isn't bus specific, I'm not sure what makes you say that?
> > 
> > > You are making it bus-specific by putting these calls all over the tree
> > > in different bus subsystems semi-randomly for all I can determine.
> > 
> > Do you mean firmware rather than bus here?  I think that's the confusion
> > I have...
> 
> Certainly, if it literally is adding of_* calls then that would seem to
> be gratuitously firmware-specific. Nothing should be using those these
> days; any new code should be using the generic device property APIs
> (except in special cases).

I asked Linus Walleij about that with the fwnode_get_named_gpiod() stuff,
and Linus didn't seem to know how this should be used.

It doesn't help that dev->fwnode is not initialised, but dev->of_node
is.  Are we supposed to grope around in dev->of_node for the embedded
fwnode instead of using dev->fwnode?

At the moment, at least to me, fwnode looks like some kind of
experimental half-baked thing rather than a real usable solution.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
