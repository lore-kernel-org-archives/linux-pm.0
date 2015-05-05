From: Wang Long <long.wanglong@huawei.com>
Subject: [PATCH] Documentation: cpu-freq: delete duplicate description of sysfs interface 'scaling_driver'
Date: Tue, 5 May 2015 01:22:26 +0000
Message-ID: <1430788946-56649-1-git-send-email-long.wanglong@huawei.com>
References: <2159903.qiTtABDclH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2159903.qiTtABDclH@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, linux@brodo.de, viresh.kumar@linaro.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, peifeiyue@huawei.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, long.wanglong@huawei.com
List-Id: linux-pm@vger.kernel.org

The file 'Documentation/cpu-freq/user-guide.txt' has duplicate
description of sysfs interface 'scaling_driver'.

[first]
scaling_driver :                this file shows what cpufreq driver is
				used to set the frequency on this CPU

[second]
scaling_driver :                Hardware driver for cpufreq.

Although this does not affect anything, I think we should only have
one. so delete the second one because the first one is described in
more detail.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 Documentation/cpu-freq/user-guide.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index ff2f283..109e97b 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -196,8 +196,6 @@ affected_cpus :			List of Online CPUs that require software
 related_cpus :			List of Online + Offline CPUs that need software
 				coordination of frequency.
 
-scaling_driver :		Hardware driver for cpufreq.
-
 scaling_cur_freq :		Current frequency of the CPU as determined by
 				the governor and cpufreq core, in KHz. This is
 				the frequency the kernel thinks the CPU runs
-- 
1.8.3.4
