Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933ACC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4055864E4B
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 20:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBRUob (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:44:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhBRUm2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:42:28 -0500
Date:   Thu, 18 Feb 2021 20:39:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXe4Puvm1SzVNXmDJ2TMQ3Upxr+oT47T0QIA9wskgp8=;
        b=qMYxmi5OiXqxivg/W9Emc9LKKYNUTxCMm3Pz3eQL914wVn0zuu4m2/fs1tZETkuxgfqKBm
        vq3opIywn3I7kUfQMNxWP8xjeOp3sI4bR1bnQTWZW7HdvFKolPnAXGkohmDuwaJjlCXR6X
        FBnejwdYCFeXLBJEelFXuLKNiyrXDhhu4xj7xvNGiUW9ktszmngW+geUEDvRarWO3gDD2T
        fCJ6iuWG8NFoaYrDs2a3fa6bnIpoaqJzlMjlhtQ4JaIopEP7QM8aBxeR0f0uOt4XAsl0+J
        iZ5YXH7DjGn0Glfjswve4uYbNp1o9z84NpYY3elIYY536Kir4OwrRkFYa41pKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXe4Puvm1SzVNXmDJ2TMQ3Upxr+oT47T0QIA9wskgp8=;
        b=wilMxjPsao2BpQSPhw1dQxxbF06BlUuGx83kgJGoQVMk7eAdvzZdbu/+eQ9w99zWMNUhg+
        7MSZvw1jmvRA/EBA==
From:   "thermal-bot for Craig Tatlor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] fixp-arith: add a linear interpolation function
Cc:     Craig Tatlor <ctatlor97@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-3-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078553.20312.6637382819010915923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8d502ef682fdbe0ddf2274dae903b07baf1140e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8d502ef682fdbe0ddf2274dae903b07baf1140e0
Author:        Craig Tatlor <ctatlor97@gmail.com>
AuthorDate:    Fri, 04 Dec 2020 05:54:56 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:14:53 

fixp-arith: add a linear interpolation function

Adds a function to interpolate against two points,
this is carried arount as a helper function by tons of drivers.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-3-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/fixp-arith.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index 8396013..281cb4f 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -141,4 +141,23 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
 #define fixp_cos32_rad(rad, twopi)	\
 	fixp_sin32_rad(rad + twopi / 4, twopi)
 
+/**
+ * fixp_linear_interpolate() - interpolates a value from two known points
+ *
+ * @x0: x value of point 0
+ * @y0: y value of point 0
+ * @x1: x value of point 1
+ * @y1: y value of point 1
+ * @x: the linear interpolant
+ */
+static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
+{
+	if (y0 == y1 || x == x0)
+		return y0;
+	if (x1 == x0 || x == x1)
+		return y1;
+
+	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
+}
+
 #endif
