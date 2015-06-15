From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/10] OPP: Add code to support operating-points-v2 bindings
Date: Mon, 15 Jun 2015 17:27:26 +0530
Message-ID: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34226 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbbFOL5z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:57:55 -0400
Received: by pacgb13 with SMTP id gb13so34241363pac.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:57:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

This adds code to support operating-points-v2 bindings. Not everything
is supported yet, but most of the basic stuff is.

Tested with: Exynos 5250, dual cortex A15 board. With both old and new
bindings.

Bindings are already frozen:
http://marc.info/?i=cover.1433434659.git.viresh.kumar%40linaro.org

Pushed here as well for reference:
ssh://git@git.linaro.org/people/viresh.kumar/linux.git opp/v2

Viresh Kumar (10):
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

 drivers/base/power/opp.c     | 1063 ++++++++++++++++++++++++++++++++----------
 drivers/cpufreq/cpufreq-dt.c |   58 ++-
 include/linux/pm_opp.h       |   29 ++
 3 files changed, 902 insertions(+), 248 deletions(-)

-- 
2.4.0

