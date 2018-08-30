From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/6] shutdown procedure verification for SAMA5D2
Date: Thu, 30 Aug 2018 14:50:05 +0300
Message-ID: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux@armlinux.org.uk, sre@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Patch 1 from this series implement a fix for shutdown procedure
for SAMA5D2.

The rest of the patch are improvements as follows:
patch 2 - use only one function for poweroff
patches 3-6 - cosmetic improvements

The patches are based on latest sys-reset/for-next [1].

Thank you,
Claudiu Beznea

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git

Claudiu Beznea (6):
  power: reset: at91-poweroff: switch to slow clock before shutdown
  power: reset: at91-poweroff: use only one poweroff function
  power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
  power: reset: at91-poweroff: make sclk part of struct shdwc
  power: reset: at91-poweroff: rename at91_shdwc_base member of struct
    shdwc
  power: reset: at91-poweroff: do not procede if at91_shdwc is allocated

 arch/arm/mach-at91/pm_suspend.S          |   8 +++
 drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----------
 2 files changed, 88 insertions(+), 39 deletions(-)

-- 
2.7.4
