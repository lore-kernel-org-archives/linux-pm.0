From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v4 00/10] power: supply: bq27xxx: implement individual chip revision support
Date: Tue, 10 Jan 2017 16:25:28 +1100
Message-ID: <1484025938-114133-1-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34952 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936302AbdAJFZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 00:25:47 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so8123509pfa.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 21:25:46 -0800 (PST)
In-Reply-To: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This patch series renames the patch subject prefix to 'power: supply: bq27xxx'
and also rebases onto sre/linux-power-supply/for-next.

It also drops the overtemp cleanup patch from v3 as it has already been applied.

Otherwise the patch content is the same functionally as the v3 series.

Chris Lapa (10):
  power: supplies: bq27xxx: rename BQ27500 allow for deprecation in
    future.
  power: supplies: bq27xxx: adds specific support for bq27500/1
    revision.
  power: supplies: bq27xxx: adds specific support for bq27510-g1
    revision.
  power: supplies: bq27xxx: adds specific support for bq27510-g2
    revision.
  power: supplies: bq27xxx: adds specific support for bq27510-g3
    revision.
  power: supplies: bq27xxx: adds specific support for bq27520-g1
    revision.
  power: supplies: bq27xxx: adds specific support for bq27520-g2
    revision.
  power: supplies: bq27xxx: adds specific support for bq27520-g3
    revision.
  power: supplies: bq27xxx: adds specific support for bq27520-g4
    revision.
  power: supplies: bq27xxx: adds device tree binding documentation.

 .../devicetree/bindings/power/supply/bq27xxx.txt   |  36 +++
 drivers/power/supply/bq27xxx_battery.c             | 304 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  22 +-
 include/linux/power/bq27xxx_battery.h              |  11 +-
 4 files changed, 363 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt

-- 
2.1.4

