From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] Documentation: thermal: document of_cpufreq_cooling_register()
Date: Tue,  6 Jan 2015 18:14:25 +0000
Message-ID: <1420568065-5153-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:56153 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbbAFSO6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 13:14:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Commit 39d99cff76bf ("thermal: cpu_cooling: introduce
of_cpufreq_cooling_register") taught the cpu cooling device to register
devices that were linked to the device tree but didn't update the
cpu-cooling-api documentation.  Fix it.

Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/cpu-cooling-api.txt | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
index fca24c931ec8..753e47cc2e20 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -3,7 +3,7 @@ CPU cooling APIs How To
 
 Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
 
-Updated: 12 May 2012
+Updated: 6 Jan 2015
 
 Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
 
@@ -25,7 +25,18 @@ the user. The registration APIs returns the cooling device pointer.
 
    clip_cpus: cpumask of cpus where the frequency constraints will happen.
 
-1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+1.1.2 struct thermal_cooling_device *of_cpufreq_cooling_register(
+	struct device_node *np, const struct cpumask *clip_cpus)
+
+    This interface function registers the cpufreq cooling device with
+    the name "thermal-cpufreq-%x" linking it with a device tree node, in
+    order to bind it via the thermal DT code. This api can support multiple
+    instances of cpufreq cooling devices.
+
+    np: pointer to the cooling device device tree node
+    clip_cpus: cpumask of cpus where the frequency constraints will happen.
+
+1.1.3 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
     This interface function unregisters the "thermal-cpufreq-%x" cooling device.
 
-- 
1.9.1

