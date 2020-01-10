Return-Path: <SRS0=bbN6=27=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C99C33CA2
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7820842
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="p5pYZN/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgAJKQf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:16:35 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47584 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727240AbgAJKQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AADCs2031451;
        Fri, 10 Jan 2020 11:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Hldl398s+nOsQdaXOAH6nd6BIu7pyZ6GdjoQzcUnb9A=;
 b=p5pYZN/WKAF6KKnv7UYIix4OmJOWjfMgBObE4Spfn7X55oeAvaQ1iekhxqTOVr3OxuhV
 uUjtiWWqNTMTe0/wFFGa7UC92vymXSWjm5GRklaQwXr5ZzeXnlkEdAHQxVwv8PZE5myo
 ICtjAdAZxPeZ4oTCELMP4HckIz9hZ1bOGjhaNEv0nMGXxv3z010QA1K5fIwmWXknkZN2
 hraEdcqW6m2mIGwF5PeDqnm41Z1ZAVvVUcvHMIaaIZ5b7v2ZbWz6cFdlBroZmGvj9Lzm
 QWODCkBhVMAENM1rI2L9l42MJi97Qh6rpbtEZmAYW1ZdBUq+/DkvdjytnXmD/zZX/Ufg iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xdw8b7kv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D526100034;
        Fri, 10 Jan 2020 11:16:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24F622A7905;
        Fri, 10 Jan 2020 11:16:09 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 11:16:08
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <p.paillet@st.com>, <david.hernandezsanchez@st.com>,
        <horms+renesas@verge.net.au>, <wsa+renesas@sang-engineering.com>,
        <linux-pm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH_V3 1/6] thermal: stm32: fix icifr register name
Date:   Fri, 10 Jan 2020 11:16:00 +0100
Message-ID: <20200110101605.24984-2-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a mistake with the ICIFR register name.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cf9ddc52f30e..7835e109692e 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -30,7 +30,7 @@
 #define DTS_DR_OFFSET		0x1C
 #define DTS_SR_OFFSET		0x20
 #define DTS_ITENR_OFFSET	0x24
-#define DTS_CIFR_OFFSET		0x28
+#define DTS_ICIFR_OFFSET	0x28
 
 /* DTS_CFGR1 register mask definitions */
 #define HSREF_CLK_DIV_MASK	GENMASK(30, 24)
@@ -122,10 +122,10 @@ static irqreturn_t stm_thermal_alarm_irq_thread(int irq, void *sdata)
 	value = readl_relaxed(sensor->base + DTS_SR_OFFSET);
 
 	if ((value & LOW_THRESHOLD) == LOW_THRESHOLD)
-		writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
+		writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
 
 	if ((value & HIGH_THRESHOLD) == HIGH_THRESHOLD)
-		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
+		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
 
 	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
 
@@ -347,7 +347,7 @@ static int stm_enable_irq(struct stm_thermal_sensor *sensor)
 	 */
 
 	/* Make sure LOW_THRESHOLD IT is clear before enabling */
-	writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
+	writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
 
 	/* Enable IT generation for low threshold */
 	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
@@ -356,7 +356,7 @@ static int stm_enable_irq(struct stm_thermal_sensor *sensor)
 	/* Enable the low temperature threshold if needed */
 	if (sensor->low_temp_enabled) {
 		/* Make sure HIGH_THRESHOLD IT is clear before enabling */
-		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
+		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
 
 		/* Enable IT generation for high threshold */
 		value |= HIGH_THRESHOLD;
-- 
2.17.1

