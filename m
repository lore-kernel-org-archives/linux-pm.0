Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA3BC10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D420821
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7TAC0rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbfDRQgx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:36:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43215 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbfDRQgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 12:36:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id c20so1501063qkc.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a4flE1Snm9NDtdmfa5RXIPZIzqhs/RZiuwFIMMjBb4o=;
        b=T7TAC0rVVkABFFK/rtvge7oestHcQfoM6jt8p9aVRqtGUGd/HFpUcHEhYPFYYEWs2F
         HhNcEOyncPgkM8Fm0bl7uX1T9siznf6Wk5+hykinG+l4v63DA4QocSGUr/7j7fiT8pQC
         pRXwxKawGLeVOGYUI439y+WrYPr2tc07KC3HPQGzMze6MIXiPH0DTte19EVl31dsQS2f
         c1MchNsLuenpN9jNyS7KOZ+vxxBX0tN2uSbndIfW5ApI9f+CQN5KaEa6mw5/XwS6Hz+Z
         p78mqR8/eBWJrUitbrIyHGiNDrnpCvw3hXlzb+xaMGdqqydQonOg17ObMxgwejmA9j+J
         LR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a4flE1Snm9NDtdmfa5RXIPZIzqhs/RZiuwFIMMjBb4o=;
        b=E6INE6uaaF48jOlZrGk1+P166UYiL6M0h7qCwJNX9inviYTCh76pMXQvOS3NNujRVO
         MbIvWK5tFY/koXnIh3VHKnwb5DERiw+b4cnSeTG3n71f+Er3T1X5I0SvC/PS9h4Ia2Nm
         dxHY+2OIWSKXWMCMJtr/BAXrKrbqaeR4cwWdvqjwFV2Lj3gnEIkfKQjfADVm6Lby9DTE
         QOh1F7PimVCm8kreKiCCb9B0qYHKp5ON1TKCEhnnxp8DLDDZmAUhWQuUYqy5/VRlHNoY
         hfWcYK808RxQjBi3eqTfMzBwkL0f/40Knq1OwrQH0mW3WzIMfqM6HqWznn2eEmOWGCBQ
         /3Gw==
X-Gm-Message-State: APjAAAUiYn1qYzLuUBokDnq/AAyx+GUXnEj+WTJJzCCEq3QMDJ/FlNDp
        ya7OL+vh842d1Ua9uDH+UTfJqXdnyD48qA==
X-Google-Smtp-Source: APXvYqxL2SHqf6ynz2UeGMwisvlFtN9O0KjOPKLECVDCj6iT2G0if93hyby/+zt/GejogDyJxdyNIw==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr75126187qkj.6.1555605411823;
        Thu, 18 Apr 2019 09:36:51 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id t2sm1355325qkd.57.2019.04.18.09.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:36:50 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, edubezval@gmail.com,
        rui.zhang@intel.com,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH] thermal: make device_register's type argument const
Date:   Thu, 18 Apr 2019 12:36:39 -0400
Message-Id: <20190418163639.17271-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

...because it can be, the buffer is strlcpy'd into a local buffer in a
thermal struct member.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/thermal/thermal_core.c | 6 +++---
 include/linux/thermal.h        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..b708b66fef94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -941,7 +941,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
  */
 static struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
-				  char *type, void *devdata,
+				  const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
@@ -1015,7 +1015,7 @@ __thermal_cooling_device_register(struct device_node *np,
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	return __thermal_cooling_device_register(NULL, type, devdata, ops);
@@ -1039,7 +1039,7 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
  */
 struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
-				   char *type, void *devdata,
+				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
 	return __thermal_cooling_device_register(np, type, devdata, ops);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..42ddaafe7705 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -442,10 +442,10 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 void thermal_zone_set_trips(struct thermal_zone_device *);
 
-struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
-		const struct thermal_cooling_device_ops *);
+struct thermal_cooling_device *thermal_cooling_device_register(const char *,
+		void *, const struct thermal_cooling_device_ops *);
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, char *, void *,
+thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
-- 
2.11.0

