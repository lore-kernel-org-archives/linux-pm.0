From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 0/4] power: max17042_battery: Update max17042 fuelgauge driver
Date: Thu, 05 Jun 2014 12:46:13 +0900
Message-ID: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49756 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaFEDq0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jun 2014 23:46:26 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O00HW6FTBGD50@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 05 Jun 2014 12:46:23 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patch updates max17042 fuelgauge driver for proper working with optimized
code.

Jonghwa Lee (3):
  power: max17042_battery: Specifies operation mode of max17042
    fuelgauge
  power: max17042_battery: Use devm_* function for requesting irq
  power: max17042_battery: Refactoring max17042 driver

Tomasz Figa (1):
  power: max17042_battery: Fix deadlock caused by deferred     
    initialization

 .../bindings/power_supply/max17042_battery.txt     |    3 +
 drivers/power/max17042_battery.c                   |  463 ++++++--------------
 include/linux/power/max17042_battery.h             |    7 +-
 3 files changed, 152 insertions(+), 321 deletions(-)

-- 
1.7.9.5

