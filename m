From: ahaslam@baylibre.com
Subject: [RFC v3 0/7] genpd multiple states v3
Date: Mon, 20 Apr 2015 17:02:01 +0200
Message-ID: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37888 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbDTPCP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 11:02:15 -0400
Received: by wiun10 with SMTP id n10so95163875wiu.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2015 08:02:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Some architectures may have intermediate power
levels between on and off. each state in between
may have its own set of procedures to put the
power domain into that state.

This patch adds the ability to declare multiple
states for a given generic power domain, the idea
is that the deepest state will be entered which
does not violate any of the device or sub-domain
latency constraints.

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
Axel Haslam (7):
  PM / Domains: structure changes for multiple states
  PM / Domains: select deepest state
  ARM: s3c64xx: pm: Convert to multiple states
  ARM: exynos: pm: Convert to multiple states
  ARM: r8a7779: pm: Convert to multiple states
  ARM: rmobile: pm: Convert to multiple states
  ARM: ux500: pm: Convert to multiple states

 arch/arm/mach-exynos/pm_domains.c    |  6 ++-
 arch/arm/mach-s3c64xx/pm.c           |  8 +++-
 arch/arm/mach-shmobile/pm-r8a7779.c  |  6 ++-
 arch/arm/mach-shmobile/pm-rmobile.c  |  6 ++-
 arch/arm/mach-ux500/pm_domains.c     |  8 +++-
 drivers/base/power/domain.c          | 43 ++++++++++++++------
 drivers/base/power/domain_governor.c | 77 ++++++++++++++++++++++++------------
 include/linux/pm_domain.h            | 21 ++++++++--
 8 files changed, 125 insertions(+), 50 deletions(-)

-- 
1.9.1

