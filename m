From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 19/19] cpufreq: documentation: document locking scheme
Date: Mon, 11 Jan 2016 17:36:00 +0000
Message-ID: <1452533760-13787-20-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

CPUFreq locking scheme is quite complicated. Provide some initial
documentation for it.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 Documentation/cpu-freq/core.txt | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
index ba78e7c..1838976 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.txt
@@ -21,6 +21,7 @@ Contents:
 1.  CPUFreq core and interfaces
 2.  CPUFreq notifiers
 3.  CPUFreq Table Generation with Operating Performance Point (OPP)
+4.  CPUFreq locking scheme for internal data structures
 
 1. General Information
 =======================
@@ -118,3 +119,46 @@ dev_pm_opp_init_cpufreq_table - cpufreq framework typically is initialized with
 	addition to CONFIG_PM_OPP.
 
 dev_pm_opp_free_cpufreq_table - Free up the table allocated by dev_pm_opp_init_cpufreq_table
+
+4. CPUFreq locking scheme for internal data structures
+======================================================
+CPUFreq locking scheme has to guarantee ordering and mutual exclusion on
+internal data structures while concurrent execution of CPU hotplug, OPP
+selection, governor changes and driver changes might happen.
+
+Data structures depicted in the following diagram (except policyX data
+structures, see below) are protected by cpufreq_ driver_lock RWLOCK (see
+beginning of cpufreq.c).
+
+ cpufreq_driver -> struct cpufreq_driver
+
+ cpufreq_cpu_data (per-CPU)
+
+                         +---+---+---+    +---+
+                         | 0 | 1 | 2 | .. |N-1|
+                         +-+-+-+-+-+-+    +-+-+
+                           |   |   |        |
+                           |---+   +--------+
+                           |                |
+                           |                |
+                           V                V
+ cpufreq_policy_list --> policy0 -- .. -> policy(N-1)-+
+                                                      |
+					              x
+
+Concurrent reads/updates of policyX data structures are guarded by policy->
+rwsem. The rules for this semaphore are (as also reported in include/linux/
+cpufreq.h):
+
+ - any routine that wants to read from the policy structure will
+   do a down_read on this semaphore;
+ - any routine that will write to the policy structure and/or may take away
+   the policy altogether (eg. CPU hotplug), will hold this lock in write
+   mode before doing so.
+
+We then have another list that keeps track of available governors and that is
+protected by cpufreq_governor_mutex MUTEX:
+
+ cpufreq_governor_list --> governor0 -- .. --> governor(N-1) -+
+                                                              |
+				                              x
-- 
2.2.2

