From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] cpu/hotplug: Add a cpus_read_trylock() function
Date: Tue, 24 Jul 2018 14:26:04 -0400
Message-ID: <1532456765-17576-2-git-send-email-longman@redhat.com>
References: <1532456765-17576-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532456765-17576-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-pm@vger.kernel.org

There are use cases where it can be useful to have a cpus_read_trylock()
function to work around circular lock dependency problem involving
the cpu_hotplug_lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpu.h | 2 ++
 kernel/cpu.c        | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index a97a63e..e850bfe 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -103,6 +103,7 @@ static inline void cpu_maps_update_done(void)
 extern void cpus_write_unlock(void);
 extern void cpus_read_lock(void);
 extern void cpus_read_unlock(void);
+extern int  cpus_read_trylock(void);
 extern void lockdep_assert_cpus_held(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
@@ -115,6 +116,7 @@ static inline void cpus_write_lock(void) { }
 static inline void cpus_write_unlock(void) { }
 static inline void cpus_read_lock(void) { }
 static inline void cpus_read_unlock(void) { }
+static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938..307486b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -290,6 +290,12 @@ void cpus_read_lock(void)
 }
 EXPORT_SYMBOL_GPL(cpus_read_lock);
 
+int cpus_read_trylock(void)
+{
+	return percpu_down_read_trylock(&cpu_hotplug_lock);
+}
+EXPORT_SYMBOL_GPL(cpus_read_trylock);
+
 void cpus_read_unlock(void)
 {
 	percpu_up_read(&cpu_hotplug_lock);
-- 
1.8.3.1
