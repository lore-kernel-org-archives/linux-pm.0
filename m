From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/6] kernel: power: Neaten PM: logging
Date: Thu,  4 Jun 2015 11:36:43 -0700
Message-ID: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Joe Perches (6):
  power: hibernate: Use separate messages for "Syncing filesystems"
  power: process: Standardize "freezing process" messages
  power: suspend: Standardize "Syncing filesystems" messages
  power: swap: Standardize "Image <loading/saving>" messages
  power: user: Standardize "Syncing filesystems ..." message
  power: Use pr_fmt and pr_<level>

 kernel/power/hibernate.c    |  61 ++++++++++-----------
 kernel/power/main.c         |   6 +-
 kernel/power/process.c      |  54 +++++++++---------
 kernel/power/qos.c          |   6 +-
 kernel/power/snapshot.c     |  38 ++++++-------
 kernel/power/suspend.c      |  29 +++++-----
 kernel/power/suspend_test.c |  44 ++++++---------
 kernel/power/swap.c         | 131 ++++++++++++++++++++------------------------
 kernel/power/user.c         |   6 +-
 9 files changed, 178 insertions(+), 197 deletions(-)

-- 
2.1.2
