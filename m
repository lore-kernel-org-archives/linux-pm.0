From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Thu, 22 Oct 2015 07:44:05 -0700
Message-ID: <20151022144405.GC21861@kroah.com>
References: <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com>
 <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
 <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
 <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>Jingoo Han <j>
List-Id: linux-pm@vger.kernel.org

<oops, sent too early...>

On Thu, Oct 22, 2015 at 11:05:11AM +0200, Tomeu Vizoso wrote:
> But that's moot currently because Greg believes that the time spent
> probing devices at boot time could be reduced enough so that the order
> in which devices are probed becomes irrelevant. IME that would have to
> be under 200ms so that the user doesn't notice and that's unicorn-far
> from any bootlog I have ever seen.

But as no one has actually produced a bootlog, how do you know that?
Where exactly is your time being spent?  What driver is causing long
delays?  Why is the long-delay-drivers not being done in their own
thread?  And most importantly, why are you ignoring the work that people
did back in 2008 to solve the issue on other hardware platforms?

> Given that downstreams are already carrying as many hacks as they
> could think of to speed total boot up, I think this is effectively
> telling them to go away.

No I'm not, I'm asking for real data, not hand-wavy-this-is-going-to
solve-the-random-issue-i'm-having type patch by putting random calls in
semi-random subsystems all over the kernel.

And when I ask for real data, you respond with the fact that you aren't
trying to speed up boot time here at all, so what am I supposed to think
other than that you don't care enough to do the real work and are trying
to hack the driver core up instead.

> Sorry for the rant,

No apologies needed, it's cathartic at times :)

thanks,

greg k-h
