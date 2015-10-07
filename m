From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/4] Fix minor bq27x00 displeasures
Date: Wed,  7 Oct 2015 20:42:35 +0200
Message-ID: <cover.1444243358.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:52385 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbJGSmu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:42:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

1. bq27x00 driver may fill the log with messages about missing calibration:
report only in debug mode
2. if bq27x00 is a w1/hdq slave the wrapper should modprobe to load
bq27x00_battery.ko if compiled as a module.

Both patches improve system battery (co)operation on the GTA04.

H. Nikolaus Schaller (3):
  restore bq27000 code of v4.3-rc4
  restore w1 slave bq27000 code of v4.3-rc4
  w1:slaves:bq27000: load battery driver kernel module if required

NeilBrown (1):
  power:bq27x00: don't fill system log by missing battery


-- 
2.5.1

