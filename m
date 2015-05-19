From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC/RFT v2 0/2] power_supply: Fix NULL pointer dereference from uevent
Date: Tue, 19 May 2015 16:13:00 +0900
Message-ID: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,


Changes since v1:
=================
1. Patch 2: fix invalid member used for container_of().
2. Patch 2: Replace WARN with pr_warn() in __power_supply_register()
   if parent is missing.


Description:
============
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

 drivers/power/power_supply_core.c | 61 +++++++++++++++++++++++++++++++++++----
 include/linux/power_supply.h      |  1 +
 2 files changed, 56 insertions(+), 6 deletions(-)

-- 
1.9.1
