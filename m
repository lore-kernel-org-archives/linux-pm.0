From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] Documentation: cpufreq: Update supported powernv processors
Date: Fri, 16 Dec 2016 16:47:42 +0530
Message-ID: <1481887062-25522-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, corbet@lwn.net
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 Documentation/cpu-freq/user-guide.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index 109e97b..5e10d5f 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -87,7 +87,9 @@ UltraSPARC-III
 -------
 
 Several "PowerBook" and "iBook2" notebooks are supported.
-
+The following POWER processors are supported in powernv mode:
+POWER8
+POWER9
 
 1.5 SuperH
 ----------
-- 
1.8.3.1

