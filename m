From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] On-demand device probing
Date: Tue, 27 Oct 2015 06:03:43 +0100
Message-ID: <10275162.nPuKaJCcTU@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510201159400.1855-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1510201159400.1855-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gma>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 20, 2015 12:04:05 PM Alan Stern wrote:
> On Tue, 20 Oct 2015, Mark Brown wrote:
> 
> > On Tue, Oct 20, 2015 at 10:40:03AM -0400, Alan Stern wrote:
> > 
> > > Furthermore, that applies only to devices that use synchronous suspend.  
> > > Async suspend is becoming common, and there the only restrictions are 
> > > parent-child relations plus whatever explicit requirements that drivers 
> > > impose by calling device_pm_wait_for_dev().
> > 
> > Hrm, this is the first I'd noticed that feature though I see the initial
> > commit dates from January.
> 
> Async suspend and device_pm_wait_for_dev() were added in January 2010, 
> not 2015!
> 
> >  It looks like most of the users are PCs at
> > the minute but we should be using it more widely for embedded things,
> > there's definitely some cases I'm aware of where it will allow us to
> > remove some open coding.
> > 
> > It does seem like we want to be feeding dependency information we
> > discover for probing way into the suspend dependencies...
> 
> Rafael has been thinking about a way to do this systematically.  
> Nothing concrete has emerged yet.

Well, good point. :-)

I've been kind of struggling with finding time to work on the patches lately
and some aspects of the design are still not finalized.  It seems, though, that
it can be beneficial to discuss the approach in general, so let me start a new
thread for that.

Thanks,
Rafael
