From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 153221] New: failing to set governor with
 cpupower-frequency-set
Date: Tue, 16 Aug 2016 14:34:21 +0000
Message-ID: <bug-153221-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43374 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbcHPOeY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Aug 2016 10:34:24 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BBC35201C8
	for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2016 14:34:22 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id B8906201C0
	for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2016 14:34:21 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=153221

            Bug ID: 153221
           Summary: failing to set governor with cpupower-frequency-set
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.7.0-1-ARCH
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: foudil.newbie+linux@gmail.com
        Regression: No

Created attachment 229121
  --> https://bugzilla.kernel.org/attachment.cgi?id=229121&action=edit
cpupower-frequency-set patch

cpupower frequency-set -g performance

has no effect.
I think this is due to a bug introduced by ac5a181d065d74fb:

@@ -298,3 +298,3 @@ int cmd_freq_set(int argc, char **argv)
                        if (!bitmask_isbitset(cpus_chosen, cpu) ||
-                           cpufreq_cpu_exists(cpu))
+                           cpupower_is_cpu_online(cpu))
                                continue;
@@ -318,6 +318,6 @@ int cmd_freq_set(int argc, char **argv)
                if (!bitmask_isbitset(cpus_chosen, cpu) ||
-                   cpufreq_cpu_exists(cpu))
+                   cpupower_is_cpu_online(cpu))
                        continue;

-               if (sysfs_is_cpu_online(cpu) != 1)
+               if (cpupower_is_cpu_online(cpu) != 1)
                        continue;

The two functions cpufreq_cpu_exists() and sysfs_is_cpu_online() were replaced
by cpupower_is_cpu_online(), which is misused in the first test.

I'm proposing a patch in attachment.

-- 
You are receiving this mail because:
You are the assignee for the bug.
