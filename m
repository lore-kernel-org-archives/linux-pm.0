From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/2] power_supply: add new POWER_SUPPLY_PROP_POLL_INTERVAL property
Date: Wed, 28 Sep 2016 12:55:10 -0700
Message-ID: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36059 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752032AbcI1TzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 15:55:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

Add power supply class POWER_SUPPLY_PROP_POLL_INTERVAL to allow dynamic device statistic
updating interval.

Changes from v1:
 * Fixed milliseconds typo in commit message
 * Fixed file paths to drivers/power/supply
 * Don't update if settings are the same condition

Matt Ranostay (2):
  power: power_supply: add new property POWER_SUPPLY_PROP_POLL_INTERVAL
  power: bq27xxx_battery: add poll interval property query

 Documentation/power/power_supply_class.txt |  1 +
 drivers/power/supply/bq27xxx_battery.c     | 40 ++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c  |  1 +
 include/linux/power_supply.h               |  1 +
 4 files changed, 43 insertions(+)

-- 
2.7.4

