From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 0/5] clk: renesas: rcar-gen3: Restore clocks during resume
Date: Thu, 29 Jun 2017 15:25:15 +0200
Message-ID: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:34434 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbdF2NZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 09:25:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
clock register state is lost.  Note that as the boot loader skips most
initialization after resume, clock register state differs from the state
encountered during normal system boot, too.

Hence after s2ram, some operations may fail because module clocks are
disabled, while drivers expect them to be still enabled.  E.g. EtherAVB
fails when Wake-on-LAN has been enabled using "ethtool -s eth0 wol g":

    ravb e6800000.ethernet eth0: failed to switch device to config mode
    ravb e6800000.ethernet eth0: device will be stopped after h/w processes are done.
    ravb e6800000.ethernet eth0: failed to switch device to config
    PM: Device e6800000.ethernet failed to resume: error -110

In addition, some clocks that were disabled by clk_disable_unused() may
have been re-enabled, wasting power.

This RFC is a second attempt to fix this issue by restoring clock registers
during system resume.

Note that while this fixes EtherAVB operation after resume from s2ram,
EtherAVB cannot be used as an actual wake-up source from s2ram, only
from s2idle, due to PSCI limitations.

Changes compared to v1 (more details in the individual patches):
  - Save module clock registers in suspend_noirq instead of constantly
    updating shadow registers,
  - Restore all module clocks under our control, not just the ones we ever
    changed,
  - Also restore DIV6, SDHI, and R clocks, thus covering all supported
    programmable core clocks on R-Car Gen3.

As clock register restore is only needed on R-Car Gen3 with PSCI, although
harmless on other systems, perhaps the save/restore code should be
protected by #ifdef CONFIG_ARM_PSCI_FW?

This series is against clk-next, with "clk: renesas: div6: Document fields
used for parent selection" applied on top.

This has been tested on Salvator-X with R-Car H3 ES1.0 and M3-W ES1.0.
On Salvator-XS with R-Car H3 ES2.0, EtherAVB restarts after system resume,
but NFS fails with "server not responding", probably not due to a clock
issue.

Thanks for your comments!

Geert Uytterhoeven (5):
  [RFC] clk: renesas: cpg-mssr: Restore module clocks during resume
  [RFC] clk: renesas: cpg-mssr: Add support to restore core clocks
    during resume
  [RFC] clk: renesas: div6: Restore clock state during resume
  [RFC] clk: renesas: rcar-gen3: Restore SDHI clocks during resume
  [RFC] clk: renesas: rcar-gen3: Restore R clock during resume

 drivers/clk/renesas/clk-div6.c         | 38 ++++++++++++++-
 drivers/clk/renesas/clk-div6.h         |  3 +-
 drivers/clk/renesas/rcar-gen2-cpg.c    |  7 ++-
 drivers/clk/renesas/rcar-gen2-cpg.h    |  6 +--
 drivers/clk/renesas/rcar-gen3-cpg.c    | 79 +++++++++++++++++++++++++-------
 drivers/clk/renesas/rcar-gen3-cpg.h    |  3 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 84 +++++++++++++++++++++++++++++++++-
 drivers/clk/renesas/renesas-cpg-mssr.h |  3 +-
 8 files changed, 193 insertions(+), 30 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
