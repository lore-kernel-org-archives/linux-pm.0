From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3] PM / Domain: renesas: Fix active wakeup behavior
Date: Thu,  9 Nov 2017 14:26:59 +0100
Message-ID: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Rafael, Ulf, Kevin,

If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
used as a wakeup source, it must be kept active during system suspend.

Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source, or if it is part of the wakeup path.

However, this is merely a workaround.  The proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core, using the new GENPD_FLAG_ACTIVE_WAKEUP flag introduced in commit
95a20ef6f7e54c6a ("PM / Domains: Allow genpd users to specify default
active wakeup behavior").

Hence this series does that for PM Domain drivers used on R-Car, RZ/A1,
RZ/G1 SoCs, mimicking what is already done succesfully on SH/R-Mobile
SoCs.  This will allow for the workarounds can be removed later.

This series was extracted from "[PATCH 00/10] PM / Domain: renesas: Fix
active wakeup behavior", and retains only fixes for Renesas PM Domain
drivers.

Changes compared to v1:
  - Integrate follow-up patches to use GENPD_FLAG_ACTIVE_WAKEUP instead
    of adding an "always true" callback.

As GENPD_FLAG_ACTIVE_WAKEUP exists in pm/linux-next only, and this
series is a dependency for the removal of workarounds in drivers of
multiple subsystems (net, irqchip, and gpio), I think it is a good idea
to still queue this for v4.15 in the PM tree, if possible.

This has been tested on r8a73a4/ape6evm, r8a7740/armadillo,
r8a7791/koelsch, r8a7795/salvator-x and -xs, r8a7795/salvator-x, and
sh73a0/kzm9g.

Thanks for applying!

Geert Uytterhoeven (3):
  clk: renesas: mstp: Keep wakeup sources active during system suspend
  clk: renesas: cpg-mssr: Keep wakeup sources active during system
    suspend
  soc: renesas: rcar-sysc: Keep wakeup sources active during system
    suspend

 drivers/clk/renesas/clk-mstp.c         | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 drivers/soc/renesas/rcar-sysc.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
