From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 0/6] Renew charger manager driver for optimized operation.
Date: Fri, 12 Sep 2014 20:11:21 +0900
Message-ID: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50891 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbaILLLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:11:32 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBS002HDCF69Y00@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 12 Sep 2014 20:11:30 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Jonghwa Lee (6):
  power: charger-manager: Use alarmtimer for battery monitoring in
    suspend.
  power: charger-manager: Monitoring temperature becomes mandatory
    option.
  power: charger-manager: Remove deprecated function,
    cm_notify_event().
  power: charger-manager: Use power_supply_changed() not private
    uevent.
  power: charger-manager: Fix to use CHARGE_NOW/FULL property
    correctly.
  power: charger-manager: Rearrange data and monitor focusing battery
    status.

 .../bindings/power_supply/charger-manager.txt      |   84 +-
 drivers/power/Kconfig                              |    3 +-
 drivers/power/charger-manager.c                    | 2127 +++++++-------------
 include/linux/power/charger-manager.h              |  308 ++-
 4 files changed, 887 insertions(+), 1635 deletions(-)

-- 
1.7.9.5
