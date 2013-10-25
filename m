From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 0/3] Update charger manager driver to support device tree
Date: Fri, 25 Oct 2013 11:47:30 +0900
Message-ID: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32911 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab3JYCrq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2013 22:47:46 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV700DCLEFKZQ60@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 25 Oct 2013 11:47:44 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Until now, charger manager doesn't support DT at all. It only works with
legacy platform data. Therefore, charger_desc structure which is requisite
data for working contains non-friendly variables for DT, as like funtion ptr,
and u64 type data.

These patches modifies charger_desc structure and driver to support device tree
fully. For using device tree in charger manager, you can check example of
charger manager's device tree model in Documentaion directory. 

Currently, there're many required nodes for proper charger manager's
working, we would optimize them later.

Jonghwa Lee (3):
  charger-manager : Replace kzalloc to devm_kzalloc and remove
    uneccessary code.
  charger-manager : Add default battery temperature checking funtion.
  charger-manager : Support deivce tree in charger manager driver

 .../bindings/power_supply/charger-manager.txt      |   82 +++++
 drivers/power/charger-manager.c                    |  315 +++++++++++++++-----
 include/linux/power/charger-manager.h              |   21 +-
 3 files changed, 340 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/charger-manager.txt

-- 
1.7.9.5

