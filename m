From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 3/3] doc: cpufreq: tests: Provide cpufreq tests README
Date: Mon, 26 Jan 2015 11:41:24 +0100
Message-ID: <1422268884-26173-3-git-send-email-l.majewski@samsung.com>
References: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43667 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbbAZKmX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 05:42:23 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIS005SS5QLL960@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 26 Jan 2015 19:42:21 +0900 (KST)
In-reply-to: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, a.nitecki@samsung.com, Lukasz Majewski <l.majewski@samsung.com>

This commit adds README to ./tools/testing/cpufreq directory.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 tools/testing/cpufreq/README | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/cpufreq/README

diff --git a/tools/testing/cpufreq/README b/tools/testing/cpufreq/README
new file mode 100644
index 0000000..c934016
--- /dev/null
+++ b/tools/testing/cpufreq/README
@@ -0,0 +1,53 @@
+This file contains list of cpufreq's available regression tests with a short
+usage description.
+
+1. cpufreq_freq_test.sh
+
+Description:
+------------
+This script is supposed to test if cpufreq attributes exported by sysfs are
+exposing correct values.
+
+To achieve this goal it saves the current governor and changes it to
+"performance". Afterwards, it reads the "scaling_available_frequencies"
+property. With the list of supported frequencies it is able to enforce each of
+them by writing to "scaling_max_freq" attribute. To make the test more reliable
+a superfluous load with gzip is created to be sure that we are running with
+highest possible frequency. This high load is regulated with the 'sleep'
+duration. After this time the "cpufreq_cur_freq" is read and compared with the
+original value. As the last step the original governor is restored.
+
+This script can work with or without BOOST enabled and helps in spotting errors
+related to cpufreq and common clock framework.
+
+Used attributes:
+----------------
+- "scaling_available_frequencies"
+- "cpuinfo_cur_freq"
+- "scaling_governor"
+- "scaling_max_freq"
+
+Target devices:
+---------------
+
+All devices which exports mentioned above sysfs attributes.
+
+2. governors_switch.sh
+
+Description:
+------------
+This script is supposed to test if all governors are available and possible to
+set.
+
+Moreover, it allows to test if cpufreq is able to withstand multiple accesses to
+the same sysfs attribute without crash.
+
+Used attributes:
+----------------
+- "scaling_available_governors"
+- "scaling_governor"
+
+Target devices:
+---------------
+
+All devices which exports mentioned above sysfs attributes.
-- 
2.0.0.rc2

