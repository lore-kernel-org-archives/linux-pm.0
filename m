From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/3] power: bq27xxx: Fix multiple defined but not used warnings
Date: Fri, 16 Oct 2015 15:44:09 +0200
Message-ID: <1445003052-31373-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:34711 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbbJPNov (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 09:44:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

These patches fix multiple "defined but not used" warnings
in the bq27xxx driver.

-- Sebastian

Sebastian Reichel (3):
  power: bq27xxx_battery: fix platform probe
  power: bq27xxx_battery: move irq handler to i2c section
  power: bq27xxx_battery: fix defined but not used warnings

 drivers/power/bq27xxx_battery.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.6.1

