From: Liam Breck <liam@networkimprov.net>
Subject: [RFC v2 0/5] bq27xxx_battery data memory update
Date: Sun,  6 Aug 2017 23:22:11 -0700
Message-ID: <20170807062216.19988-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38848 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdHGGXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 02:23:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id h75so8129787pfh.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Aug 2017 23:23:03 -0700 (PDT)
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

 drivers/power/supply/bq27xxx_battery.c     | 477 +++++++++++++++--------------
 drivers/power/supply/bq27xxx_battery_i2c.c |  16 +-
 include/linux/power/bq27xxx_battery.h      |  10 +-
 3 files changed, 267 insertions(+), 236 deletions(-)

-- 
2.13.2
