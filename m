From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 8/8] PM / devfreq: Fix the wrong description for userspace
 governor
Date: Wed, 28 Dec 2016 20:56:52 +0900
Message-ID: <1482926212-19223-9-git-send-email-cw00.choi@samsung.com>
References: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228115654epcas1p1ac0c112753ca3dd694f604b84239bd18@epcas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47434 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbcL1L46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 06:56:58 -0500
In-reply-to: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

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

