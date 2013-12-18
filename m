From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH v3 0/2] Update charger manager driver to support device tree
Date: Wed, 18 Dec 2013 11:14:11 +0900
Message-ID: <1387332853-5923-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42297 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab3LRCOW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 21:14:22 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ00IHYCVXCSA0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 11:14:21 +0900 (KST)
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

Changes in V3 :
[ 1 / 2 ]
	- Fix typo
	- Refactoring codes
[ 2 / 2 ]
	- Add ommited description to documentation

Changes in V2 :
[ 1 / 2 ]
	- Use generic thermal framework interface to get battery temperature.
	- Move initialization codes of thermal data to probe() function.
	- Remove .temperature_out_of_range() callback function.
[ 2 / 2 ]
	- Remove DT node 'cm-battery-has-therm'

Jonghwa Lee (2):
  charger-manager : Modify the way of checking battery's temperature.
  charger-manager : Support deivce tree in charger manager driver

 .../bindings/power_supply/charger-manager.txt      |   81 ++++++
 drivers/power/charger-manager.c                    |  305 +++++++++++++++++---
 include/linux/power/charger-manager.h              |   34 ++-
 3 files changed, 363 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/charger-manager.txt

-- 
1.7.9.5

