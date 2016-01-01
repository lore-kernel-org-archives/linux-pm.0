From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 6/7] power: generic-adc-battery: use to_delayed_work
Date: Fri,  1 Jan 2016 22:59:11 +0800
Message-ID: <df7d77b9dd91d48533fe9c58466504f724ba9291.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:44700 "EHLO m50-134.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbcAAPAa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Jan 2016 10:00:30 -0500
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Geliang Tang <geliangtang@163.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/power/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/generic-adc-battery.c
index fedc581..edb36bf 100644
--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -206,7 +206,7 @@ static void gab_work(struct work_struct *work)
 	bool is_plugged;
 	int status;
 
-	delayed_work = container_of(work, struct delayed_work, work);
+	delayed_work = to_delayed_work(work);
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	pdata = adc_bat->pdata;
 	status = adc_bat->status;
-- 
2.5.0


