From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.10-rc5
Date: Sun, 22 Jan 2017 11:06:07 +0800
Message-ID: <1485054367.2487.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:37128 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdAVDGL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Jan 2017 22:06:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for v4.10-rc5 with
top-most commit bad94f8068122b6342a73a218dad7d41e6ea907b:

  Merge branches 'thermal-core' and 'thermal-soc' into for-rc (2017-01-
20 16:24:54 +0800)

on top of commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

Specifics:

- Fix a regression that thermal zone dynamically allocated sysfs
attributes are freed before they're removed, which is introduced in
4.10-rc1. (Jacob von Chorus)

- Fix a boot warning because deprecated hwmon API is used. (Fabio
Estevam)

- A couple of fixes for rockchip thermal driver. (Brian Norris, Caesar
Wang)

thanks,
rui

----------------------------------------------------------------
Brian Norris (2):
      thermal: rockchip: improve conversion error messages
      thermal: rockchip: don't pass table structs by value

Caesar Wang (4):
      thermal: rockchip: fixes invalid temperature case
      thermal: rockchip: optimize the conversion table
      thermal: rockchip: handle set_trips without the trip points
      thermal: rockchip: fixes the conversion table

Fabio Estevam (1):
      thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()

Jacob von Chorus (1):
      thermal: core: move tz->device.groups cleanup to thermal_release

Zhang Rui (2):
      Merge branch 'fixes' of git://git.kernel.org/.../evalenti/linux-
soc-thermal into thermal-soc
      Merge branches 'thermal-core' and 'thermal-soc' into for-rc

 drivers/thermal/rockchip_thermal.c | 153 ++++++++++++++++++++++++-----
--------
 drivers/thermal/thermal_core.c     |  10 +--
 drivers/thermal/thermal_hwmon.c    |  20 +----
 3 files changed, 108 insertions(+), 75 deletions(-)
