From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH 0/7] power: act8945a_charger: Improvements
Date: Fri, 24 Jun 2016 15:17:33 +0800
Message-ID: <1466752660-2922-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:9720 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcFXH2E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 03:28:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch series is used to improve the act8945a-charger, such as
improve the way to check the status, fix the power supply type
property, add the status change update, and add more properties:
capacity level property and max current property.


Wenyou Yang (7):
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: act8945a-charger: Update properties

 .../devicetree/bindings/power/act8945a-charger.txt |   6 +-
 drivers/power/act8945a_charger.c                   | 371 ++++++++++++++++++---
 2 files changed, 337 insertions(+), 40 deletions(-)

-- 
2.7.4

