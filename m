From: Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cpufreq: Fix a circular lock dependency problem
Date: Mon, 23 Jul 2018 13:49:39 -0400
Message-ID: <1532368179-15263-3-git-send-email-longman@redhat.com>
References: <1532368179-15263-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532368179-15263-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-pm@vger.kernel.org

With lockdep turned on, the following circular lock dependency problem
was reported:

[   57.470040] ======================================================
[   57.502900] WARNING: possible circular locking dependency detected
[   57.535208] 4.18.0-0.rc3.1.el8+7.x86_64+debug #1 Tainted: G
[   57.577761] ------------------------------------------------------
[   57.609714] tuned/1505 is trying to acquire lock:
[   57.633808] 00000000559deec5 (cpu_hotplug_lock.rw_sem){++++}, at: store+0x27/0x120
[   57.672880]
[   57.672880] but task is already holding lock:
[   57.702184] 000000002136ca64 (kn->count#118){++++}, at: kernfs_fop_write+0x1d0/0x410
[   57.742176]
[   57.742176] which lock already depends on the new lock.
[   57.742176]
[   57.785220]
[   57.785220] the existing dependency chain (in reverse order) is:
    :
[   58.932512] other info that might help us debug this:
[   58.932512]
[   58.973344] Chain exists of:
[   58.973344]   cpu_hotplug_lock.rw_sem --> subsys mutex#5 --> kn->count#118
[   58.973344]
[   59.030795]  Possible unsafe locking scenario:
[   59.030795]
[   59.061248]        CPU0                    CPU1
[   59.085377]        ----                    ----
[   59.108160]   lock(kn->count#118);
[   59.124935]                                lock(subsys mutex#5);
[   59.156330]                                lock(kn->count#118);
[   59.186088]   lock(cpu_hotplug_lock.rw_sem);
[   59.208541]
[   59.208541]  *** DEADLOCK ***

In the cpufreq_register_driver() function, the lock sequence is:

  cpus_read_lock --> kn->count

For the cpufreq sysfs store method, the lock sequence is:

  kn->count --> cpus_read_lock

These sequences are actually safe as they are taking a share lock on
cpu_hotplug_lock. However, the current lockdep code doesn't check for
share locking when detecting circular lock dependency.  Fixing that
could be a substantial effort.

Instead, we can work around this problem by using cpus_read_trylock()
in the store method which is much simpler. The chance of not getting
the read lock is extremely small. If that happens, the userspace
application that writes the sysfs file will get an error.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/cpufreq/cpufreq.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd32..9cf02d7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -922,8 +922,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
+	int retries = 3;
 
-	cpus_read_lock();
+	/*
+	 * cpus_read_trylock() is used here to work around a circular lock
+	 * dependency problem with respect to the cpufreq_register_driver().
+	 * With a simple retry loop, the chance of not able to get the
+	 * read lock is extremely small.
+	 */
+	while (!cpus_read_trylock()) {
+		if (retries-- <= 0)
+			return -EBUSY;
+		/*
+		 * Sleep for about 50ms and retry again.
+		 */
+		msleep(50);
+	}
 
 	if (cpu_online(policy->cpu)) {
 		down_write(&policy->rwsem);
-- 
1.8.3.1
