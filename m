From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 0/8] power_supply: Add API for safe access of get_property-like
 function attrs
Date: Tue, 14 Oct 2014 14:20:38 +0200
Message-ID: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:14505 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbaJNMVD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Oct 2014 08:21:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,


After fixing issue with referencing old power supply after driver
unbind in charger manager [1] I noticed that the race condition in such
case may still exist. It would be harder to trigger but still possible.

The race is between using a reference to power supply (obtained
with power_supply_get_by_name()) and removing the driver.

This patchset aims to fix the race by introducing wrappers for
accessing the power supply function attributes.

Patch 1 introduces new API. Other patches replace direct calls in
drivers.

Rebased on next-20141007.
Tested on Trats2 board (max77693 + charger manager).


Kindly asking for reviewing/testing the drivers, although the changes
are straightforward.


Best regards,
Krzysztof


[1] https://lkml.org/lkml/2014/10/13/272



Krzysztof Kozlowski (8):
  power_supply: Add API for safe access of power supply function attrs
  power_supply: sysfs: Use power_supply_*() API for accessing function
    attrs
  power: 88pm860x_charger: Use power_supply_*() API for accessing
    function attrs
  power: ab8500: Use power_supply_*() API for accessing function attrs
  mfd: ab8500: Use power_supply_*() API for accessing function attrs
  power: apm_power: Use power_supply_*() API for accessing function
    attrs
  power: bq2415x_charger: Use power_supply_*() API for accessing
    function attrs
  power: charger-manager: Use power_supply_*() API for accessing
    function attrs

 drivers/mfd/ab8500-sysctrl.c       |  7 +++--
 drivers/power/88pm860x_charger.c   | 13 +++++----
 drivers/power/ab8500_btemp.c       |  2 +-
 drivers/power/ab8500_charger.c     |  2 +-
 drivers/power/ab8500_fg.c          |  2 +-
 drivers/power/abx500_chargalg.c    |  4 +--
 drivers/power/apm_power.c          |  4 +--
 drivers/power/bq2415x_charger.c    |  3 +-
 drivers/power/charger-manager.c    | 37 +++++++++++++------------
 drivers/power/power_supply_core.c  | 57 ++++++++++++++++++++++++++++++++++++--
 drivers/power/power_supply_sysfs.c |  6 ++--
 include/linux/power_supply.h       | 16 +++++++++++
 12 files changed, 115 insertions(+), 38 deletions(-)

-- 
1.9.1

