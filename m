From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] cpu_cooling: cooling dev registration cleanups
Date: Tue,  5 Dec 2017 11:02:42 +0530
Message-ID: <cover.1512451487.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43954 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdLEFgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 00:36:52 -0500
Received: by mail-pg0-f66.google.com with SMTP id b18so9954753pgv.10
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 21:36:51 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, javi.merino@kernel.org, amit.kachhap@gmail.com, rui.zhang@intel.com, ionela.voinescu@arm.com

Hi,

This cleans up the helpers exposed by cpu_cooling driver and its users
and removes a lot of code (around 280 lines effectively). Lots of unused
code is removed.

Tested on Hikey6220 and based over pm/linux-next.

V1->V2:
- Fixed a compilation warning when CONFIG_CPU_THERMAL isn't selected.

--
viresh

Viresh Kumar (4):
  cpu_cooling: Make of_cpufreq_power_cooling_register() parse DT
  cpu_cooling: Remove unused cpufreq_power_cooling_register()
  cpu_cooling: Keep only one of_cpufreq*cooling_register() helper
  cpu_cooling: Drop static-power related stuff

 Documentation/thermal/cpu-cooling-api.txt |  33 +----
 drivers/cpufreq/arm_big_little.c          |  23 +---
 drivers/cpufreq/cpufreq-dt.c              |  27 +---
 drivers/cpufreq/mediatek-cpufreq.c        |  22 +---
 drivers/cpufreq/qoriq-cpufreq.c           |  14 +--
 drivers/thermal/cpu_cooling.c             | 201 ++++++------------------------
 include/linux/cpu_cooling.h               |  75 +++--------
 include/trace/events/thermal.h            |  10 +-
 8 files changed, 64 insertions(+), 341 deletions(-)

-- 
2.11.0
