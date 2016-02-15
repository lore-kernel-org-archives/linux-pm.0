From: ahaslam@baylibre.com
Subject: [PATCH v12 0/3] Multiple intermediate states for genpd
Date: Mon, 15 Feb 2016 11:10:50 +0100
Message-ID: <1455531053-11291-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36123 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbcBOKLF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 05:11:05 -0500
Received: by mail-wm0-f51.google.com with SMTP id g62so50659698wme.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 02:11:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, lina.iyer@linaro.org
Cc: khilman@baylibre.com, linux-pm@vger.kernel.org, geert@linux-m68k.org, mtitinger@baylibre.com, rjw@rjwysocki.net, bcousson@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Some architectures may have intermediate power levels between on and off.

This patch set adds the ability to declare multiple states for a given
generic power domain, the idea is that the deepest state will be entered
which does not violate any of the device or sub-domain latency constraints.

Changes since v11
* Use static array of state instead of dynamic allocation

Changes since v10
* Several reworks after Ulf Hansson's comments:
 - merge the governor changes and core changes into a single patch
 - remove the "name" of the state.
 - add a default state allocation function
 - convert governor power done ok function to while loop.
 - reword commit message
*rebased on next-20160205

Changes since v9
*rebased on linux-next

Changes since v8
* rebased to linux-pm next

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
Axel Haslam (3):
  PM / Domains: Support for multiple states
  ARM: imx6: pm: declare pm domain latency on power_state struct.
  PM / Domains: remove old power on/off latencies.

 arch/arm/mach-imx/gpc.c              |  9 +++--
 drivers/base/power/domain.c          | 33 ++++++++++++++++---
 drivers/base/power/domain_governor.c | 64 ++++++++++++++++++++++--------------
 include/linux/pm_domain.h            | 13 ++++++--
 4 files changed, 86 insertions(+), 33 deletions(-)

-- 
2.6.3

