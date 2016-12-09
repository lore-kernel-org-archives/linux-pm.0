From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 0/8] power: supply: tps65217: Support USB charger feature
Date: Fri,  9 Dec 2016 16:48:58 +0900
Message-ID: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33464 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcLIHtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2016 02:49:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

TPS65217 device supports two charger inputs - AC and USB.
Currently, only AC charger is supported. This patch-set adds USB charger 
feature. Tested on Beaglebone black.

Patch 1: Main patch
Patch 2, 3: Clean up for charger driver data
Patch 4 ~ 8: Naming changes for generic power supply class structure

v2:
  Regenerate the patchset for better code review

Milo Kim (8):
  power: supply: tps65217: Support USB charger interrupt
  power: supply: tps65217: Use 'poll_task' on unloading the module
  power: supply: tps65217: Remove IRQ data from driver data
  power: supply: tps65217: Use generic name for charger online
  power: supply: tps65217: Use generic name for power supply structure
  power: supply: tps65217: Use generic name for power supply property
  power: supply: tps65217: Use generic name for get_property()
  power: supply: tps65217: Use generic charger name

 drivers/power/supply/tps65217_charger.c | 99 ++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 46 deletions(-)

-- 
2.9.3

