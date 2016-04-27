From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/7] cpufreq: Get rid of cpufreq-dt's platform data
Date: Wed, 27 Apr 2016 08:52:20 +0530
Message-ID: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36746 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbcD0DWq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 23:22:46 -0400
Received: by mail-pf0-f173.google.com with SMTP id c189so14766870pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 20:22:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Guys,

The aim of the series is to kill the users of cpufreq-dt's platform
data, i.e. mvebu. And because that required a new API to the OPP core,
this just became a mix of cpufreq and OPP patches.

V2:
- New patch 2/7.
- Use -ENOTSUPP instead of -ENOSYS or -EINVAL for unimplemented APIs.
- Moved mvebu code to drivers/cpufreq and the same file creates the platform
  device now for maintaining ordering.
- Not cast required to drop 'const' for cpumask *.

Viresh Kumar (7):
  PM / OPP: -ENOSYS is applicable only to syscalls
  PM / OPP: Mark cpumask as const in dev_pm_opp_set_sharing_cpus()
  PM / OPP: Add dev_pm_opp_get_sharing_cpus()
  cpufreq: dt: Identify cpu-sharing for platforms without
    operating-points-v2
  mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP tables as shared
  cpufreq: dt: Kill platform-data
  cpufreq: mvebu: Move cpufreq code into drivers/cpufreq/

 MAINTAINERS                     |   1 +
 arch/arm/mach-mvebu/pmsu.c      |  85 -------------------------------
 drivers/base/power/opp/cpu.c    |  48 +++++++++++++++++-
 drivers/cpufreq/Makefile        |   1 +
 drivers/cpufreq/cpufreq-dt.c    |  22 ++++-----
 drivers/cpufreq/mvebu-cpufreq.c | 107 ++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq-dt.h      |  24 ---------
 include/linux/pm_opp.h          |  36 ++++++++------
 8 files changed, 187 insertions(+), 137 deletions(-)
 create mode 100644 drivers/cpufreq/mvebu-cpufreq.c
 delete mode 100644 include/linux/cpufreq-dt.h

-- 
2.7.1.410.g6faf27b

