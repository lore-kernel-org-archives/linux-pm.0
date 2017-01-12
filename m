From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Few bq24190-charger fixes and improvments
Date: Wed, 11 Jan 2017 16:41:48 -0800
Message-ID: <20170112004154.31568-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56374 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935564AbdALAmC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Jan 2017 19:42:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org

Hi Sebastian,

Here are some bq24190 fixes. The first four are fixes from Liam Breck
that all can wait for the merge window.

The last two patches improve PM runtime for the driver.

Regards,

Tony

Liam Breck (4):
  power: bq24190_charger: Call enable_irq() only at the end of probe()
  power: bq24190_charger: Fix irq triggering to IRQF_TRIGGER_FALLING
  power: bq24190_charger: Call power_supply_changed() only for relevant
    component
  power: bq24190_charger: Don't read fault register outside
    irq_handle_thread()

Tony Lindgren (2):
  power: bq24190_charger: Check the interrupt status on resume
  power: bq24190_charger: Use PM runtime autosuspend

 drivers/power/supply/bq24190_charger.c | 309 ++++++++++++++++++++-------------
 1 file changed, 190 insertions(+), 119 deletions(-)

-- 
2.11.0
