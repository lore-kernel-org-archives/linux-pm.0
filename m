From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 00/16] OPP: Add code to support operating-points-v2 bindings
Date: Wed, 29 Jul 2015 16:22:55 +0530
Message-ID: <cover.1438166099.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36246 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbG2KxT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 06:53:19 -0400
Received: by pdjr16 with SMTP id r16so4107210pdj.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 03:53:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

Resending this again because:
- opp-hz is now 64 bit long and so that required a binding update.
- There is another 4 patch series that as updating turbo OPP support,
  along with updates to cpufreq core and cpufreq-dt driver.
- A minor bug-fix in V2 4/11, which caused false positive for duplicate
  OPPs in some cases.

Tested this on dual-core exynos board with the driver inbuilt as well as
a module. Tried multiple insertion/removals of the module. Have tested
cpufreq-dt driver with both old and new bindings.

Also tried by sending some dummy OPPs that contained opp-hz greater than
what can be captured by u32, to test the u64 updates.

----------x-----------------x-------------

This adds code to support operating-points-v2 bindings. Not everything
is supported yet, but most of the basic stuff is.

Pushed here as well for reference:
ssh://git@git.linaro.org/people/viresh.kumar/linux.git opp/v2

V2->V3:
- Update to opp-hz binding to make it pass u64 value instead of 32 bit
  value. This is done to support clock rates greater than 4 GHz.
- Merged two inter-related series, opp-v2 and turbo mode updates.
- Fixed 4/11 from opp-v2 series, which cased false positive for
  duplicate OPPs in some cases.
- Add a separate comment in _opp_add_dynamic() (5/16), to clearly
  specify that we pass &dev_opp->opp_list to list_for_each_entry_rcu()
  and not pass 'head' which contains the same value. Because head will
  get modified by the code and that may result in an infinite loop.
- Accumulate more RBY tags.

V1->V2:
- 1/11 is a new patch which moves the bindings file into opp specific
  folder.
- 'opp-suspend' binding got updated and is part of individual OPPs now,
  instead of a phandle present in the opp table.
- Some more minor reformatting as suggested by Bartlomiej and Stephen,
  they were already posted as reply to earlier patches in V1.

Bartlomiej Zolnierkiewicz (2):
  PM / OPP: add dev_pm_opp_is_turbo() helper
  cpufreq: Update boost flag while initializing freq table from OPPs

Viresh Kumar (14):
  PM / OPP: Update bindings to make opp-hz a 64 bit value
  PM / OPP: Create a directory for opp bindings
  PM / OPP: Relocate few routines
  PM / OPP: Create _remove_device_opp() for freeing dev_opp
  PM / OPP: Allocate dev_opp from _add_device_opp()
  PM / OPP: Break _opp_add_dynamic() into smaller functions
  PM / OPP: Add support to parse "operating-points-v2" bindings
  PM / OPP: Add clock-latency-ns support
  PM / OPP: Add OPP sharing information to OPP library
  PM / OPP: Add support for opp-suspend
  PM / OPP: Add helpers for initializing CPU OPPs
  cpufreq: Allow drivers to enable boost support after registering
    driver
  cpufreq: dt: Add support for operating-points-v2 bindings
  cpufreq: dt: Add support for turbo/boost mode

 .../devicetree/bindings/power/{ => opp}/opp.txt    |   40 +-
 drivers/base/power/opp.c                           | 1084 ++++++++++++++++----
 drivers/cpufreq/cpufreq-dt.c                       |   64 +-
 drivers/cpufreq/cpufreq.c                          |   68 +-
 drivers/cpufreq/cpufreq_opp.c                      |    4 +
 drivers/cpufreq/freq_table.c                       |   15 +
 include/linux/cpufreq.h                            |   12 +
 include/linux/pm_opp.h                             |   36 +
 8 files changed, 1049 insertions(+), 274 deletions(-)
 rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (93%)

-- 
2.4.0

