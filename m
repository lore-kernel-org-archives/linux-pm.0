From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH v3] power: Add warning message about incorrect system date and time after resume when pm_trace is enabled
Date: Wed, 26 Jun 2013 16:27:35 -0600
Message-ID: <1372285655-2450-1-git-send-email-shuah.kh@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:54418 "EHLO
	qmta05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753234Ab3FZW1k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 18:27:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

pm_trace uses the system's Real Time Clock (RTC) to save the magic number.
Reason for this is that the RTC is the only reliably available piece of
hardware during resume operations where a value can be set that will
survive a reboot.

Consequence is that after a resume (even if it is successful) your system
clock will have a value corresponding to the magic number instead of the
correct date/time! It is therefore advisable to use a program like ntp-date
or rdate to reset the correct date/time from an external time source when
using this trace option.

There is no run-time message to warn users of the consequences of enabling
pm_trace. Adding a warning message to pm_trace_store() will serve as a
reminder to users to set the system date and time after resume.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 kernel/power/main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index d77663b..480fe06 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -528,6 +528,10 @@ pm_trace_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	if (sscanf(buf, "%d", &val) == 1) {
 		pm_trace_enabled = !!val;
+		if (pm_trace_enabled) {
+			pr_warn("PM: Enabling pm_trace changes system date and time during resume.\n"
+				"PM: Correct system time has to be restored manually after resume.\n");
+		}
 		return n;
 	}
 	return -EINVAL;
-- 
1.7.10.4

