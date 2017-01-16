From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 1/4] PM / devfreq: Fix the wrong description for userspace
 governor
Date: Mon, 16 Jan 2017 21:26:04 +0900
Message-ID: <1484569567-29810-2-git-send-email-cw00.choi@samsung.com>
References: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116122609epcas5p3268841ebbf85523a32297bba7b6c321f@epcas5p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45024 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdAPM0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 07:26:12 -0500
In-reply-to: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org

This patch fixes the wrong description of governor_userspace.c
and removes the unneeded blank line.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_userspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 9db4d6f2006a..176976068bcd 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/devfreq/governor_simpleondemand.c
+ *  linux/drivers/devfreq/governor_userspace.c
  *
  *  Copyright (C) 2011 Samsung Electronics
  *	MyungJoo Ham <myungjoo.ham@samsung.com>
@@ -50,7 +50,6 @@ static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
 	unsigned long wanted;
 	int err = 0;
 
-
 	mutex_lock(&devfreq->lock);
 	data = devfreq->data;
 
-- 
1.9.1

