From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v4 0/3] gpio-charger: add devicetree support
Date: Tue, 23 Sep 2014 22:42:13 +0200
Message-ID: <1411504936-21026-1-git-send-email-heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dianders@chromium.org, heiko@sntech.de
List-Id: linux-pm@vger.kernel.org

This series adds devicetree support to the gpio-charger and fixes a small
issue with the return value of gpio_get_value.

changes since v3:
- remove of_match_ptr. All used of_xx function have stubs for !OF
  and of_device_id also is always defined, so no need for of_match_ptr
changes since v2:
- fix (hopefully all) issues pointed out by Doug Anderson
- add missing of_node assignment to charger
changes since v1:
- adapt binding example to show how the charger fits into the
  power-supplies structure


Heiko Stuebner (3):
  dt-bindings: document gpio-charger bindings
  power: gpio-charger: add device tree support
  power: gpio-charger: do not use gpio value directly

 .../bindings/power_supply/gpio-charger.txt         | 27 ++++++++
 drivers/power/gpio-charger.c                       | 74 +++++++++++++++++++++-
 2 files changed, 98 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/gpio-charger.txt

-- 
2.1.0
