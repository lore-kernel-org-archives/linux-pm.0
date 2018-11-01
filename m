From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 0/7] ARM: qcom: msm8974-hammerhead: add USB OTG support
Date: Wed, 31 Oct 2018 20:11:42 -0400
Message-ID: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

This patch set adds USB OTG support for the LG Nexus 5 (hammerhead)
phone.

Changes in v2:
- Reworked patches to use gpio hogging as suggested in the bq24190
  device tree documentation.
- bq24190_charger: changed to use a switch instead of an if as requested
  by Sebastian Reichel.
- bq24190_charger dt-bindings: added usb-otg-vbus to example.


Brian Masney (5):
  dt-bindings: power: supply: bq24190_charger: add bq24192 and
    usb-otg-vbus
  power: supply: bq24190_charger: add extcon support for USB OTG
  pinctrl: qcom: spmi-gpio: fix gpio-hog related boot issues
  ARM: dts: qcom: msm8974: add gpio-ranges
  ARM: dts: qcom: msm8974-hammerhead: add USB OTG support

Jonathan Marek (2):
  power: supply: bq24190_charger: add support for bq24192 variant
  power: supply: bq24190_charger: add of_match for usb-otg-vbus
    regulator

 .../bindings/power/supply/bq24190.txt         |  9 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 60 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 arch/arm/boot/dts/qcom-pm8941.dtsi            |  1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      | 21 +++++--
 drivers/power/supply/bq24190_charger.c        | 48 ++++++++++++++-
 6 files changed, 143 insertions(+), 7 deletions(-)

-- 
2.17.2
