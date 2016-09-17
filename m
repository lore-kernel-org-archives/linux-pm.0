From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/2] power: bq27xxx_battery: add configurable poll_interval
Date: Fri, 16 Sep 2016 20:42:53 -0700
Message-ID: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35765 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIQDm7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 23:42:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

Patchset series fixes the kernel_parameter poll_interval not scheduling
the next event with the new interval. Also creates a sysfs entry that is
useful for udev attribute assignment.

Matt Ranostay (2):
  power: bq27xxx_battery: add configurable poll_interval by sysfs
  power: bq27xxx_battery: allow kernel poll_interval parameter runtime
    update

 drivers/power/supply/bq27xxx_battery.c | 87 +++++++++++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.7.4

