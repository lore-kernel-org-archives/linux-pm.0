From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 115261] New: CPU Frequency scaling jumps and stucks at max freq
Date: Sat, 26 Mar 2016 09:05:55 +0000
Message-ID: <bug-115261-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47522 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbcCZJF6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Mar 2016 05:05:58 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 50FC1202AE
	for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2016 09:05:57 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 81BFE20279
	for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2016 09:05:56 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=115261

            Bug ID: 115261
           Summary: CPU Frequency scaling jumps and stucks at max freq
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.5
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: timo.valtoaho@gmail.com
        Regression: Yes

Created attachment 210711
  --> https://bugzilla.kernel.org/attachment.cgi?id=210711&action=edit
config of bisected kernel

Switching to 4.5 kernel, cpufreq ondemand governor started to act oddly.
Without any load, with freshly booted system, it pumped cpu frequency up to
maximum at some point of time and stayed there. uptime can be anything, but
usually less than 15 minutes when this happens. Driver is acpi-cpufreq.

I have git-bisected this to 0df35026c6a527e65b53bc895ad672d648a248f3. There is
a mention about certain kernel config values that are ok. My values differ and
I get this kind of behaviour.

CPU is AMD Phenom(tm) II X4 905e Processor.

-- 
You are receiving this mail because:
You are the assignee for the bug.
