From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH 0/4] Qualcomm Switch-Mode Battery Charger and Boost
Date: Thu, 18 Jun 2015 14:13:41 -0700
Message-ID: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:16171 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752417AbbFRVNx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 17:13:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Gilad Avidov <gavidov@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, agross@codeaurora.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sagar Dharia <sdharia@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This series adds bindings and a device driver for the Qualcomm Switch-Mode
Battery Charger and Boost block found in pm8941.

Bjorn Andersson (4):
  spmi: pmic-arb: add irq_get_irqchip_state implementation
  dt-binding: power: Add Qualcomm SMBB binding
  power: Add Qualcomm SMBB driver
  ARM: dts: qcom-pm8941: Add charger node

 .../devicetree/bindings/power_supply/qcom_smbb.txt | 137 +++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  21 +
 drivers/power/Kconfig                              |  12 +
 drivers/power/Makefile                             |   1 +
 drivers/power/qcom_smbb.c                          | 952 +++++++++++++++++++++
 drivers/spmi/spmi-pmic-arb.c                       |  17 +
 6 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
 create mode 100644 drivers/power/qcom_smbb.c

-- 
1.8.2.2

