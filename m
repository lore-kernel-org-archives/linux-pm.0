From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v3 0/7] power: supply: tps65217: Support USB charger feature
Date: Sun, 18 Dec 2016 11:54:25 +0900
Message-ID: <20161218025432.20780-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35221 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759425AbcLRCyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 21:54:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

TPS65217 device supports two charger inputs - AC and USB.
Currently, only AC charger is supported. This patch-set adds USB charger 
feature. Tested on Beaglebone black.

Patch 1: Preceding step of the main patch
Patch 2: Main patch
Patch 3 ~ 7: Naming changes for generic power supply class structure

v3:
  Reorder the patches to avoid bisection issue

v2:
  Regenerate the patchset for better code review

Milo Kim (7):
  power: supply: tps65217: Use 'poll_task' on unloading the module
  power: supply: tps65217: Support USB charger interrupt
  power: supply: tps65217: Use generic name for charger online
  power: supply: tps65217: Use generic name for power supply structure
  power: supply: tps65217: Use generic name for power supply property
  power: supply: tps65217: Use generic name for get_property()
  power: supply: tps65217: Use generic charger name

 drivers/power/supply/tps65217_charger.c | 99 ++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 46 deletions(-)

-- 
2.11.0

