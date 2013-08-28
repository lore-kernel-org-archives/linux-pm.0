From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH v2 RFT 1/2] PM / Hibernate: use name_to_dev_t to parse resume
Date: Tue, 27 Aug 2013 18:13:56 -0700
Message-ID: <1377652437-2379-2-git-send-email-sebastian.capella@linaro.org>
References: <1377652437-2379-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377652437-2379-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@lists.infradead.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org
Cc: Sebastian Capella <sebastian.capella@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Use the name_to_dev_t call to parse the device name echo'd to
to /sys/power/resume.  This imitates the method used in hibernate.c
in software_resume, and allows the resume partition to be specified
using other equivalent device formats as well.  By allowing
/sys/debug/resume to accept the same syntax as the resume=device
parameter, we can parse the resume=device in the init script and
use the resume device directly from the kernel command line.

Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/power/hibernate.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b26f5f1..8ba8719 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -971,15 +971,23 @@ static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			    const char *buf, size_t n)
 {
-	unsigned int maj, min;
 	dev_t res;
 	int ret = -EINVAL;
+	int len = n;
+	char *devcpy;
 
-	if (sscanf(buf, "%u:%u", &maj, &min) != 2)
-		goto out;
+	if (buf[len-1] == '\n')
+		len--;
+
+	devcpy = kstrndup(buf, len, GFP_KERNEL);
+
+	if (devcpy == NULL)
+		return -ENOMEM;
+
+	res = name_to_dev_t(devcpy);
+	kfree(devcpy);
 
-	res = MKDEV(maj,min);
-	if (maj != MAJOR(res) || min != MINOR(res))
+	if (res == 0)
 		goto out;
 
 	lock_system_sleep();
-- 
1.7.9.5
