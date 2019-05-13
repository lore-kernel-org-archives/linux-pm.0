From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Update MAINTAINERS to include schedutil governor
Date: Mon, 13 May 2019 12:40:33 +0530
Message-ID: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

List cpufreq maintainers as well for schedutil governor apart from
scheduler maintainers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4244dd341eb7..7d4417d862a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4093,7 +4093,9 @@ F:	Documentation/admin-guide/pm/intel_pstate.rst
 F:	Documentation/cpu-freq/
 F:	Documentation/devicetree/bindings/cpufreq/
 F:	drivers/cpufreq/
+F:	kernel/sched/cpufreq*.c
 F:	include/linux/cpufreq.h
+F:	include/linux/sched/cpufreq.h
 F:	tools/testing/selftests/cpufreq/
 
 CPU FREQUENCY DRIVERS - ARM BIG LITTLE
-- 
2.21.0.rc0.269.g1a574e7a288b
