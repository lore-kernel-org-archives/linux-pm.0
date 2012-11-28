From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 5/5] cpufreq: dbx500: Update file header
Date: Wed, 28 Nov 2012 11:27:44 +0100
Message-ID: <1354098464-6665-6-git-send-email-ulf.hansson@stericsson.com>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:45048 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753816Ab2K1K2b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Nov 2012 05:28:31 -0500
In-Reply-To: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Lee Jones <lee.jones@linaro.org>

Real simple patch to extend the ST-Ericsson copyright date and
remove unnecessary extra commented lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index d4cb782..047fc4f 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -1,13 +1,13 @@
 /*
  * Copyright (C) STMicroelectronics 2009
- * Copyright (C) ST-Ericsson SA 2010
+ * Copyright (C) ST-Ericsson SA 2010-2012
  *
  * License Terms: GNU General Public License v2
  * Author: Sundar Iyer <sundar.iyer@stericsson.com>
  * Author: Martin Persson <martin.persson@stericsson.com>
  * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- *
  */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/cpufreq.h>
-- 
1.7.10

