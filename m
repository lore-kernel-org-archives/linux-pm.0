From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/5] thermal: minor cleanup/fixes
Date: Tue,  7 Feb 2017 09:39:30 +0530
Message-ID: <cover.1486440448.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series contains minor fixes/cleanups for thermal cooling drivers.

V1->V2:
- s/dev_warn/dev_err (Rafael)
- Two new patches to make similar (^^) change at other places

Viresh Kumar (5):
  thermal: devfreq: Simplify expression
  thermal: devfreq_cooling: Replace dev_warn with dev_err
  thermal: devfreq: Check OPP for errors
  thermal: cpu_cooling: Replace dev_warn with dev_err
  thermal: cpu_cooling: Check OPP for errors

 drivers/thermal/cpu_cooling.c     | 19 +++++++++++++------
 drivers/thermal/devfreq_cooling.c | 14 ++++++++++----
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.7.1.410.g6faf27b
