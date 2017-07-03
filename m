From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] PM / devfreq: constify attribute_group structures.
Date: Mon,  3 Jul 2017 15:40:04 +0530
Message-ID: <a4e33dd6c72dac67a227e896044b2ee3c1f8825a.1499076508.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36112 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdGCKKS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 06:10:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    621	    176	      0	    797	    31d	drivers/devfreq/governor_userspace.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   670	    144	      0	    814	    32e	drivers/devfreq/governor_userspace.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/devfreq/governor_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 1769760..77028c2 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -86,7 +86,7 @@ static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
 	&dev_attr_set_freq.attr,
 	NULL,
 };
-static struct attribute_group dev_attr_group = {
+static const struct attribute_group dev_attr_group = {
 	.name	= "userspace",
 	.attrs	= dev_entries,
 };
-- 
1.9.1
