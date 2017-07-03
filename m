From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v8 0/2] More fixes for twl4030 charger
Date: Mon,  3 Jul 2017 18:37:09 +0200
Message-ID: <cover.1499099830.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:17782 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbdGCQh1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 12:37:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org

Changes V78:
* further fix for wrong notifier initialization sequence (suggested by Sebastian Reichel)

2017-06-19 10:41:47: Changes V7:
* removed already merged patches from patch set
* further fix for potentially wrong irq and notifier initialization sequence (suggested by Sebastian Reichel)
* NULLify transceiver pointer in case of errors (suggested by Sebastian Reichel)

2017-06-14 11:25:59: Changes V6:
* split up -EPROBE_DEFER and irq allocation patch into small steps:
	* convert iio to devm allocation (by Sebsatian Reichel)
	* fix potentially wrong initialization sequence (by Grygorii Strashko)
	* add -EPROBE_DEFER

2017-05-21 12:38:24: Changes V5:
* reworked max_current removal patch (comments by Sebastian Reichel)
* resubmit missing madc connection for AC power detection
* resubmit patch for irq allocation and -EPROBE_DEFER
* rebased on 4.12-rc1

Changes V4:
* resent commit (original one did contain material not upstream)

2017-04-14 21:29:39: 2017-04-14 20:26:00: Changes V3:
* worked in comments by Sebsatian Reichel
* clarifications of some commit messages
* rebased on v4.11rc-6

It took a while (18 months) until we propose an updated patch for upstream...

2015-11-02 12:27:39: Changes V2:
* worked in comments by Nishanth Menon <nm@ti.com>
* added another patch which solves a probing/boot stall problem (irq allocation vs. -EPROBE_DEFER)

V1:
4.3-rc1 introduced a new charger driver for the twl4030. This patch set fixes some
issues.

While making twl4030 changes from 4.3 operable we have found some issues
during testing on GTA04 and OpenPandora.

H. Nikolaus Schaller (2):
  power: supply: twl4030-charger: move irq allocation to just before
    irqs are enabled
  power: supply: twl4030-charger: add deferred probing for phy and iio

 drivers/power/supply/twl4030_charger.c | 43 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

-- 
2.12.2
