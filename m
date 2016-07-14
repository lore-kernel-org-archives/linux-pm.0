From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC v3] PM / hibernate: Introduce snapshot test mode for hibernation
Date: Thu, 14 Jul 2016 18:45:12 +0800
Message-ID: <cover.1468491815.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Sometimes we need to debug during hibernation resume stage, and
it would be convenient for the user to test if the snapshot stored
in the disk can be successfully restored without BIOSes or system
re-initialization involved in. So this patch has introduced a snapshot
test mode for this purpose.

Chen Yu (2):
  PM / hibernate: Introduce snapshot test mode for hibernation
  PM / Documentation: Add description for snapshot test mode

 Documentation/power/basic-pm-debugging.txt | 15 +++++++--
 kernel/power/hibernate.c                   | 49 +++++++++++++++++++++++++++++-
 kernel/power/main.c                        |  3 ++
 kernel/power/power.h                       |  3 ++
 kernel/power/suspend.c                     |  7 +++++
 kernel/power/swap.c                        |  7 +++++
 6 files changed, 80 insertions(+), 4 deletions(-)

-- 
2.7.4
