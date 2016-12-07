From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/4] ARM: da850: fix pll0 rate setting
Date: Wed,  7 Dec 2016 16:22:14 +0100
Message-ID: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

While trying to set the pll0 rate from the kernel I noticed there are
two issues with da850 clocks. The first patch fixes an infinite loop
in propagate_rate(). The third fixes an oops in da850_set_pll0rate().
The second patch is just a coding style fix, while we're at it.

v1 -> v2:
- change the approach in 1/3: create a new clock for nand inheriting
  the rate from the aemif clock (verified that nand still works on
  da850-lcdk)
- patch 3/3: also update the davinci_cpufreq driver - the only
  (indirect) user of da850_set_pll0rate()
- s/requested_rate/rate in 3/3

v2 -> v3:
- 1/3: keep the "aemif" connector id for the nand clock
- 3/3: instead of multiplying freq->frequency, divide rate by 1000
- retested both davinci_nand and clk_set_rate() for pll0

v3 -> v4:
- 1/4: add a comment explaining why we're leaving a NULL dev_id
- 2/4: emac_clk is added twice to the clock lookup table too - fix it
  and verify that davinci_mmdio gets a functional clock
- 4/4: s/opp == NULL/!opp/

Bartosz Golaszewski (4):
  ARM: da850: fix infinite loop in clk_set_rate()
  ARM: da850: don't add the emac clock to the clock lookup table twice
  ARM: da850: coding style fix
  ARM: da850: fix da850_set_pll0rate()

 arch/arm/mach-davinci/da850.c     | 51 +++++++++++++++++++++++++++++++++------
 drivers/cpufreq/davinci-cpufreq.c |  2 +-
 2 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.9.3
