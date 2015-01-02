From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/17] cpufreq: update driver_data->flags only if we are registering driver
Date: Fri,  2 Jan 2015 12:34:30 +0530
Message-ID: <05f9c739f27a395152220a75963258e52183582e.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:64644 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHF3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:29 -0500
Received: by mail-pd0-f175.google.com with SMTP id g10so23299947pdj.20
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:28 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We should first check if a cpufreq driver is already registered or not before
updating driver_data->flags.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 35d4734ce856..9595107477a6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2427,9 +2427,6 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 
 	pr_debug("trying to register driver %s\n", driver_data->name);
 
-	if (driver_data->setpolicy)
-		driver_data->flags |= CPUFREQ_CONST_LOOPS;
-
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	if (cpufreq_driver) {
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
@@ -2438,6 +2435,9 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	if (driver_data->setpolicy)
+		driver_data->flags |= CPUFREQ_CONST_LOOPS;
+
 	if (cpufreq_boost_supported()) {
 		/*
 		 * Check if driver provides function to enable boost -
-- 
2.2.0

