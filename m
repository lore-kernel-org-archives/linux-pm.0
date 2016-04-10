From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Abort cpufreq_update_current_freq() for cpufreq_suspended set
Date: Sun, 10 Apr 2016 06:08:08 +0200
Message-ID: <1745622.RpCLJxTa46@vostro.rjw.lan>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan> <20160410031646.GI9674@vireshk-i7> <CAJZ5v0iDTTL5U5Btw7ioetgmiqoTB3m7F9C_BanEBxazLshBZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58397 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750699AbcDJEFe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2016 00:05:34 -0400
In-Reply-To: <CAJZ5v0iDTTL5U5Btw7ioetgmiqoTB3m7F9C_BanEBxazLshBZA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since governor operations are generally skipped if cpufreq_suspended
is set, cpufreq_start_governor() should do nothing in that case.

That function is called in the cpufreq_online() path, and may also
be called from cpufreq_offline() in some cases, which are invoked
by the nonboot CPUs disabing/enabling code during system suspend
to RAM and resume.  That happens when all devices have been
suspended, so if the cpufreq driver relies on things like I2C to
get the current frequency, it may not be ready to do that then.

To prevent problems from happening for this reason, make
cpufreq_update_current_freq(), which is the only function invoked
by cpufreq_start_governor() that doesn't check cpufreq_suspended
already, return 0 upfront if cpufreq_suspended is set.

Fixes: 3bbf8fe3ae08 (cpufreq: Always update current frequency before startig governor)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1565,6 +1565,9 @@ static unsigned int cpufreq_update_curre
 {
 	unsigned int new_freq;
 
+	if (cpufreq_suspended)
+		return 0;
+
 	new_freq = cpufreq_driver->get(policy->cpu);
 	if (!new_freq)
 		return 0;

