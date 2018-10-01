From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH RFC 0/5] treewide: add USB OTG support for hammerhead
Date: Mon,  1 Oct 2018 01:30:00 -0400
Message-ID: <20181001053005.18906-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org

This patch set adds USB OTG support for the LG Nexus 5 (hammerhead)
phone. My only question is related to patch #4 where the GPIO support
is added to bq24190_charger. Based on the information in the device tree
binding Documentation/devicetree/bindings/power/supply/bq24190.txt, I
should be using a gpio-hog. I'm not sure what my input pin would be for
this particular board since I can't find a publicly-available datasheet
for this board.

The USB OTG support works properly with this patch set. I am able to use
USB networking, and I'm also able to plug in a USB hub with a thumb
drive on the phone, and mount the drive.

All of the other msm8974-based boards in upstream use the
qcom,pm8941-charger (via the smbb node) that is defined in
qcom-pm8941.dtsi. USB networking works for me with that driver, however
I'm not able to get any devices connected to my USB hub to show up on
the phone, even when I port the GPIO code into that driver. I can see
the USB hub node with lsusb, but no devices on the hub.

Thanks in advance for any assistance that you can provide.

Brian Masney (1):
  dt-bindings: power: supply: bq24190_charger: add bq24192 and
    usb-otg-vbus

Jonathan Marek (4):
  power: supply: bq24190_charger: add support for bq24192 variant
  power: supply: bq24190_charger: add of_match for usb-otg-vbus
    regulator
  power: supply: bq24190_charger: add support for extcon and GPIO for
    USB OTG support
  ARM: dts: qcom: msm8974-hammerhead: add USB OTG support

 .../bindings/power/supply/bq24190.txt         |  7 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 54 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 drivers/power/supply/bq24190_charger.c        | 51 +++++++++++++++++-
 4 files changed, 121 insertions(+), 2 deletions(-)

-- 
2.17.1
