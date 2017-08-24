From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Wed, 23 Aug 2017 20:36:12 -0700
Message-ID: <20170824033617.20840-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36843 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdHXDgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 23:36:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id m7so1961188pga.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2017 20:36:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>

Overview:
* Reorganizes chip data definitions
* Enables features landed in these patches:
  dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
  power: supply: bq27xxx: Add chip data memory read/write support
  power: supply: bq27xxx: Add power_supply_battery_info support
* Supports the following chips (only BQ27425 is active)
  BQ27500, 545, 425, 421, 441, 621

Changes in v3:
* BQ27425 tested; workaround minor chip bug
* Dropped driver_version
* Fixed dbg_dupes logic for .props & .dm_regs
* Dropped two props array dupes

Changes in v2:
* Added di->opts flags for remaining chip features
* Commented out untested bq27xxx_dm_regs parameters
* Changed dbg_dupes to run only once

Notes on v1:
* Not fully tested (hence RFC tag)


Liam Breck (5):
  power: supply: bq27xxx: Create single chip data table
  power: supply: bq27xxx: Add chip IDs for previously shadowed chips
  power: supply: bq27xxx: Enable data memory update for certain chips
  power: supply: bq27xxx: Flag identical chip data when in debug mode
  power: supply: bq27xxx: Remove duplicate chip data arrays

 drivers/power/supply/bq27xxx_battery.c     | 514 ++++++++++++++---------------
 drivers/power/supply/bq27xxx_battery_i2c.c |  16 +-
 include/linux/power/bq27xxx_battery.h      |  10 +-
 3 files changed, 265 insertions(+), 275 deletions(-)

-- 
2.13.2
