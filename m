From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Wed, 7 Oct 2015 23:09:20 +0530
Message-ID: <20151007173920.GG4557@linux>
References: <1443807532.2845.25.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35640 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbbJGRj0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 13:39:26 -0400
Received: by pacfv12 with SMTP id fv12so27916934pac.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 10:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443807532.2845.25.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mike.turquette@linaro.org>

On 02-10-15, 18:38, Jon Medhurst (Tixy) wrote:
> The check for correct frequency being set in bL_cpufreq_set_rate is
> broken when the big.LITTLE switcher is active, for two reasons.
> 
> 1. The 'new_rate' variable gets overwritten before the test by the
> code calculating the frequency of the old cluster.
> 
> 2. The frequency returned by bL_cpufreq_get_rate will be the virtual
> frequency, not the actual one the intended version of new_rate contains.
> 
> This means the function always returns an error causing an endless
> stream of: "cpufreq: __target_index: Failed to change cpu frequency: -5"
> 
> As the comment for the test indicates that it is temporary and limited
> lets not bother fixing it to work when the bL switcher is active and
> instead just bypass the test in that case.
> 
> Fixes: 0a95e630b49a ("cpufreq: arm_big_little: check if the frequency is set correctly")
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

And why not fix it properly by doing this:

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index f1e42f8ce0fc..5b36657a76d6 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -128,7 +128,7 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
 static unsigned int
 bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 {
-	u32 new_rate, prev_rate;
+	u32 new_rate, prev_rate, target_rate;
 	int ret;
 	bool bLs = is_bL_switching_enabled();
 
@@ -140,9 +140,11 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		per_cpu(physical_cluster, cpu) = new_cluster;
 
 		new_rate = find_cluster_maxfreq(new_cluster);
+		target_rate = new_rate;
 		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
 	} else {
 		new_rate = rate;
+		target_rate = new_rate;
 	}
 
 	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
@@ -196,7 +198,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	 * be reading only the cached value anyway. This needs to  be removed
 	 * once clk core is fixed.
 	 */
-	if (bL_cpufreq_get_rate(cpu) != new_rate)
+	if (bL_cpufreq_get_rate(cpu) != target_rate)
 		return -EIO;
 	return 0;
 }

-- 
viresh
