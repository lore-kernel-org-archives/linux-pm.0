From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 0/4] BQ24190 charger fixes
Date: Wed,  5 Apr 2017 20:10:44 -0700
Message-ID: <20170406031048.12401-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34851 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdDFDLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2017 23:11:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so5195116pge.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Apr 2017 20:11:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>

Hi Sebastian,

Here in one patchset are two patches I posted recently, and two more:

Patch 1 is a replacement (as agreed) for
  "power: supply: bq24190_charger: Don't spam the logs on charger plug / unplug"
Patch 2 fixes up Hans' extcon patch. If you would like me to squash it with his
  original patch, let me know.
Patch 3 (repost) fixes some issues with PM runtime error handling.
Patch 4 fixes a nit in register_reset().

Changes in v4:
* fix definition of bq24190_reg_poc_chg_config_*
* revert to if (device_property_read... == 0)

Liam Breck (4):
  power: bq24190_charger: Limit over/under voltage fault logging
  power: bq24190_charger: Clean up extcon code
  power: bq24190_charger: Uniform pm_runtime_get() failure handling
  power: bq24190_charger: Delay before polling reset flag

 drivers/power/supply/bq24190_charger.c | 125 ++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 63 deletions(-)

-- 
2.9.3
