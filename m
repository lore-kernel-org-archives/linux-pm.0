From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/2] two fixes for new bq27000/10 and bq27500 driver
Date: Thu, 17 Dec 2015 11:12:52 +0100
Message-ID: <cover.1450347172.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:46472 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbbLQKNE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 05:13:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>



H. Nikolaus Schaller (2):
  power:bq27xxx: fix reading for bq27000 and bq27010
  power:bq27xxx: fix register numbers of bq27500

 drivers/power/bq27xxx_battery.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.5.1

