From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sat, 24 Oct 2015 19:55:51 +0200
Message-ID: <CAMuHMdUOtx+rsV9FkYqgj3g5S0cqD6qH=gp6p-69Ord8gykY3w@mail.gmail.com>
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
	<20151022144405.GC21861@kroah.com>
	<562930AB.1070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <562930AB.1070203@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gma>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 22, 2015 at 8:53 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> I have been defaulting to the position that has been asserted by
> the device tree maintainters, that probe deferrals work just fine
> for at least the majority of cases (and is the message I have been
> sharing in my conference presentations about device tree).  But I
> suspect that there is at least a small minority of cases that are not
> well served by probe deferral.  (Not to be read as an endorsement of
> this specific patch series, just a generic observation.)

Yep, once in a while people still stumble on obscure subsystems and drivers
not supporting probe deferral. Usually they don't fail with a big bang, so
everything seems fine.

E.g. last week's "of_mdiobus_register_phy() and deferred probe"
(https://lkml.org/lkml/2015/10/22/377).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
