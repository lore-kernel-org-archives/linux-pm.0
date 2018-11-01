From: Zhao Wei Liew <zhaoweiliew@gmail.com>
Subject: [PATCH] Documentation: cpufreq: Correct a typo
Date: Thu,  1 Nov 2018 01:32:46 +0000
Message-ID: <20181101013257.659-1-zhaoweiliew@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, trivial@kernel.org, Zhao Wei Liew <zhaoweiliew@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix a typo in the admin-guide documentation for cpufreq.

Signed-off-by: Zhao Wei Liew <zhaoweiliew@gmail.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 47153e64dfb5..7eca9026a9ed 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -150,7 +150,7 @@ data structures necessary to handle the given policy and, possibly, to add
 a governor ``sysfs`` interface to it.  Next, the governor is started by
 invoking its ``->start()`` callback.
 
-That callback it expected to register per-CPU utilization update callbacks for
+That callback is expected to register per-CPU utilization update callbacks for
 all of the online CPUs belonging to the given policy with the CPU scheduler.
 The utilization update callbacks will be invoked by the CPU scheduler on
 important events, like task enqueue and dequeue, on every iteration of the
-- 
2.11.0
