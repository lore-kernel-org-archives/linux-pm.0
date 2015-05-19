From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC/RFT 0/2] power_supply: Fix NULL pointer dereference from uevent
Date: Tue, 19 May 2015 14:26:01 +0900
Message-ID: <1432013163-20713-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:9663 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbESF0O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 01:26:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,


This is an idea to fix issue in bq27x00 driver (and probably in others)
reported by H. Nikolaus Schaller [0].

The fixes are marked RFC/RFT because:
1. I do not have bq27x00-like device. I confirmed this and tested on
   modified drivers (max77693, ACPI AC). These drivers are not
   impacted by the issue but one can easily adjust them to reproduce
   the problem.
2. The first uevent coming from power_supply_register() is now
   different because it won't contain device properties. I am
   not sure how this impacts userspace.

Comments are welcomed.


[0] https://lkml.org/lkml/2015/5/18/152


Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  power_supply: Fix NULL pointer dereference during bq27x00_battery
    probe
  power_supply: Fix possible NULL pointer dereference on early uevent

 drivers/power/power_supply_core.c | 59 +++++++++++++++++++++++++++++++++++----
 include/linux/power_supply.h      |  1 +
 2 files changed, 54 insertions(+), 6 deletions(-)

-- 
1.9.1

