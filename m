From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 00/11] power: supply: bq27xxx: implement individual chip revision support
Date: Wed, 11 Jan 2017 12:44:37 +1100
Message-ID: <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36392 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbdAKBoz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 20:44:55 -0500
Received: by mail-pf0-f193.google.com with SMTP id b22so14941820pfd.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 17:44:55 -0800 (PST)
In-Reply-To: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This patch series correctly renames the patch subject prefix to 'power: supply: bq27xxx'.

It also fixes up the deprecation of the BQ27500 and BQ27510 definitions.

Otherwise the patch content is the same functionally as the v4 series.

Chris Lapa (11):
  power: supply: bq27xxx: rename BQ27500 allow for deprecation in
    future.
  power: supply: bq27xxx: rename BQ27510 allow for deprecation in
    future.
  power: supply: bq27xxx: adds specific support for bq27500/1 revision.
  power: supply: bq27xxx: adds specific support for bq27510-g1 revision.
  power: supply: bq27xxx: adds specific support for bq27510-g2 revision.
  power: supply: bq27xxx: adds specific support for bq27510-g3 revision.
  power: supply: bq27xxx: adds specific support for bq27520-g1 revision.
  power: supply: bq27xxx: adds specific support for bq27520-g2 revision.
  power: supply: bq27xxx: adds specific support for bq27520-g3 revision.
  power: supply: bq27xxx: adds specific support for bq27520-g4 revision.
  power: supply: bq27xxx: adds device tree binding documentation.

 .../devicetree/bindings/power/supply/bq27xxx.txt   |  36 +++
 drivers/power/supply/bq27xxx_battery.c             | 343 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  22 +-
 include/linux/power/bq27xxx_battery.h              |  12 +-
 4 files changed, 403 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt

-- 
2.1.4

