From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH V3 0/1] power: sbs-battery: Use gpio_desc and sleeping calls for battery detect
Date: Wed, 31 Aug 2016 17:35:30 +0800
Message-ID: <1472636131-82477-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:38826 "EHLO
        preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759422AbcHaJgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 05:36:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, preid@electromag.com.au, linux-pm@vger.kernel.org

Update for: [PATCH v2 4/4] power: sbs-battery: Use gpio_desc and sleeping calls for battery detect
Patches 1-3 of the seris have already been applied.

Changes from V2:
- add the correct gpiod include: <include/linux/gpio/consumer.h>
- rebase on power-supply's next branch
- remove battery_detect and battery_detect_present from the
  struct sbs_platform_data and always use the gpiod API.
- Ensure pdata is always valid and remove pdata null checks.

Changes from V1:
- Fix sbs_of_populate_pdata params for non OF builds.
- Fix title of summary message.


Phil Reid (1):
  power: sbs-battery: Use gpio_desc and sleeping calls for battery
    detect

 drivers/power/supply/sbs-battery.c | 129 ++++++++++++++-----------------------
 include/linux/power/sbs-battery.h  |   6 +-
 2 files changed, 51 insertions(+), 84 deletions(-)

-- 
1.8.3.1

