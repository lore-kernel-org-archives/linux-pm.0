From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 01:35:38 +0200
Message-ID: <23698237.227MziouDO@vostro.rjw.lan>
References: <CAAObsKChQN4gg91dCWJS_Co_MrYyBrB1J7gxgGo4hsPXNZRp3g@mail.gmail.com> <Pine.LNX.4.44L0.1510201311260.1855-100000@iolanthe.rowland.org> <20151020193528.GE32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151020193528.GE32054@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbarys>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 20, 2015 08:35:28 PM Mark Brown wrote:
> 
> --7fVr/IRGAG9sAW4J
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, Oct 20, 2015 at 01:14:46PM -0400, Alan Stern wrote:
> > On Tue, 20 Oct 2015, Tomeu Vizoso wrote:
> 
> > > This iteration of the series would make this quite easy, as
> > > dependencies are calculated before probes are attempted:
> 
> > > https://lkml.org/lkml/2015/6/17/311
> 
> > But what Rafael is proposing is quite general; it would apply to _all_
> > dependencies as opposed to just those present in DT drivers or those=20
> > affecting platform_devices.
> 
> We'll still need most of the DT bits that are there at the minute (the
> ones strewn around the subsystems) AFAICT since it's at the point where
> we parse the DT and work out what the dependencies are which we probably
> want to do prior to getting the drivers up and will be different for
> ACPI.  I think the level of DT dependency here looks a lot larger than
> it actually is due to the fact that a lot of what's being modified is DT
> parsing code.

Right, something will have to register the dependency, or a "link" between
devices, with the core once we find out that the dependency is there.

Thanks,
Rafael

