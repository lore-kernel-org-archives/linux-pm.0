From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Thu, 08 Oct 2015 10:23:49 +0100
Message-ID: <1444296229.2847.9.camel@linaro.org>
References: <1443807532.2845.25.camel@linaro.org>
	 <20151007173920.GG4557@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from queue01a.mail.zen.net.uk ([212.23.3.234]:56790 "EHLO
	queue01a.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbbJHJXz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 05:23:55 -0400
In-Reply-To: <20151007173920.GG4557@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mike.turquette@linaro.org>

On Wed, 2015-10-07 at 23:09 +0530, Viresh Kumar wrote:
[...]
> And why not fix it properly by doing this:
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index f1e42f8ce0fc..5b36657a76d6 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -128,7 +128,7 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
>  static unsigned int
>  bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>  {
> -	u32 new_rate, prev_rate;
> +	u32 new_rate, prev_rate, target_rate;
>  	int ret;
>  	bool bLs = is_bL_switching_enabled();
>  
> @@ -140,9 +140,11 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>  		per_cpu(physical_cluster, cpu) = new_cluster;
>  
>  		new_rate = find_cluster_maxfreq(new_cluster);
> +		target_rate = new_rate;
>  		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
>  	} else {
>  		new_rate = rate;
> +		target_rate = new_rate;
>  	}
>  
>  	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
> @@ -196,7 +198,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>  	 * be reading only the cached value anyway. This needs to  be removed
>  	 * once clk core is fixed.
>  	 */
> -	if (bL_cpufreq_get_rate(cpu) != new_rate)
> +	if (bL_cpufreq_get_rate(cpu) != target_rate)
>  		return -EIO;
>  	return 0;
>  }

You call that a proper fix? ;-) It's comparing an 'virtual' frequency to
an 'actual' frequency.

If the real intent is to check that clk_set_rate works I would have
thought the patch below would be correct. But I didn't propose that as
it's the obvious implementation and I assumed the original patch didn't
do it that way for a reason.

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index f1e42f8..59115a4 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -149,6 +149,18 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 			__func__, cpu, old_cluster, new_cluster, new_rate);
 
 	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
+	if (!ret) {
+		/*
+		 * FIXME: clk_set_rate has to handle the case where clk_change_rate
+		 * can fail due to hardware or firmware issues. Until the clk core
+		 * layer is fixed, we can check here. In most of the cases we will
+		 * be reading only the cached value anyway. This needs to  be removed
+		 * once clk core is fixed.
+		 */
+		if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
+			ret = -EIO;
+	}
+
 	if (WARN_ON(ret)) {
 		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
 				new_cluster);
@@ -189,15 +201,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		mutex_unlock(&cluster_lock[old_cluster]);
 	}
 
-	/*
-	 * FIXME: clk_set_rate has to handle the case where clk_change_rate
-	 * can fail due to hardware or firmware issues. Until the clk core
-	 * layer is fixed, we can check here. In most of the cases we will
-	 * be reading only the cached value anyway. This needs to  be removed
-	 * once clk core is fixed.
-	 */
-	if (bL_cpufreq_get_rate(cpu) != new_rate)
-		return -EIO;
 	return 0;
 }
 



