From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] cpufreq: Documentation: Add missing optional properties
Date: Sat,  4 Oct 2014 20:20:58 +0000
Message-ID: <1412454058-17725-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51027 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaJDUVQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 Oct 2014 16:21:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, shawn.guo@freescale.com, Stefan Wahren <stefan.wahren@i2se.com>

The devicetree binding for cpufreq-cpu0 lacks the optional properties
clocks and cpu-supply. This patch adds them to the documentation.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
index 366690c..bafcaea 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
@@ -14,6 +14,8 @@ Optional properties:
 - operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt for
   details. OPPs *must* be supplied either via DT, i.e. this property, or
   populated at runtime.
+- clocks: Specify the CPU clock
+- cpu-supply: Specify the regulator which feeds the CPU
 - clock-latency: Specify the possible maximum transition latency for clock,
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
-- 
1.7.9.5

