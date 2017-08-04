From: gsantosh@codeaurora.org
Subject: [PATCH] devfreq: replace sscanf with kstrtol
Date: Fri, 04 Aug 2017 09:53:30 +0530
Message-ID: <76b99c5399941998bf19e51795c404eb@codeaurora.org>
References: <a74af8cd71537efd19c5b7154d34ec65@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdHDEXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2017 00:23:31 -0400
In-Reply-To: <a74af8cd71537efd19c5b7154d34ec65@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, gsantosh@qti.qualcomm.com

Hi,

Adding error checks to devfreq userspace governor, the current 
implementation results in setting wrong
frequency when sscanf returns error.


 From 12e0a347addd70529b2c378299b27b65f0766f99 Mon Sep 17 00:00:00 2001
 From: Santosh Mardi <gsantosh@codeaurora.org>
Date: Tue, 25 Jul 2017 18:47:11 +0530
Subject: [PATCH] devfreq: replace sscanf with kstrtol

store_freq function of devfreq userspace governor
executes further, even if error is returned from sscanf,
this will result in setting up wrong frequency value.

The usage for the sscanf is only for single variable so
replace sscanf with kstrtol along with error check to
bail out if any error is returned.

Signed-off-by: Santosh Mardi <gsantosh@codeaurora.org>
---
  drivers/devfreq/governor_userspace.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c 
b/drivers/devfreq/governor_userspace.c
index 77028c2..a84796d 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -53,12 +53,15 @@ static ssize_t store_freq(struct device *dev, struct 
device_attribute *attr,
      mutex_lock(&devfreq->lock);
      data = devfreq->data;

-    sscanf(buf, "%lu", &wanted);
+    err = kstrtol(buf, 0, &wanted);
+    if (err < 0)
+        goto out;
      data->user_frequency = wanted;
      data->valid = true;
      err = update_devfreq(devfreq);
      if (err == 0)
          err = count;
+out:
      mutex_unlock(&devfreq->lock);
      return err;
  }
-- 

Regards,
Santosh M G.
Qualcomm Innovation Center
