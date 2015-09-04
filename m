From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 2/3] cpufreq: user_guide: update for base_frequency
Date: Fri,  4 Sep 2015 10:19:18 -0700
Message-ID: <1441387159-19860-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51149 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933048AbbIDRTi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 13:19:38 -0400
In-Reply-To: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Updated documentation for cpufreq attributes.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/user-guide.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index 109e97b..0326a8c 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -212,6 +212,10 @@ bios_limit :			If the BIOS tells the OS to limit a CPU to
 				which can be detected through the generic
 				thermal driver.
 
+base_frequency :		This shows base frequency of the cpu. Any
+				request above this is purely opportunistic, if
+				boost mode is enabled.
+
 If you have selected the "userspace" governor which allows you to
 set the CPU operating frequency to a specific value, you can read out
 the current frequency in
-- 
2.4.3

