From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sun, 18 Oct 2015 12:37:57 -0700
Message-ID: <20151018193757.GA9147@kroah.com>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151018192931.GY14956@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jin
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 18, 2015 at 08:29:31PM +0100, Mark Brown wrote:
> On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote:
> 
> > I can't see adding calls like this all over the tree just to solve a
> > bus-specific problem, you are adding of_* calls where they aren't
> > needed, or wanted, at all.
> 
> This isn't bus specific, I'm not sure what makes you say that?

You are making it bus-specific by putting these calls all over the tree
in different bus subsystems semi-randomly for all I can determine.

> > What is the root-problem of your delay in device probing?  I read your
> > last patch series and I can't seem to figure out what the issue is that
> > this is solving in any "better" way from the existing deferred probing.
> 
> So, I don't actually have any platforms that are especially bothered by
> this (at least not for my use cases) so there's a bit of educated
> guessing going on here but there's two broad things I'm aware of.  
> 
> One is that regardless of the actual performance of the system when
> deferred probe goes off it splats errors all over the console which
> makes it look like something is going wrong even if everything is fine
> in the end.  If lots of deferred probing happens then the volume gets
> big too.  People find this distracting, noisy and ugly - it obscures
> actual issues and trains people to ignore errors.  I do think this is a
> reasonable concern and that it's worth trying to mitigate against
> deferral for this reason alone.  We don't want to just ignore the errors
> and not print anything either since if the resource doesn't appear the
> user needs to know what is preventing the driver from instantiating so
> they can try to fix it.

This has come up many times, I have no objection to just turning that
message into a debug message that can be dynamically enabled for those
people wanting to debug their systems for boot time issues.

Please send a patch to do so.

thanks,

greg k-h
