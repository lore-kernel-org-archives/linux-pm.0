From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/5] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
Date: Tue,  7 Nov 2017 13:48:10 +0100
Message-ID: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi Rafael, Ulf, Kevin,

It is quite common for PM Domains to require slave devices to be kept
active during system suspend if they are to be used as wakeup sources.
To enable this, currently each PM Domain or driver has to provide its
own gpd_dev_ops.active_wakeup() callback.

All existing callbacks either return always true, or a fixed value
depending on the PM Domain.

Hence this patch series simplifies active wakeup handling by replacing
the callback by a flag:
  - Patch 1 adds a new new flag GENPD_FLAG_ACTIVE_WAKEUP, to be set by
    PM Domain drivers that want to use the new handling,
  - Patches 2-4 convert all existing users of the callback to the new
    flag,
  - Patch 5 removes the callback.

This series was extracted from "[PATCH 00/10] PM / Domain: renesas: Fix
active wakeup behavior", and retains only PM Domain changes to existing
drivers.

Changes compared to v2:
  - Add Acked-by, Reviewed-by,
  - Drop RFC status from dependent patches, as everything can go in
    through the pm tree.

Changes compared to v1 (most suggested by Ulf):
  - Use the flag in se instead of setting up an "always true" callback,
  - Convert the mediatek and rockchip PM Domain drivers,
  - Remove the callback.

Thanks for applying for v4.15!

Geert Uytterhoeven (5):
  PM / Domains: Allow genpd users to specify default active wakeup
    behavior
  ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ACTIVE_WAKEUP
  soc: mediatek: Use GENPD_FLAG_ACTIVE_WAKEUP
  soc: rockchip: power-domain: Use GENPD_FLAG_ACTIVE_WAKEUP
  PM / Domains: Remove gpd_dev_ops.active_wakeup() callback

 arch/arm/mach-shmobile/pm-rmobile.c |  8 +-------
 drivers/base/power/domain.c         | 13 ++++---------
 drivers/soc/mediatek/mtk-scpsys.c   | 14 ++------------
 drivers/soc/rockchip/pm_domains.c   | 14 ++------------
 include/linux/pm_domain.h           |  8 ++++----
 5 files changed, 13 insertions(+), 44 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
