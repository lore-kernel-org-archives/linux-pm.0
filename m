From: ahaslam@baylibre.com
Subject: [RFC v5 0/8]  genpd multiple states v5
Date: Fri, 24 Apr 2015 19:35:16 +0200
Message-ID: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32978 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966362AbbDXRfk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:40 -0400
Received: by wgin8 with SMTP id n8so57931305wgi.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
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

Axel Haslam (8):
  PM / Domains: structure changes for multiple states
  PM / Domains: select deepest state
  ARM: s3c64xx: pm: Convert to multiple states
  ARM: exynos: pm: Convert to multiple states
  ARM: r8a7779: pm: Convert to multiple states
  ARM: rmobile: pm: Convert to multiple states
  ARM: ux500: pm: Convert to multiple states
  PM / Domains: remove old power on/off callbacks.

 arch/arm/mach-exynos/pm_domains.c    |  8 ++++
 arch/arm/mach-s3c64xx/pm.c           | 22 +++++++++++
 arch/arm/mach-shmobile/pm-r8a7779.c  |  8 ++++
 arch/arm/mach-shmobile/pm-rmobile.c  |  8 ++++
 arch/arm/mach-ux500/pm_domains.c     |  8 ++++
 drivers/base/power/domain.c          | 75 +++++++++++++++++++++++++++++++++---
 drivers/base/power/domain_governor.c | 71 +++++++++++++++++++++-------------
 include/linux/pm_domain.h            | 12 +++++-
 8 files changed, 178 insertions(+), 34 deletions(-)

-- 
1.9.1

