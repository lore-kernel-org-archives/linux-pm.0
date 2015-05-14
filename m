From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: [PATCH 0/2] Adds cpu power accounting per-pid basis.
Date: Thu, 14 May 2015 16:55:46 -0700
Message-ID: <1431647748-13221-1-git-send-email-kandoiruchi@google.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35241 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423087AbbENX4G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:56:06 -0400
Received: by igbyr2 with SMTP id yr2so182361947igb.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2015 16:56:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kandoiruchi@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

These patches add a mechanism which will accurately caculate the CPU power
used by all the processes in the system. In order to account for the power
used by all the processes a data field "cpu_power" has been added in the
task_struct. This field adds power for both the system as well as user
time. cpu_power contains the total amount of charge(in uAmsec units) used
by the process. This model takes into account the frequency at which the
process was running(i.e higher power for processes running at higher
frequencies). It requires the cpufreq_stats module to be initialized with
the current numbers for each of the CPU core at each frequency. This will
be initialized during init time.

Ruchi Kandoi (2):
  cpufreq_stats: Adds sysfs file    
    /sys/devices/system/cpu/cpufreq/current_in_state
  sched: cpufreq: Adds a field cpu_power in the task_struct

 drivers/cpufreq/cpufreq_stats.c | 186 +++++++++++++++++++++++++++++++++++++++-
 include/linux/cpufreq.h         |   8 ++
 include/linux/sched.h           |   2 +
 kernel/fork.c                   |   1 +
 kernel/sched/cputime.c          |   7 ++
 5 files changed, 202 insertions(+), 2 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

