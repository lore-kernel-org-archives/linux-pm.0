From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH V7] Report interrupt that caused system wakeup
Date: Thu, 10 Sep 2015 16:36:00 +0900
Message-ID: <20150910073600.GB587@swordfish>
References: <1441853301-3816-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34978 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbbIJHfS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 03:35:18 -0400
Received: by pacfv12 with SMTP id fv12so35936177pac.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2015 00:35:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441853301-3816-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: tglx@linutronix.de, Alexandra Yates <alexandra.yates@linux.intel.com>, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On (09/09/15 19:48), Alexandra Yates wrote:

[..]
> +static ssize_t pm_last_wakeup_irq_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t n)
> +{
> +	return -EINVAL;
> +}
> +power_attr(pm_last_wakeup_irq);

a side note,
do you guys want to define a power_attr_ro() macro and to drop 'return -EINVAL'
*_show() functions: pm_trace_dev_match_store() and pm_last_wakeup_irq_store()?

---

 kernel/power/main.c  | 9 +--------
 kernel/power/power.h | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 63d395b..0217a5c 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -548,14 +548,7 @@ static ssize_t pm_trace_dev_match_show(struct kobject *kobj,
 	return show_trace_dev_match(buf, PAGE_SIZE);
 }
 
-static ssize_t
-pm_trace_dev_match_store(struct kobject *kobj, struct kobj_attribute *attr,
-			 const char *buf, size_t n)
-{
-	return -EINVAL;
-}
-
-power_attr(pm_trace_dev_match);
+power_attr_ro(pm_trace_dev_match);
 
 #endif /* CONFIG_PM_TRACE */
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index caadb56..efe1b3b 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -77,6 +77,15 @@ static struct kobj_attribute _name##_attr = {	\
 	.store	= _name##_store,		\
 }
 
+#define power_attr_ro(_name) \
+static struct kobj_attribute _name##_attr = {	\
+	.attr	= {				\
+		.name = __stringify(_name),	\
+		.mode = S_IRUGO,		\
+	},					\
+	.show	= _name##_show,			\
+}
+
 /* Preferred image size in bytes (default 500 MB) */
 extern unsigned long image_size;
 /* Size of memory reserved for drivers (default SPARE_PAGES x PAGE_SIZE) */
