From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 00/11] power: supply: bq275xx: implement individual chip revision support
Date: Fri, 23 Dec 2016 11:04:56 +1100
Message-ID: <1482451507-37676-1-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36399 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941997AbcLWAFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 19:05:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so12994384pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Dec 2016 16:05:13 -0800 (PST)
In-Reply-To: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This patch series separates out support for each revision chip in
the bq27500, bq27510 and bq27520 family. Each revision has enough
register address changes to justify individual register mappings.

It also cleans up the large if statement checking the overtemp flags.

I had a chance to test the deprecated bq27500/10/20 support which still
behaves the same. I also tested the new specific bq27510g3 support
on a custom board I have here and it worked correctly.

Chris Lapa (11):
  power: supplies: bq275xx: rename BQ27500 allow for deprecation in
    future.
  power: supplies: bq275xx: adds specific support for bq27500/1
    revision.
  power: supplies: bq275xx: adds specific support for bq27510-g1
    revision.
  power: supplies: bq275xx: adds specific support for bq27510-g2
    revision.
  power: supplies: bq275xx: adds specific support for bq27510-g3
    revision.
  power: supplies: bq275xx: adds specific support for bq27520-g1
    revision.
  power: supplies: bq275xx: adds specific support for bq27520-g2
    revision.
  power: supplies: bq275xx: adds specific support for bq27520-g3
    revision.
  power: supplies: bq275xx: adds specific support for bq27520-g4
    revision.
  power: supply: bq275xx: cleanup over temperature flag check.
  power: supplies: bq275xx: adds device tree binding documentation.

 .../devicetree/bindings/power/supply/bq275xx.txt   |  27 ++
 drivers/power/supply/bq27xxx_battery.c             | 340 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  22 +-
 include/linux/power/bq27xxx_battery.h              |  10 +-
 4 files changed, 393 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq275xx.txt

-- 
2.1.4

