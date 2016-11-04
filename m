From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v2 1/2] cpufreq: add new attribute type cpufreq_freq_attr_wr_perm()
Date: Fri,  4 Nov 2016 09:55:35 -0700
Message-ID: <20161104165536.20088-2-code@mmayer.net>
References: <20161104165536.20088-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:51418 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbcKDQ4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2016 12:56:07 -0400
In-Reply-To: <20161104165536.20088-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

From: Markus Mayer <mmayer@broadcom.com>

With the new attribute type, it is possible to create write-only
CPUfreq attributes.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 include/linux/cpufreq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 5fa55fc..ed09930 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -234,6 +234,10 @@ __ATTR(_name, _perm, show_##_name, NULL)
 static struct freq_attr _name =			\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
+#define cpufreq_freq_attr_wr_perm(_name, _perm)	\
+static struct freq_attr _name =			\
+__ATTR(_name, _perm, NULL, store_##_name)
+
 struct global_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *kobj,
-- 
2.7.4

