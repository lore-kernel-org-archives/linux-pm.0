From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 0/2] Two bq24190 PM improvments
Date: Mon, 30 Jan 2017 16:02:08 -0800
Message-ID: <20170131000210.5442-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:32936 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdAaACR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Jan 2017 19:02:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

Here's a repost of the two bq24190 patches rebased against current
power-supply tree.

Regards,

Tony

Changes from v1:

- Call pm_runtime_dont_use_autosuspend() and pm_runtime_put_sync()
  unconditionally in bq24190_remove() as suggested by Liam

Changes from earlier set:

- Separated from Liam's changes that are now in the power-supply tree

- Moved bdi->initialized before devm_request_threaded_irq() as suggested
  by Liam

  - Added missing return value check for pm_runtime_get() as suggested by
    Liam

    - Updated against current power-supply tree, mostly for the probe error
      handling

Tony Lindgren (2):
  power: bq24190_charger: Check the interrupt status on resume
  power: bq24190_charger: Use PM runtime autosuspend

 drivers/power/supply/bq24190_charger.c | 211 +++++++++++++++++++++++++--------
 1 file changed, 161 insertions(+), 50 deletions(-)

-- 
2.11.0
