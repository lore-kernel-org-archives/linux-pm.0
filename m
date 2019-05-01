From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v5 0/3] Driver for UCS1002
Date: Tue, 30 Apr 2019 20:34:31 -0700
Message-ID: <20190501033434.18548-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Everyone:

This small series adds a driver for UCS1002 Programmable USB Port
Power Controller with Charger Emulation. See [page] for product page
and [datasheet] for device dataseet. Hopefully each individual patch
is self explanatory.

Note that this series is a revival of the upstreaming effort by Enric
Balletbo Serra last version of which can be found at [original-effort]

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v4]:

    - Chagned "interrupts-extended" -> "interrupts" in DT bindings description

    - Collected Reviewed-by from Rob

Changes since [v3]:

    - Added a check for negative values to ucs1002_set_usb_type()

Changes since [v2]:

    - Fixed a bug pointed out by Lucas

Changes since [v1]:

    - Moved IRQ trigger specification to DT

    - Fixed silent error paths in probe()
    
    - Dropped error message in ucs1002_set_max_current()

    - Fixed license mismatch

    - Changed the driver to configure the chip to BC1.2 CDP by default

    - Made other small fixes as per feedback for v1

[v4] https://lore.kernel.org/lkml/20190430064557.28469-1-andrew.smirnov@gmail.com
[v3] https://lore.kernel.org/lkml/20190429195349.20335-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/lkml/20190429054741.7286-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/lkml/20190417084457.28747-1-andrew.smirnov@gmail.com/
[page] https://www.microchip.com/wwwproducts/en/UCS1002-2
[datasheet] https://ww1.microchip.com/downloads/en/DeviceDoc/UCS1002-2%20Data%20Sheet.pdf
[original-effort] https://lore.kernel.org/lkml/1460705181-10493-1-git-send-email-enric.balletbo@collabora.com/

Andrey Smirnov (3):
  power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
  power: supply: Add driver for Microchip UCS1002
  dt-bindings: power: supply: Add bindings for Microchip UCS1002

 .../power/supply/microchip,ucs1002.txt        |  27 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/power_supply_sysfs.c     |   2 +-
 drivers/power/supply/ucs1002_power.c          | 646 ++++++++++++++++++
 include/linux/power_supply.h                  |   1 +
 6 files changed, 685 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 drivers/power/supply/ucs1002_power.c

-- 
2.20.1
