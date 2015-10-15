From: ahaslam@baylibre.com
Subject: [PATCH v8 0/6] Multiple intermediate states for genpd
Date: Thu, 15 Oct 2015 14:16:30 +0200
Message-ID: <1444911396-3473-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34367 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbbJOMQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 08:16:44 -0400
Received: by wicgb1 with SMTP id gb1so25564847wic.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 05:16:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@linaro.org, ulf.hansson@linaro.org, lina.iyer@linaro.org, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Some architectures may have intermediate power levels between on and off.

This patch set adds the ability to declare multiple states for a given
generic power domain, the idea is that the deepest state will be entered
which does not violate any of the device or sub-domain latency constraints.

Changes since v7:
* rebase to 4.3-rc5

* add genpd_init_simple (Lina's suggestion) for platforms that don't have
multiple states and don't declare initial latencies. A default OFF
state with initial 0 latencies will be used in this case.

* Append Mark's patch to add "states" and "timings" to the genpd
debugfs

Changes since v6:
* change int to unsigned int were appropriate.

* spelling mistakes, and fix commit message for removal of latencies.

Changes since v5:
* rebase to 4.1-rc1

* Pass state array as an init argument on pm_genpd_init

* declare a default OFF state with no latencies, that will be used if a
null state argument is given.

* set the deepest state when using sync_poweroff.

* create and use name allocation function in the debug area
instead of inline.

Changes since v4:
* move to power_on/off callbacks out of the state array Platforms can
check the state_idx to know what state the power on/off corresponds to.

* convert states to pointer,
Dynamically allocate the states array to save memory on platforms
with several power domains.

* rename target_state to state_idx and remove init_state.

Changes since v3:
* remove old power on/off function at the end of the
series so that compilation will not break in between.

Changes since v2:
* remove state argument and macros from save/restore callbacks.

* added init_state for platforms to pass the initial state when the genpd
is initially off.

* convert current genpd users for the structure changes.

Changes since v1:
* split the changes so that the actual logic that selects the target state
is a separate patch.

* move the cached logic out of the state function and add
it back to default_power_down_ok.

* rename default_power_down_ok_state to power_down_ok_for_state

Axel Haslam (5):
  PM / Domains: prepare for multiple states
  PM / Domains: core changes for multiple states
  PM / Domains: make governor select deepest state
  ARM: imx6: pm: declare pm domain latency on power_state struct.
  PM / Domains: remove old power on/off latencies.

Marc Titinger (1):
  PM / Domains: add debugfs 'states' and 'timings' seq files

 arch/arm/mach-exynos/pm_domains.c     |   2 +-
 arch/arm/mach-imx/gpc.c               |  18 ++-
 arch/arm/mach-s3c64xx/pm.c            |   4 +-
 arch/arm/mach-shmobile/pm-r8a7779.c   |   2 +-
 arch/arm/mach-shmobile/pm-rmobile.c   |   2 +-
 arch/arm/mach-ux500/pm_domains.c      |   2 +-
 arch/arm/mach-zx/zx296702-pm-domain.c |   2 +-
 drivers/base/power/domain.c           | 253 ++++++++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c  |  71 ++++++----
 drivers/clk/shmobile/clk-mstp.c       |   2 +-
 drivers/soc/dove/pmu.c                |   2 +-
 drivers/soc/mediatek/mtk-scpsys.c     |   2 +-
 include/linux/pm_domain.h             |  25 +++-
 13 files changed, 336 insertions(+), 51 deletions(-)

-- 
2.4.5

