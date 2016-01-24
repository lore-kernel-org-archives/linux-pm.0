From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111241] New: one need root credentials to read cpuinfo_cur_freq
 content
Date: Sun, 24 Jan 2016 09:16:21 +0000
Message-ID: <bug-111241-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47606 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbcAXJQY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 Jan 2016 04:16:24 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 811BD203A4
	for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 09:16:22 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 823D92039E
	for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 09:16:21 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111241

            Bug ID: 111241
           Summary: one need root credentials to read cpuinfo_cur_freq
                    content
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.4.0-994-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: flux242@gmail.com
        Regression: No

could somebody explain why do I need root credentials to read cpuinfo_cur_freq
file? Why other files in the same directory have 444 and not 400 as the
cpuinfo_cur_freq? What so special about the current cpu freq readings?  

$ lso /sys/devices/system/cpu/cpu?/cpufreq/cpuinfo*
 400 -r-------- 1 root 4.0K Jan 24 09:30
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
 444 -r--r--r-- 1 root 4.0K Jan 24 09:37
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
 444 -r--r--r-- 1 root 4.0K Jan 24 09:37
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
 444 -r--r--r-- 1 root 4.0K Jan 24 09:37
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency
 400 -r-------- 1 root 4.0K Jan 24 09:53
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq
 444 -r--r--r-- 1 root 4.0K Jan 24 09:53
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq
 444 -r--r--r-- 1 root 4.0K Jan 24 09:53
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq
 444 -r--r--r-- 1 root 4.0K Jan 24 09:53
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency

-- 
You are receiving this mail because:
You are the assignee for the bug.
