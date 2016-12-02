From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/3] ARM: da850: fix pll0 rate setting
Date: Fri,  2 Dec 2016 16:38:51 +0100
Message-ID: <1480693134-31324-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
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

Bartosz Golaszewski (3):
  ARM: da850: fix infinite loop in clk_set_rate()
  ARM: da850: coding style fix
  ARM: da850: fix da850_set_pll0rate()

 arch/arm/mach-davinci/da850.c     | 31 +++++++++++++++++++++++++------
 drivers/cpufreq/davinci-cpufreq.c |  2 +-
 drivers/mtd/nand/davinci_nand.c   |  2 +-
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.9.3
