From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 0/3] fuelgauge: max17042: Update max17042/7 fuelgauge driver.
Date: Wed, 18 Dec 2013 12:53:51 +0900
Message-ID: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61645 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab3LRDyA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 22:54:00 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ006W3HHY1U40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 12:53:58 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>

Jonghwa Lee (3):
  fuelgauge: max17042: Do code cleaning to follow kernel code
    convention.
  fuelgauge: max17042: Add IRQF_ONESHOT flag to use default irq
    handler.
  fuelgauge: max17042: Seperate available property set for different
    operation.

 .../bindings/power_supply/max17042_battery.txt     |    3 +
 drivers/power/max17042_battery.c                   |  327 +++++++++++---------
 include/linux/power/max17042_battery.h             |  159 ++++++----
 3 files changed, 271 insertions(+), 218 deletions(-)

-- 
1.7.9.5

