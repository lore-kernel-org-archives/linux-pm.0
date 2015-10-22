From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] On-demand device probing
Date: Thu, 22 Oct 2015 02:54:33 +0200
Message-ID: <1757126.NgBN1ISfc9@vostro.rjw.lan>
References: <20151020153612.GB32054@sirena.org.uk> <Pine.LNX.4.44L0.1510201159400.1855-100000@iolanthe.rowland.org> <CAAObsKChQN4gg91dCWJS_Co_MrYyBrB1J7gxgGo4hsPXNZRp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKChQN4gg91dCWJS_Co_MrYyBrB1J7gxgGo4hsPXNZRp3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 20, 2015 06:21:55 PM Tomeu Vizoso wrote:
> On 20 October 2015 at 18:04, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 20 Oct 2015, Mark Brown wrote:
> >
> >> On Tue, Oct 20, 2015 at 10:40:03AM -0400, Alan Stern wrote:
> >>
> >> > Furthermore, that applies only to devices that use synchronous suspend.
> >> > Async suspend is becoming common, and there the only restrictions are
> >> > parent-child relations plus whatever explicit requirements that drivers
> >> > impose by calling device_pm_wait_for_dev().
> >>
> >> Hrm, this is the first I'd noticed that feature though I see the initial
> >> commit dates from January.
> >
> > Async suspend and device_pm_wait_for_dev() were added in January 2010,
> > not 2015!
> >
> >>  It looks like most of the users are PCs at
> >> the minute but we should be using it more widely for embedded things,
> >> there's definitely some cases I'm aware of where it will allow us to
> >> remove some open coding.
> >>
> >> It does seem like we want to be feeding dependency information we
> >> discover for probing way into the suspend dependencies...
> >
> > Rafael has been thinking about a way to do this systematically.
> > Nothing concrete has emerged yet.
> 
> This iteration of the series would make this quite easy, as
> dependencies are calculated before probes are attempted:
> 
> https://lkml.org/lkml/2015/6/17/311

Well, if you know how to represent "links" between devices, the mechanism
introduced here doesn't really add much value, because in that case the
core knows what the dependencies are in the first place and can only
defer the probes that have to be deferred.

Thanks,
Rafael
