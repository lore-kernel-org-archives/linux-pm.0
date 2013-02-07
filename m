From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] cpufreq: Create a macro for unlock_policy_rwsem{read,
	write}
Date: Thu,  7 Feb 2013 15:57:45 +0530
Message-ID: <7b681ffe08aa44d93a81297c1fb6f7702c9c9b2b.1360232293.git.viresh.kumar@linaro.org>
References: <cover.1360232293.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1360232293.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1360232293.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1360232293.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org, valdis.kletnieks-PjAqaU27lzQ@public.gmane.org, artem.savkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On the lines of macro: lock_policy_rwsem, we can create another macro for
unlock_policy_rwsem. Lets do it.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 795b0e8..c46aed4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -70,8 +70,7 @@ static DEFINE_PER_CPU(int, cpufreq_policy_cpu);
 static DEFINE_PER_CPU(struct rw_semaphore, cpu_policy_rwsem);
 
 #define lock_policy_rwsem(mode, cpu)					\
-static int lock_policy_rwsem_##mode					\
-(int cpu)								\
+static int lock_policy_rwsem_##mode(int cpu)				\
 {									\
 	int policy_cpu = per_cpu(cpufreq_policy_cpu, cpu);		\
 	BUG_ON(policy_cpu == -1);					\
@@ -81,23 +80,18 @@ static int lock_policy_rwsem_##mode					\
 }
 
 lock_policy_rwsem(read, cpu);
-
 lock_policy_rwsem(write, cpu);
 
-static void unlock_policy_rwsem_read(int cpu)
-{
-	int policy_cpu = per_cpu(cpufreq_policy_cpu, cpu);
-	BUG_ON(policy_cpu == -1);
-	up_read(&per_cpu(cpu_policy_rwsem, policy_cpu));
-}
-
-static void unlock_policy_rwsem_write(int cpu)
-{
-	int policy_cpu = per_cpu(cpufreq_policy_cpu, cpu);
-	BUG_ON(policy_cpu == -1);
-	up_write(&per_cpu(cpu_policy_rwsem, policy_cpu));
+#define unlock_policy_rwsem(mode, cpu)					\
+static void unlock_policy_rwsem_##mode(int cpu)				\
+{									\
+	int policy_cpu = per_cpu(cpufreq_policy_cpu, cpu);		\
+	BUG_ON(policy_cpu == -1);					\
+	up_##mode(&per_cpu(cpu_policy_rwsem, policy_cpu));		\
 }
 
+unlock_policy_rwsem(read, cpu);
+unlock_policy_rwsem(write, cpu);
 
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
-- 
1.7.12.rc2.18.g61b472e
