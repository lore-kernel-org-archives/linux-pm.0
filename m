From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL]  Thermal management updates for v4.8-rc4
Date: Thu, 25 Aug 2016 15:58:50 +0800
Message-ID: <1472111930.2167.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932604AbcHYH7d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Aug 2016 03:59:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for v4.8-rc4 with
top-most commit 829bc78aa7628e81a9de717316b85cbee3c5eb86:

  thermal: imx: fix a possible NULL dereference (2016-08-19 21:34:08
+0800)

on top of commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

Specifics:
- Fix cpu_cooling to have separate thermal_cooling_device_ops
structures for cpus with and without power model, to avoid NULL
dereference in cpufreq_state2power. From Brendan Jackman.
- Fix a possible NULL dereference in imx_thermal driver. From Corentin
LABBE .
- Another two trivial fixes, one typo fix and one deleting module
owner. From Caesar Wang and Markus Elfring.

thanks,
rui

----------------------------------------------------------------
Brendan Jackman (1):
      thermal: cpu_cooling: Fix NULL dereference in cpufreq_state2power

Caesar Wang (1):
      thermal: trivial: fix the typo

Corentin LABBE (1):
      thermal: imx: fix a possible NULL dereference

Markus Elfring (1):
      Thermal-INT3406: Delete owner assignment

 .../devicetree/bindings/thermal/thermal.txt         | 10 +++++-----
 drivers/thermal/cpu_cooling.c                       | 21
++++++++++++++++-----
 drivers/thermal/imx_thermal.c                       |  4 +---
 drivers/thermal/int340x_thermal/int3406_thermal.c   |  1 -
 4 files changed, 22 insertions(+), 14 deletions(-)
