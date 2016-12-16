From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] PM / devfreq: Fix the wrong description for userspace governor
Date: Fri, 16 Dec 2016 14:44:38 +0900
Message-ID: <1481867078-4016-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40705 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbcLPFz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2016 00:55:57 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch fixes the wrong description of governor_userspace.c
and removes the unneeded blank line.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_userspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 35de6e83c1fe..c794352c6163 100644
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

