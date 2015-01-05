From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC PATCHv2 00/19] power_supply: Allow safe usage of power supply
Date: Mon, 05 Jan 2015 16:47:43 +0100
Message-ID: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,


This is RFC, please don't apply yet but let me know if this approach
is OK.


TLDR
====
Patchset tries to fix following race scenario:

Thread 1: charger manager, CONSUMER
Thread 2: power supply driver, PROVIDER

THREAD 1 (charger manager)         THREAD 2 (power supply driver)
==========================         ==============================
psy = power_supply_get_by_name()
                                   Driver unbind, .remove
                                     power_supply_unregister()
                                     Device fully removed
psy->get_property()

To properly fix the race the patchset:
1. Adds power_supply_get_property()-like API for safe access by consumer.
2. Moves ownership of power_supply structure from driver (provider) to
   power supply core.
3. Adds power_supply_put() which will reclaim memory.


Description
=========== 
This is a little different than my previous approaches [1][2] for fixing
usage of power supply by some consumer, if driver implementing it is
unbound.

The patchset is quite big and touches power supply API so a lot of
changes in drivers are needed. These changes *are not finished yet*.
I've done them only for:
 - bq24190_charger.c
 - charger-manager.c
 - max14577_charger.c
 - max17040_battery.c
 - max17042_battery.c
 - sbs-battery.c
 - tps65090-charger.c
So allyesconfig won't build.

If this approach is OK, I'll prepare full patchset changing all the
drivers.

My previous approach [1][2] limited the race but did not close it.
Still the consumer of power supply by calling power_supply_get_propert(psy...)
may reference invalid memory because the producer freed it.

Actually, because struct power_supply is exposed to consumers, the
core should be the owner of it. This is accomplished in patch 11/19
("power_supply: Change ownership from driver to core").


What the patchset does in steps
===============================
1. Some preparation steps are necessary - patch 1 and 2. The driver
   implementing power supply won't be able to fill structure before
   calling power_supply_register(). So 'power_supply_config'
   is introduced in patch 2 ("power_supply: Move run-time configuration
   to separate structure"). Unfortunately this touches all drivers.
2. Safe API wrappers (and usage counter) are added (power_supply_*()).
3. Patch 11: ownership of 'struct power_supply' is moved from driver
   to the core.
4. power_supply_put() is added which reclaims resources.


The patchset is rebased on next-20141226. It should be pulled at once.
Bisectability is preserved.

Changes since v1
================
1. Add new patches (1, 2, 11, 19).
2. Preserved ack-s where there weren't any changes.
3. Patch 3: Add use counter.
4. Patch 3: Don't add wrapper for set_charged() because already exists
   one.


[1] https://lkml.org/lkml/2014/11/4/527
[2] https://lkml.org/lkml/2014/10/16/89

Best regards,
Krzysztof


Krzysztof Kozlowski (19):
  power_supply: Add driver private data
  power_supply: Move run-time configuration to separate structure
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
  power_supply: Change ownership from driver to core
  power_supply: Add power_supply_put for decrementing device reference
    counter
  power: charger-manager: Decrement the power supply's device reference
    counter
  x86/olpc/xo1/sci: Use newly added power_supply_put API
  x86/olpc/xo15/sci: Use newly added power_supply_put API
  power: 88pm860x_charger: Decrement the power supply's device reference
    counter
  power: bq2415x_charger: Decrement the power supply's device reference
    counter
  mfd: ab8500: Decrement the power supply's device reference counter
  arm: mach-pxa: Decrement the power supply's device reference counter

 arch/arm/mach-pxa/raumfeld.c           |   4 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c  |   4 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c |   4 +-
 drivers/acpi/battery.c                 |   3 +-
 drivers/mfd/ab8500-sysctrl.c           |   9 +-
 drivers/power/88pm860x_charger.c       |  24 ++--
 drivers/power/ab8500_btemp.c           |   2 +-
 drivers/power/ab8500_charger.c         |   2 +-
 drivers/power/ab8500_fg.c              |   2 +-
 drivers/power/abx500_chargalg.c        |   4 +-
 drivers/power/apm_power.c              |   4 +-
 drivers/power/bq2415x_charger.c        |   9 +-
 drivers/power/bq24190_charger.c        | 103 ++++++++-------
 drivers/power/charger-manager.c        | 158 +++++++++++++----------
 drivers/power/max14577_charger.c       |  34 ++---
 drivers/power/max17040_battery.c       |  31 ++---
 drivers/power/max17042_battery.c       |  45 ++++---
 drivers/power/power_supply_core.c      | 223 ++++++++++++++++++++++++---------
 drivers/power/power_supply_leds.c      |  25 ++--
 drivers/power/power_supply_sysfs.c     |  24 ++--
 drivers/power/sbs-battery.c            |  71 +++++------
 drivers/power/tps65090-charger.c       |  43 ++++---
 include/linux/power/charger-manager.h  |   3 +-
 include/linux/power_supply.h           |  70 ++++++++---
 24 files changed, 562 insertions(+), 339 deletions(-)

-- 
1.9.1

