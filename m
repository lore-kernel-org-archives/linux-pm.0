From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2]  PM / hibernate: memory corruption in resumedelay_setup()
Date: Wed, 14 May 2014 19:08:46 +0300
Message-ID: <20140514160845.GA5273@mwanda>
References: <20140514155602.GA9723@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42110 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaENQJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 12:09:13 -0400
Content-Disposition: inline
In-Reply-To: <20140514155602.GA9723@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

In the original code "resume_delay" is an int so on 64 bits, the call to
kstrtoul() will cause memory corruption.  We may as well fix a style
issue here as well and make "resume_delay" unsigned int, since that's
what we pass to ssleep().

Fixes: 317cf7e5e85e ('PM / hibernate: convert simple_strtoul to kstrtoul')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: style differences

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2377ff7..df88d55 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -35,7 +35,7 @@
 static int nocompress;
 static int noresume;
 static int resume_wait;
-static int resume_delay;
+static unsigned int resume_delay;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
@@ -1115,7 +1115,7 @@ static int __init resumewait_setup(char *str)
 
 static int __init resumedelay_setup(char *str)
 {
-	int rc = kstrtoul(str, 0, (unsigned long *)&resume_delay);
+	int rc = kstrtouint(str, 0, &resume_delay);
 
 	if (rc)
 		return rc;
