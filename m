From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] powernow-k6: support 350MHz cpu
Date: Wed, 9 Jul 2014 17:19:04 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1407091717460.6236@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6232 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaGIVTJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Jul 2014 17:19:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

There exists 350MHz K6-2E+ cpu, so add it to the usual frequency table.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/cpufreq/powernow-k6.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-3.16-rc4/drivers/cpufreq/powernow-k6.c
===================================================================
--- linux-3.16-rc4.orig/drivers/cpufreq/powernow-k6.c	2014-07-09 15:15:29.000000000 +0200
+++ linux-3.16-rc4/drivers/cpufreq/powernow-k6.c	2014-07-09 15:15:44.000000000 +0200
@@ -55,6 +55,7 @@ static const struct {
 	unsigned freq;
 	unsigned mult;
 } usual_frequency_table[] = {
+	{ 350000, 35 },	// 100   * 3.5
 	{ 400000, 40 },	// 100   * 4
 	{ 450000, 45 }, // 100   * 4.5
 	{ 475000, 50 }, //  95   * 5
