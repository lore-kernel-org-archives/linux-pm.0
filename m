From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch]  PM / hibernate: memory corruption in resumedelay_setup()
Date: Wed, 14 May 2014 15:57:20 +0300
Message-ID: <20140514125720.GC14571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabian Frederick <fabf@skynet.be>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"resume_delay" is not an unsigned long, it's an int, so this will
corrupt memory on 64 bit systems.

Fixes: 317cf7e5e85e ('PM / hibernate: convert simple_strtoul to kstrtoul')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2377ff7..3659b26 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1115,8 +1115,9 @@ static int __init resumewait_setup(char *str)
 
 static int __init resumedelay_setup(char *str)
 {
-	int rc = kstrtoul(str, 0, (unsigned long *)&resume_delay);
+	int rc;
 
+	rc = kstrtoint(str, 0, &resume_delay);
 	if (rc)
 		return rc;
 	return 1;
