From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/5] thermal: minor cleanup/fixes
Date: Mon, 13 Mar 2017 15:37:33 +0530
Message-ID: <cover.1489399567.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36459 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdCMKIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:08:13 -0400
Received: by mail-pg0-f53.google.com with SMTP id g2so44681190pge.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 03:08:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

This series contains minor fixes/cleanups for thermal cooling drivers.

V2->V3:
- Added Acks from Rui
- Resending as it was getting ignored until now :(

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
