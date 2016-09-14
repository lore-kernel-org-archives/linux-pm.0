From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/3] ARM: dts: am33xx/dra7xx: Fix cpufreq regression
Date: Wed, 14 Sep 2016 15:57:14 -0500
Message-ID: <20160914205717.21975-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45589 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759948AbcINU5z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Sep 2016 16:57:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>

Hi,
CPUFreq on am335x and dra7 platforms got broken by two things:
 - Updated OPPv2 nodes in device tree were merged before driver to
   handle them was accepted.
 - OMAP platforms now use the new cpufreq-dt-platdev driver to create
   cpufreq-dt platform device but non OMAP TI devices were not changed
   over to this driver.

This series addresses the first issue listed above by reverting three of
the dts patches that got merged to restore OPPv1 tables. The second issue
is addressed by [1].

With both this series and that patch we will have the existing cpufreq
support restored on am335x and dra7xx.

Regards,
Dave

[1] http://marc.info/?l=linux-pm&m=147388573513082&w=2

Dave Gerlach (3):
  Revert "ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu"
  Revert "ARM: dts: am33xx: Move to operating-points-v2 table and
    ti-cpufreq driver"
  Revert "ARM: dts: dra7: Move to operating-points-v2 table"

 arch/arm/boot/dts/am335x-boneblack.dts | 11 -----
 arch/arm/boot/dts/am33xx.dtsi          | 88 +++++-----------------------------
 arch/arm/boot/dts/dra7.dtsi            | 26 ++--------
 arch/arm/boot/dts/dra74x.dtsi          |  1 -
 4 files changed, 18 insertions(+), 108 deletions(-)

-- 
2.9.3

