From: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH 0/2] power: supply: add sbs-charger driver
Date: Mon, 21 Nov 2016 19:04:49 +0100
Message-ID: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from host.prodys.net ([89.248.106.65]:55324 "EHLO host.prodys.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753603AbcKUSLy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 13:11:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.saenz@prodys.net

This series adds support for all SBS compatible battery chargers, as defined
here: http://sbs-forum.org/specs/sbc110.pdf.

The first patch changes the sbs-battery device name in order to be able to
create a proper supplier/supplied relation between the two of them.

The second introduces the driver.

Regards,
Nicolas

Nicola Saenz Julienne (2):
  power: supply: sbs-battery: use fixed device name
  power: supply: add sbs-charger driver

 drivers/power/supply/Kconfig       |   6 +
 drivers/power/supply/Makefile      |   1 +
 drivers/power/supply/sbs-battery.c |   6 +-
 drivers/power/supply/sbs-charger.c | 312 +++++++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+), 5 deletions(-)
 create mode 100644 drivers/power/supply/sbs-charger.c

-- 
2.7.4

