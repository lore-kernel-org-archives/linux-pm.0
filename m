From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.11-rc5
Date: Thu, 30 Mar 2017 10:50:09 +0800
Message-ID: <1490842209.2347.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:3764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752733AbdC3CuN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 22:50:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for v4.11-rc5 with
top-most commit 3ea3217cf91804be6ed9b368ef4ac7911eb1dadc:

  thermal: cpu_cooling: Check OPP for errors (2017-03-13 10:06:55
+0800)

on top of commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

Specifics:

- Fix a potential deadlock in cpu_cooling driver, which was introduced
in 4.11-rc1. (Matthew Wilcox)

- Fix the cpu_cooling and devfreq_cooling code to handle possible error
return value from OPP calls, together with three minor fixes in the
same patch series. (Viresh Kumar)

thanks,
rui

----------------------------------------------------------------
Matthew Wilcox (1):
      thermal: Fix potential deadlock in cpu_cooling

Viresh Kumar (5):
      thermal: devfreq: Simplify expression
      thermal: devfreq_cooling: Replace dev_warn with dev_err
      thermal: devfreq: Check OPP for errors
      thermal: cpu_cooling: Replace dev_warn with dev_err
      thermal: cpu_cooling: Check OPP for errors

 drivers/thermal/cpu_cooling.c     | 39 ++++++++++++++++++++++++-------
--------
 drivers/thermal/devfreq_cooling.c | 14 ++++++++++----
 2 files changed, 34 insertions(+), 19 deletions(-)
