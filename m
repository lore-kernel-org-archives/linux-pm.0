From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 0/3] power: max17042-battery: Modify max17042 battery driver
Date: Tue, 31 Mar 2015 22:34:04 +0900
Message-ID: <1427808847-19498-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34616 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbCaNeJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 09:34:09 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM200F1AWCVFD20@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 31 Mar 2015 22:34:07 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Beomho Seo <beomho.seo@samsung.com>

This patch modify max17042-battery.c fuel gauge driver for use max77693 and
max77843 fuel gauge. and then, fix minor cording style issue.

This patchset is written based on recently battery git tree.

Beomho Seo (3):
  power: max17042_battery: Use reg type instead of chip type
  power: max17042_battery: Add support for max77693/843 chip
  power: max17042_battery: add missed blank

 drivers/power/Kconfig                  |    6 +--
 drivers/power/max17042_battery.c       |   65 ++++++++++++++++++++------------
 include/linux/power/max17042_battery.h |   19 +++++++++-
 3 files changed, 62 insertions(+), 28 deletions(-)

-- 
1.7.9.5

