From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/3] fuelgauge: max17042: Add IRQF_ONESHOT flag to use default
 irq handler.
Date: Wed, 18 Dec 2013 12:53:53 +0900
Message-ID: <1387338834-4046-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61645 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab3LRDyA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 22:54:00 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ005C9HHYOZ50@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 12:53:58 +0900 (KST)
In-reply-to: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

This patch adds IRQF_ONESHOT flag to max17042's irq since it uses primary
default handler. Without this flag, requesting irq will be denied with returning
error.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/max17042_battery.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index bbb2e01..c611ce7 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -710,9 +710,9 @@ static int max17042_probe(struct i2c_client *client,
 
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq, NULL,
-						max17042_thread_handler,
-						IRQF_TRIGGER_FALLING,
-						chip->battery.name, chip);
+					max17042_thread_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					chip->battery.name, chip);
 		if (!ret) {
 			regmap_read(chip->regmap, MAX17042_CONFIG, &val);
 			val |= CONFIG_ALRT_BIT_ENBL;
-- 
1.7.9.5

