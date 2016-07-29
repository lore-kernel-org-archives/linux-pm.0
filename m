From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v3 0/7] power: act8945a_charger: Improvements
Date: Fri, 29 Jul 2016 09:25:21 +0800
Message-ID: <1469755528-8413-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:17668 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcG2BhW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 21:37:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch series is used to improve the act8945a-charger, such as
improve the way to check the status, fix the power supply type
property, add the status change update, and add more properties:
capacity level property and max current property.

Changes in v3:
 - Remove unneeded semicolon to fix semicolon.cocci warning.

Changes in v2:
 - Add missing ret declaration.

Wenyou Yang (7):
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: act8945a-charger: Update properties

 .../devicetree/bindings/power/act8945a-charger.txt |   6 +-
 drivers/power/act8945a_charger.c                   | 369 ++++++++++++++++++---
 2 files changed, 336 insertions(+), 39 deletions(-)

-- 
2.7.4

