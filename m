From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 0/3] PM: simplify the code logic on device_shutdown and suspend
Date: Mon, 20 Aug 2018 17:18:34 +0800
Message-ID: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

At present, the "parent <- child" and "suppiler <- consumer" ordering info
are stored duplicate in two places dpm_list and devices_kset, and
corresponding, there are two sets of routines to manipulate them. The patch
pushes the dpm_list and dpm_list_mtx out of CONFIG_PM, and let
device_shutdown() use them to implement shutdown seq. Comparing to original
code, this patch tries to simplify the code at the cost of a extra mutex if
without CONFIG_PM and nothing if with CONFIG_PM. The cost on dpm_list_mtx
can be ignored, since the device hot add/remove is not very frequently.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org> 
Cc: linux-kernel@vger.kernel.org
---
Pingfan Liu (3):
  drivers/base: move device_shutdown() to base/power
  PM/shutdown: device_shutdown() uses the order info in dpm_list instead
    of     devices_kset
  drivers/base: clean up unused devices_kset_move_*() functions

 drivers/base/base.h           |   1 -
 drivers/base/core.c           | 126 ------------------------------------------
 drivers/base/power/Makefile   |   1 +
 drivers/base/power/main.c     | 119 +++++++++++----------------------------
 drivers/base/power/power.h    |  25 ++++++---
 drivers/base/power/shutdown.c | 123 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h            |   7 +--
 7 files changed, 173 insertions(+), 229 deletions(-)
 create mode 100644 drivers/base/power/shutdown.c

-- 
2.7.4
