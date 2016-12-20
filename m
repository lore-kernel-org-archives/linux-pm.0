From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/3] power: supply: bq24735: handle AC adapter absence
Date: Tue, 20 Dec 2016 12:32:59 +0100
Message-ID: <1482233582-29770-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve1eur01on0124.outbound.protection.outlook.com ([104.47.1.124]:38144
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752210AbcLTSIT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Dec 2016 13:08:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org

Hi!

There is provision in the driver for handling the case where the
chargers are not responding to i2c requests when the AC adapter
is absent. I think this has been used by some Tegra boards that
leave the charger handling to some other component and that only
wants the kernel to be aware of the charging status for reporting
(or whatever).

However, in my case, the kernel should handle configuration and
enable/disable the charging, but this is not working very well
when the charger disappears (and is reset) on AC adapter absence.

This series fixes the issues I have found in this area so that I
can boot without AC adapter and have the correct charging config
every time I do attach the AC adapter.

Cheers,
Peter

Peter Rosin (3):
  power: supply: bq24735: move down bq24735_{en,dis}able_charging
  power: supply: bq24735: configure the charger as part of enabling it
  power: supply: bq24735: always check for AC adapter presence in probe

 drivers/power/supply/bq24735-charger.c | 56 ++++++++++++++++------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

-- 
2.1.4

