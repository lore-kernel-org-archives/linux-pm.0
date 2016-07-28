From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH v2 0/7] power: act8945a_charger: Improvements
Date: Thu, 28 Jul 2016 09:36:35 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641018CCCBFB3@penmbx01>
References: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:22401 "EHLO
	ussmtp01.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752782AbcG1Jia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 05:38:30 -0400
In-Reply-To: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hello everyone

Do you have any comments for this patch set?

Best Regards,
Wenyou Yang
________________________________________
From: Wenyou Yang [wenyou.yang@atmel.com]
Sent: Tuesday, June 28, 2016 9:22
To: Sebastian Reichel; Dmitry Eremin-Solenikov; David Woodhouse; Rob Herring; Pawel Moll; Mark Brown; Ian Campbell; Kumar Gala
Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Ferre, Nicolas; linux-pm@vger.kernel.org; Yang, Wenyou
Subject: [PATCH v2 0/7] power: act8945a_charger: Improvements

This patch series is used to improve the act8945a-charger, such as
improve the way to check the status, fix the power supply type
property, add the status change update, and add more properties:
capacity level property and max current property.

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
 drivers/power/act8945a_charger.c                   | 371 ++++++++++++++++++---
 2 files changed, 337 insertions(+), 40 deletions(-)

--
2.7.4

