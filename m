From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] cpu_cooling: cooling dev registration cleanups
Date: Wed, 15 Nov 2017 14:49:44 +0530
Message-ID: <cover.1510735482.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45006 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756168AbdKOJUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:20:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id 4so8687113pge.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 01:20:54 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, javi.merino@kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, rui.zhang@intel.com

Hi,

This touches cpu_cooling and a bunch of cpufreq drivers and I am not
sure who should take these patches really.

This cleans up the helpers exposed by cpu_cooling driver and its users
and removes a lot of code (around 280 lines effectively). Lots of unused
code is removed.

Tested on Hikey6220 and based over linux-next/master.
Not targeted for 4.15-rc1 :)

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
2.15.0.194.g9af6a3dea062
