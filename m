From: James Geboski <jgeboski@gmail.com>
Subject: [PATCH] cpufreq: allow powersave governor as the default without expert mode
Date: Tue, 14 Oct 2014 17:38:09 -0400
Message-ID: <1413322689-6195-1-git-send-email-jgeboski@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:32821 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaJNVjs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Oct 2014 17:39:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, James Geboski <jgeboski@gmail.com>

The intel_pstate driver only supports the performance and the powersave
governors. With the performance governor ensuring the highest possible
performance settings, userspace tools fail to make any lasting changes.
In order to allow userspace tools to make modifications to the settings,
the powersave governor must be in use. This makes having the powersave
governor as the default convenient for systems where the intel_pstate
driver is being employed. Having to enable expert mode in the kernel
configuration is just a headache for such a trivial task.

This patch applies to all kernel versions 2.6.38 or greater after the
migration from CONFIG_EMBEDDED to CONFIG_EXPERT (6a108a14fa35). Most
importantly, this applies to kernel versions 3.9 or greater when the
intel_pstate driver was introduced.

Signed-off-by: James Geboski <jgeboski@gmail.com>
---
 drivers/cpufreq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 3489f8f..73df7db 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -63,7 +63,6 @@ config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 
 config CPU_FREQ_DEFAULT_GOV_POWERSAVE
 	bool "powersave"
-	depends on EXPERT
 	select CPU_FREQ_GOV_POWERSAVE
 	help
 	  Use the CPUFreq governor 'powersave' as default. This sets
-- 
2.1.2

