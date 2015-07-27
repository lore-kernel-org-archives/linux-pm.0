From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/11] OPP: Add code to support operating-points-v2 bindings
Date: Mon, 27 Jul 2015 10:32:30 +0530
Message-ID: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:32840 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbbG0FDN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 01:03:13 -0400
Received: by pdbnt7 with SMTP id nt7so45174408pdb.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 22:03:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This is mostly reviewed and its been out on the lists for around one and
half month. We can get it pushed for 4.3 now. Resending the series
because of minor updates in few patches, which were also sent as replies
to earlier version.

I have tested this on dual-core exynos board with the driver inbuilt as
well as a module. Tried multiple insertion/removals of the module. Have
tested cpufreq-dt driver with both old and new bindings.

----------x-----------------x-------------

This adds code to support operating-points-v2 bindings. Not everything
is supported yet, but most of the basic stuff is.

Pushed here as well for reference:
ssh://git@git.linaro.org/people/viresh.kumar/linux.git opp/v2

V1->V2:
- 1/11 is a new patch which moves the bindings file into opp specific
  folder.
- 'opp-suspend' binding got updated and is part of individual OPPs now,
  instead of a phandle present in the opp table.
- Some more minor reformatting as suggested by Bartlomiej and Stephen,
  they were already posted as reply to earlier patches in V1.

Viresh Kumar (11):
  opp: Create a directory for opp bindings
  opp: Relocate few routines
  OPP: Create _remove_device_opp() for freeing dev_opp
  OPP: Allocate dev_opp from _add_device_opp()
  OPP: Break _opp_add_dynamic() into smaller functions
  opp: Add support to parse "operating-points-v2" bindings
  OPP: Add clock-latency-ns support
  opp: Add OPP sharing information to OPP library
  OPP: Add support for opp-suspend
  opp: Add helpers for initializing CPU OPPs
  cpufreq-dt: Add support for operating-points-v2 bindings

 .../devicetree/bindings/power/{ => opp}/opp.txt    |    0
 drivers/base/power/opp.c                           | 1072 +++++++++++++++-----
 drivers/cpufreq/cpufreq-dt.c                       |   56 +-
 include/linux/pm_opp.h                             |   29 +
 4 files changed, 905 insertions(+), 252 deletions(-)
 rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)

-- 
2.4.0

