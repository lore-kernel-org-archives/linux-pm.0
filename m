From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.15-rc6
Date: Fri, 29 Dec 2017 14:19:04 +0100
Message-ID: <CAJZ5v0jxZ=0im7X-3kQE83-RjEJd5_NU-oU3A86unw1YGrcUqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34459 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdL2NTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Dec 2017 08:19:05 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.15-rc6

with top-most commit 466a2b42d67644447a1765276259a3ea5531ddff

 cpufreq: schedutil: Use idle_calls counter of the remote CPU

on top of commit

 Linux 4.15-rc5

to receive a power management fix for 4.15-rc6.

This fixes a schedutil cpufreq governor regression from the 4.14
cycle that may cause a CPU idleness check to return incorrect results
in some cases which leads to suboptimal decisions (Joel Fernandes).

Thanks!


---------------

Joel Fernandes (1):
      cpufreq: schedutil: Use idle_calls counter of the remote CPU

---------------

 include/linux/tick.h             |  1 +
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/time/tick-sched.c         | 13 +++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)
