From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 1/5] cpufreq, do not return stale data to userspace
Date: Wed,  5 Nov 2014 09:53:55 -0500
Message-ID: <1415199239-19019-2-git-send-email-prarit@redhat.com>
References: <1415199239-19019-1-git-send-email-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415199239-19019-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: robert.schoene@tu-dresden.de, sboyd@codeaurora.org, Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Consider the following case.  Two threads are executing on a system.
Thread 1 is reading from /sys/.../cpufreq/<files> and thread 2 is
changing the cpufreq governor through /sys/.../cpufreq/scaling_governor.

Thread 2 acquires the mutexes in the write path, cpufreq_rwsem and
policy->rwsem, while thread 1 waits.

Thread 2 completes the changing of the scaling governor and releases
the the mutexes.

Thread 1 now acquires the mutexes and returns incorrect data as the
governor has changed.

The kernel cannot guarantee the governor from which the data came from, so
the kernel should fail with -EBUSY when the governor is being written.
Changing the down_read(&policy->rwsem) to a trylock fixes this stale data
issue.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/cpufreq/cpufreq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 644b54e..3f09ca9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -765,7 +765,8 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return -EINVAL;
 
-	down_read(&policy->rwsem);
+	if (!down_read_trylock(&policy->rwsem))
+		return -EBUSY;
 
 	if (fattr->show)
 		ret = fattr->show(policy, buf);
-- 
1.7.9.3
