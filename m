From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/4] power: reset: Fix module autoload for some platform drivers
Date: Mon, 17 Oct 2016 15:36:11 -0300
Message-ID: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Sebastian,

I noticed that module autoload won't be working in a some of the reset
platform drivers This patch series contains the fixes for these.

Best regards,
Javier


Javier Martinez Canillas (4):
  power: reset: at91-reset: Fix module autoload
  power: reset: at91-poweroff: Fix module autoload
  power: reset: syscon-reboot-mode: Fix module autoload
  power: reset: zx-reboot: Fix module autoload

 drivers/power/reset/at91-poweroff.c      | 1 +
 drivers/power/reset/at91-reset.c         | 2 ++
 drivers/power/reset/syscon-reboot-mode.c | 1 +
 drivers/power/reset/zx-reboot.c          | 1 +
 4 files changed, 5 insertions(+)

-- 
2.7.4
