From: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC 0/2] extends OPP for voltage ranges
Date: Tue, 20 May 2014 16:27:38 +0200
Message-ID: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34039 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaETO1q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 10:27:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>

For a lot of components we don't have a strict one to one
relation between the operating frequency of the component
and a single voltage, but rather a range of valid voltages.

Most commonly those are defined as a minimum voltage needed,
a typical (or nominal) voltage chosen by the component vendor
for optimum performance and an absolute maximum voltage that
may not be exceeded without damaging the component.

Currently the OPP framework defines it's single voltage to be
the minimum voltage required for an OPP, although people have
started to implicitly redefine it to be the nominal voltage as
this gives some safety margin in the general case.

Also cpufreq drivers have started to add (or substract) a
abitrary "voltage tolerance" to the supplied values as the
connected regulators are often not able to supply the exact
specified voltage.

Rather than pushing more such workarounds into drivers, we
should enable the OPP framework to handle voltage ranges,
so we don't need any abitrary tolerances in places where we
instead could use well defined values from the component
datasheet.

The follwing 2 patches implement this handling without changing
the current behavior, but I already have a new cpufrew driver
making use the of the extended functionality that I'll post
later if you agree that the general direction of those patches
make sense.

Lucas Stach (2):
  PM / OPP: allow to use voltage ranges
  PM / OPP: extend DT parsing to allow voltage ranges

 Documentation/devicetree/bindings/power/opp.txt | 23 ++++++++++
 arch/arm/mach-omap2/opp.c                       |  3 +-
 arch/arm/mach-omap2/pm.c                        |  2 +-
 arch/arm/mach-vexpress/spc.c                    |  3 +-
 drivers/base/power/opp.c                        | 61 +++++++++++++++++++------
 drivers/cpufreq/cpufreq-cpu0.c                  |  6 +--
 drivers/cpufreq/exynos5440-cpufreq.c            |  2 +-
 drivers/cpufreq/imx6q-cpufreq.c                 |  6 +--
 drivers/cpufreq/omap-cpufreq.c                  |  2 +-
 drivers/devfreq/exynos/exynos4_bus.c            | 12 +++--
 drivers/devfreq/exynos/exynos5_bus.c            |  8 ++--
 include/linux/pm_opp.h                          | 19 ++++++--
 12 files changed, 111 insertions(+), 36 deletions(-)

-- 
2.0.0.rc0

