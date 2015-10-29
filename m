From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/2] Fixes for twl4030 charger
Date: Thu, 29 Oct 2015 18:01:26 +0100
Message-ID: <cover.1446138086.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:34290 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbJ2RBi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2015 13:01:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>

4.3-rc1 introduced new charger driver for the twl4030.

While making it operable and testing on GTA04 and OpenPandora
we have found some issues.


H. Nikolaus Schaller (2):
  drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
  drivers:power:twl4030-charger: don't check if battery is present

 drivers/power/twl4030_charger.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.5.1

