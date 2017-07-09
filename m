From: Liam Breck <liam@networkimprov.net>
Subject: [RFC v1 0/6] bq27xxx_battery data memory update
Date: Sat,  8 Jul 2017 19:16:54 -0700
Message-ID: <20170709021700.14354-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36248 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGICRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 22:17:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so9736676pfk.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Jul 2017 19:17:37 -0700 (PDT)
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
* Supports the following chips (only BQ27425 is active without #define DEBUG)
  BQ27500, 545, 425, 421, 441, 621

Notes on v1:
* Not fully tested (hence RFC tag)


Liam Breck (6):
  power: supply: bq27xxx: Create single chip data table
  power: supply: bq27xxx: Add chip IDs for previously shadowed chips
  power: supply: bq27xxx: Enable data memory update for certain chips
  power: supply: bq27xxx: Add chip data options for cfgupdate & ram-only
  power: supply: bq27xxx: Flag identical chip data when in debug mode
  power: supply: bq27xxx: Remove duplicate chip data arrays

 drivers/power/supply/bq27xxx_battery.c     | 421 ++++++++++++++++-------------
 drivers/power/supply/bq27xxx_battery_i2c.c |  16 +-
 include/linux/power/bq27xxx_battery.h      |  10 +-
 3 files changed, 245 insertions(+), 202 deletions(-)

-- 
2.13.1
