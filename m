From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 0/5] power: supply: tps65217: Support USB charger feature
Date: Tue, 15 Nov 2016 22:18:50 +0900
Message-ID: <20161115131855.4175-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

TPS65217 device supports two charger inputs - AC and USB.
Currently, only AC charger is supported. This patch-set adds USB charger 
feature. Tested on Beaglebone black.

Milo Kim (5):
  power: supply: tps65217: Move IRQ related operation into single
    function
  power: supply: tps65217: Remove IRQ data from driver data
  power: supply: tps65217: Support USB charger interrupt
  power: supply: tps65217: Use generic name for charger online
  power: supply: tps65217: Use generic name for power supply structures

 drivers/power/supply/tps65217_charger.c | 133 ++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 60 deletions(-)

-- 
2.9.3
