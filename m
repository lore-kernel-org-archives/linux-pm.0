From: ahaslam@baylibre.com
Subject: [PATCH/RFC v6 0/5] genpd multiple states v6
Date: Wed, 29 Apr 2015 21:10:10 +0200
Message-ID: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37424 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbD2TLQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 15:11:16 -0400
Received: by widdi4 with SMTP id di4so77257920wid.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 12:11:15 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Some architectures may have intermediate power
levels between on and off. each state in between
may have its own set of procedures to put the
power domain into that state.

This patch adds the ability to declare multiple
states for a given generic power domain, the idea
is that the deepest state will be entered which
does not violate any of the device or sub-domain
latency constraints.

Changes since v5:
* rebase to 4.1-rc1

* Pass state array as an init argument on pm_genpd_init

* declare a default OFF state with no latencies, that
will be used if a null state argument is given.

* set the deepest state when using sync_poweroff.

* create and use name allocation function in the
debug area instead of inline.

Changes since v4:
* move to power_on/off callbacks out of the state array
Platforms can check the state_idx to know what
state the power on/off corresponds to.

* convert states to pointer,
Dynamically allocate the states array to save memory
on platforms with several power domains.

* fix bisect-ability,
by allowing the old latencies values to be used if the
state_count is 0. (meaning no states defined by the platform)

* rename target_state to state_idx and remove init_state,
platforms can directly set state_idx on registering
a domain that is off.

Changes since v3:
* remove old power on/off function at the end of the
series so that compilation will not break in between.

Changes since v2:
* remove state argument and macros from save/restore
callbacks.

* added init_state for platforms to pass the
initial state when the genpd is initially off.

* convert current genpd users for the structure changes.

* compile tested for shmobile_defconfig, exynos_defconfig,
s3c6400_defconfig u8500_defconfig.

Changes since v1:
* split the changes so that the actual logic that
selects the target state is a separate patch.

* move the cached logic out of the state function and add
it back to default_power_down_ok.

* use static arrays instead of dynamic for state declaration
since its not expected to have lots of intermediate states.
That way we don't have to mess with allocations.

* rename default_power_down_ok_state to power_down_ok_for_state

Axel Haslam (5):
  PM / Domains: prepare for multiple states
  PM / Domains: core changes for multiple states
  PM / Domains: make governor select deepest state
  ARM: imx6: pm: declare pm domain latency on power_state struct.
  PM / Domains: remove old power on/off callbacks.

 arch/arm/mach-exynos/pm_domains.c    |   2 +-
 arch/arm/mach-imx/gpc.c              |  18 ++++-
 arch/arm/mach-s3c64xx/pm.c           |   5 +-
 arch/arm/mach-shmobile/pm-r8a7779.c  |   2 +-
 arch/arm/mach-shmobile/pm-rmobile.c  |   2 +-
 arch/arm/mach-ux500/pm_domains.c     |   2 +-
 drivers/base/power/domain.c          | 138 +++++++++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c |  70 +++++++++++-------
 include/linux/pm_domain.h            |  20 ++++-
 9 files changed, 213 insertions(+), 46 deletions(-)

-- 
1.9.1

