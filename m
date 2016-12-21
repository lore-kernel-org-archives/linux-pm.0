From: Matthew Wilcox <mawilcox@linuxonhyperv.com>
Subject: [PATCH 0/4] Convert thermal subsystem to the IDA allocator
Date: Wed, 21 Dec 2016 09:47:02 -0800
Message-ID: <1482342426-30520-1-git-send-email-mawilcox@linuxonhyperv.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from p3plsmtps2ded01.prod.phx3.secureserver.net ([208.109.80.58]:60884
        "EHLO p3plsmtps2ded01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758860AbcLUPvG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 10:51:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-pm@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

None of the ID allocations are in a hot path, so I think it's better
to use the ida_simple_get/ida_simple_remove API instead of having
individual mutexes.

I've only compile-tested these changes ... even that is quite tricky given
the maze of Kconfig options which make it hard to select those drivers.
I eventually gave up and played games with the header files to get the
compiler to compile them cleanly.

Matthew Wilcox (4):
  thermal core: convert ID allocation to IDA
  thermal: convert clock cooling to use an IDA
  thermal: convert cpu_cooling to use an IDA
  thermal: convert devfreq_cooling to use an IDA

 drivers/thermal/clock_cooling.c   | 50 +++++---------------------
 drivers/thermal/cpu_cooling.c     | 63 ++++++--------------------------
 drivers/thermal/devfreq_cooling.c | 53 +++++----------------------
 drivers/thermal/thermal_core.c    | 75 ++++++++++++++-------------------------
 include/linux/thermal.h           |  4 +--
 5 files changed, 56 insertions(+), 189 deletions(-)

-- 
2.11.0

