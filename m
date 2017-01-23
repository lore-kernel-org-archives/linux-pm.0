From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 1/4] PM / devfreq: Fix the wrong description for userspace
 governor
Date: Mon, 23 Jan 2017 12:31:36 +0900
Message-ID: <1485142299-9986-2-git-send-email-cw00.choi@samsung.com>
References: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170123033151epcas5p3a484d70bbdef282b92eb8d97d912e75c@epcas5p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
