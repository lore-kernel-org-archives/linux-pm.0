From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 04/16 v3] CPU CC update period is changeable via sysctl
Date: Fri, 30 May 2014 14:36:00 +0800
Message-ID: <1401431772-14320-5-git-send-email-yuyang.du@intel.com>
References: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, pjt@google.com, bsegall@google.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

sysctl_sched_cc_sum_period is the CC update period. Make it changable via
sysctl tool. In general, the longer this period, the stabler and slower to
respond to task concurrency change on this CPU.

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 include/linux/sched/sysctl.h |    4 ++++
 kernel/sysctl.c              |    9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 8045a55..f8a3e0a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -36,6 +36,10 @@ extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern unsigned int sysctl_sched_child_runs_first;
 
+#ifdef CONFIG_SMP
+extern unsigned int sysctl_sched_cc_sum_period;
+#endif
+
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 74f5b58..13aea95 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1090,6 +1090,15 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_SMP
+	{
+		.procname	= "sched_cc_sum_period",
+		.data		= &sysctl_sched_cc_sum_period,
+		.maxlen		= sizeof(sysctl_sched_cc_sum_period),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
 	{ }
 };
 
-- 
1.7.9.5
