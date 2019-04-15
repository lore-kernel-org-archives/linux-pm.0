From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 0/4] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date: Sun, 14 Apr 2019 22:26:31 -0300
Message-ID: <20190415012635.6369-1-matheus@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

This series add IRQ handler for low level SOC alert, define a devicetree 
binding attribute to configure the alert level threshold and check for
changes in SOC for send uevents.

Max17040 have a pin for alert host about low level state of charge and
this alert can be configured in a threshold from 1% up to 32% of SOC.

Tested on Toradex Colibri iMX7D, with a SparkFun Lipo Fuel Gauge module
based on MAXIM MAX17043.

Thanks Krzysztof Kozlowski for your time reviewing it, and forgive me for
the delay in working on it, now I'm back to the patchs. Let me know what
you think about the fixes and I'm open to maintainers suggestions.

Changes since v1:
(Suggested by Krzysztof Kozlowski)
- Put common code from max17040_work and max17040_thread_handler in a function
- Code style fixes
- Define mask and low level threshold alert default
- Check return value from max17040_set_soc_threshold
- Set low level state of charge threshold before IRQ
- CC maintainers from drivers/mfd/max14577
- Use flags from FDT client->flags instead hard coded it
- Mention interrupts on DT Documentation
- Fix "maxim,max77836-battery" missed from DT Documentation
- Fix commit description

Matheus Castello (4):
  power: supply: max17040: Add IRQ handler for low SOC alert
  dt-bindings: power: supply: Max17040: Add low level SOC alert
    threshold
  power: supply: max17040: Config alert SOC low level threshold from FDT
  power: supply: max17040: Send uevent in SOC changes

 .../power/supply/max17040_battery.txt         |  24 ++++
 drivers/power/supply/max17040_battery.c       | 118 +++++++++++++++++-
 2 files changed, 138 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

-- 
2.17.0
