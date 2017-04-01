From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 0/4] BQ24190 charger fixes
Date: Sat,  1 Apr 2017 13:25:15 -0700
Message-ID: <20170401202519.16280-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34805 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdDAUZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 16:25:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so22955596pga.1
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2017 13:25:21 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>

Hi Sebastian,

Here in one patchset are two patches I posted recently, and two more:

Patch 1 is a replacement (as agreed) for
 "power: supply: bq24190_charger: Don't spam the logs on charger plug / unplug"

Patch 2 fixes up Hans' extcon patch. If you would like me to squash it with his
initial extcon patch, let me know. In future please wait for my ack to merge
charger patches, so I do not have to mend others' code.

Patch 3 (repost) fixes some issues with PM runtime error handling.

Patch 4 fixes a nit in register_reset().

Thanks for your help,
Liam

Liam Breck (4):
  power: bq24190_charger: Limit over/under voltage fault logging
  power: bq24190_charger: Clean up extcon code
  power: bq24190_charger: Uniform pm_runtime_get() failure handling
  power: bq24190_charger: Delay before polling reset flag

 drivers/power/supply/bq24190_charger.c | 127 ++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 64 deletions(-)

-- 
2.9.3
