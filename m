From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Ask for help on governor
Date: Fri, 15 Dec 2017 16:53:51 +0100
Message-ID: <6904035.5JZpTxp8PG@aspire.rjw.lan>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <20171213061759.GT25177@vireshk-i7> <002001d37577$9706a730$c513f590$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50621 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932247AbdLOPyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 10:54:37 -0500
In-Reply-To: <002001d37577$9706a730$c513f590$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Andy Tang' <andy.tang@nxp.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>

On Friday, December 15, 2017 8:37:38 AM CET Doug Smythies wrote:
> Hi Andy,
> 
> Could you please try the below reversion patch.
> It is on top of kernel 4.15-rc3.
> 
> On my system, and for the intel_cpufrequ scaling driver,
> the default sampling_rate goes back to 20000 (which works)
> from 500 uSec (which doesn't), for both the conservative
> and ondemand governors.

OK

So AFAICS the problem is that dbs_update() makes assumptions that are not
me, quite obviously, if the sampling interval is less than the tick period.

For example, the "time_elapsed > 2 * sampling_rate" condition in it may
very well trigger every time in that case and that obviously affects the
conservative governor.

What about the patch below, then?

---
 drivers/cpufreq/cpufreq_governor.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -430,7 +430,14 @@ int cpufreq_dbs_governor_init(struct cpu
 	if (ret)
 		goto free_policy_dbs_info;
 
+	/*
+	 * The sampling interval should not be greater than the transition
+	 * latency of the CPU, but it also cannot be less than the tick period
+	 * for dbs_update() to work correctly.
+	 */
 	dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
+	if (dbs_data->sampling_rate < TICK_NSEC * NSEC_PER_USEC)
+		dbs_data->sampling_rate = TICK_NSEC * NSEC_PER_USEC;
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
