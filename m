From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] cpufreq: Fix a circular lock dependency problem
Date: Tue, 24 Jul 2018 14:26:03 -0400
Message-ID: <1532456765-17576-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-pm@vger.kernel.org

 v2:
  - Remove the retry loop in the store method.

This patchset works around a circular lock dependency issue in the
cpufreq driver reported by lockdep. The two locks involved are the
cpu_hotplup_lock and the reference count of a sysfs file.

The cpufreq_register_driver() function uses the lock sequence:

  cpus_read_lock --> kn->count

Whereas the cpufreq sysfs store method uses the sequence:

  kn->count --> cpus_read_lock

This is not really an issue as a shared lock is used on the
cpu_hotplup_lock. However, the lockdep code isn't able to handle
shared locking. So one way to work around this is to define a
cpus_read_trylock() function and uses it in the store method instead.

Waiman Long (2):
  cpu/hotplug: Add a cpus_read_trylock() function
  cpufreq: Fix a circular lock dependency problem

 drivers/cpufreq/cpufreq.c | 7 ++++++-
 include/linux/cpu.h       | 2 ++
 kernel/cpu.c              | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.3.1
