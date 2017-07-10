From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 0/4] power: supply: sbs-battery: Add delay when changing capacity mode
Date: Mon, 10 Jul 2017 14:23:16 +0800
Message-ID: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:47455 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751835AbdGJGX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 02:23:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

This is based on Michael Heinemann's patch:
"sbs-battery: correct capacity mode selection bits"

First two are housing keep / cleanup.
As reported by Michael with his patch he found the mode didn't always change.
I found adding a delay fixed the problem for several Insipered Energy SBS 
compatible batteries I have on hand.

The last patch may need some comment and testing by others.

The SBS spec says that capcaty mode bit:

Changes the return type for the following registers:
  RemainingCapacityAlarm()
  AtRate()
  RemainingCapacity()
  FullChargeCapacity()
  DesignCapacity()

and may affect the following calculations:
  AtRateOK()
  AtRateTimeToEmpty()
  RunTimeToEmpty()
  AverageTimeToEmpty()
  RemainingTimeAlarm()
  BatteryStatus()
  Optional: AtRateTimeToFull()

So far I wasn't able to detect any difference in say the AverageTimeTEmpty(). 
But if we are reseting the bit after the watt reading then perhaps it should 
be reset to the power up value (ie cleared) instead of reset to some other value.

I'm not sure what the best approach is here. 



Phil Reid (4):
  power: supply: sbs-battery: Remove FSF mailing address from comments
  power: supply: sbs-battery: sort includes
  power: supply: sbs-battery: Add delay when changing capacity mode bit
  power: supply: sbs-battery: Don't reset mode in get_battery_capacity

 drivers/power/supply/sbs-battery.c | 55 ++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

-- 
1.8.3.1
