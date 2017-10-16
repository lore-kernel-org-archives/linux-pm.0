From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/5] clk: renesas: rcar-gen3: Restore clocks during resume
Date: Mon, 16 Oct 2017 10:36:49 +0200
Message-ID: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Mike, Stephen,

During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
clock register state is lost.  Note that as the boot loader skips most
initialization after resume, clock register state differs from the state
encountered during normal system boot, too.

Hence after s2ram, some operations may fail because module clocks are
disabled, while drivers expect them to be still enabled.  E.g. in the
absence of commit fbf3d034f2ff6264 ("ravb: add workaround for clock when
resuming with WoL enabled"), EtherAVB fails when Wake-on-LAN has been
enabled using "ethtool -s eth0 wol g":

    ravb e6800000.ethernet eth0: failed to switch device to config mode
    ravb e6800000.ethernet eth0: device will be stopped after h/w processes are done.
    ravb e6800000.ethernet eth0: failed to switch device to config
    PM: Device e6800000.ethernet failed to resume: error -110

In addition, some clocks that were disabled by clk_disable_unused() may
have been re-enabled, wasting power.

This patch series fixes these issues by restoring clock registers during
system resume.  Note that while this fixes EtherAVB operation after
resume from s2ram, EtherAVB cannot be used as an actual wake-up source
from s2ram, only from s2idle, due to PSCI limitations.

To avoid overhead on platforms not needing it, the suspend/resume code
has a build time dependency on sleep and PSCI support, and a runtime
dependency on PSCI.

Changes compared to v2:
  - Drop RFC state,
  - Add Tested-by,
  - Add build and runtime dependencies on PM_SLEEP and PSCI.

Changes compared to v1 (more details in the individual patches):
  - Save module clock registers in suspend_noirq instead of constantly
    updating shadow registers,
  - Restore all module clocks under our control, not just the ones we ever
    changed,
  - Also restore DIV6, SDHI, and R clocks, thus covering all supported
    programmable core clocks on R-Car Gen3.

This series is against the clk-renesas branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
For your convenience, this series is also available in the
topic/cpg-mssr-suspend-resume-v3 branch of the same repository.

This has been tested on Salvator-X with R-Car H3 ES1.0 and M3-W ES1.0,
and on Salvator-XS with R-Car H3 ES2.0 (the latter also needs "[PATCH
0/4] ravb: Add PHY reset support",
https://www.spinics.net/lists/netdev/msg457308.html), and
regression-tested on various other Renesas arm32 boards not using PSCI.

I plan to queue this up in clk-renesas-for-v4.15.
Thanks!

Geert Uytterhoeven (5):
  clk: renesas: cpg-mssr: Restore module clocks during resume
  clk: renesas: cpg-mssr: Add support to restore core clocks during
    resume
  clk: renesas: div6: Restore clock state during resume
  clk: renesas: rcar-gen3: Restore SDHI clocks during resume
  clk: renesas: rcar-gen3: Restore R clock during resume

 drivers/clk/renesas/clk-div6.c         | 38 ++++++++++++-
 drivers/clk/renesas/clk-div6.h         |  3 +-
 drivers/clk/renesas/rcar-gen2-cpg.c    |  7 ++-
 drivers/clk/renesas/rcar-gen2-cpg.h    |  6 +--
 drivers/clk/renesas/rcar-gen3-cpg.c    | 79 +++++++++++++++++++++------
 drivers/clk/renesas/rcar-gen3-cpg.h    |  3 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 99 +++++++++++++++++++++++++++++++++-
 drivers/clk/renesas/renesas-cpg-mssr.h |  3 +-
 8 files changed, 208 insertions(+), 30 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
