From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH 5/5] intel_pstate: Adjust default IIR filter gain.
Date: Sat, 11 Apr 2015 21:10:30 -0700
Message-ID: <1428811830-15006-6-git-send-email-dsmythies@telus.net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33522 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbDLELc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2015 00:11:32 -0400
Received: by pdbnk13 with SMTP id nk13so68262773pdb.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2015 21:11:31 -0700 (PDT)
In-Reply-To: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-pm@vger.kernel.org

A default IIR filter gain of 10 percent is
recommended. It best matches a rising edge step
function load increase response time to the
previous version of this driver. Although not by
a lot, it better damps lower frequency load / sleep
rate response oscillations.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 66e662d..a374309 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -626,7 +626,7 @@ static struct cpu_defaults core_params = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
 		.setpoint = 97,
-		.p_gain_pct = 20,
+		.p_gain_pct = 10,
 		.d_gain_pct = 0,
 		.i_gain_pct = 0,
 		.c0_ceiling = 950,
@@ -646,7 +646,7 @@ static struct cpu_defaults byt_params = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
 		.setpoint = 97,
-		.p_gain_pct = 20,
+		.p_gain_pct = 10,
 		.d_gain_pct = 0,
 		.i_gain_pct = 4,
 		.c0_ceiling = 950,
-- 
1.9.1

