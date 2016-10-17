From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/2] power: supply: Fix module autoload for some platform drivers
Date: Mon, 17 Oct 2016 16:13:34 -0300
Message-ID: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37315
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934666AbcJQTNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 15:13:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Hello Sebastian,

I noticed that module autoload won't be working for some of the power
supply platform drivers. This patch series contains fixes for these.

Best regards,
Javier


Javier Martinez Canillas (2):
  power: supply: max8997_charger: Fix module autoload
  power: supply: axp288_fuel_gauge: Fix module autoload

 drivers/power/supply/axp288_fuel_gauge.c | 1 +
 drivers/power/supply/max8997_charger.c   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.7.4

