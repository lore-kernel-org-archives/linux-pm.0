From: Tim Bird <tim.bird@sonymobile.com>
Subject: [PATCH v3 0/3] ARM: power: qcom_smbb: Add otg regulator
Date: Wed, 9 Dec 2015 04:45:52 -0800
Message-ID: <1449665155-29322-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org
Cc: Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com, tim.bird@sonymobile.com
List-Id: linux-pm@vger.kernel.org

Add a regulator to control the OTG chargepath switch.

I'm re-sending this (v3) because my v2 submission yesterday failed
to include the AUTHOR OF THE DRIVER(!!), Courtney Cavin.

Changes since v2
 - add the driver author to the To: list!

Changes since v1
 - switch supply name to have dashes instead of underscores
 - remove superfluous DT explanations in the otg node description

Tim Bird (3):
  dt-binding: power: Add otg regulator binding
  power: qcom_smbb: Add otg regulator for control of vbus
  ARM: dts: qcom: add charger otg regulator

 .../devicetree/bindings/power_supply/qcom_smbb.txt | 19 ++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  4 ++
 drivers/power/qcom_smbb.c                          | 74 ++++++++++++++++++++++
 3 files changed, 97 insertions(+)

-- 
2.6.3
