From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Wed, 14 Oct 2015 08:12:00 +0100
Message-ID: <1444806720.2691.15.camel@linaro.org>
References: <1443807532.2845.25.camel@linaro.org>
	 <20151007173920.GG4557@linux> <1444296229.2847.9.camel@linaro.org>
	 <561BB39A.4020400@arm.com> <1444720744.2686.10.camel@linaro.org>
	 <561CDEA9.7020700@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from queue01b.mail.zen.net.uk ([212.23.3.242]:50294 "EHLO
	queue01b.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbJNHMH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 03:12:07 -0400
In-Reply-To: <561CDEA9.7020700@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-10-13 at 11:36 +0100, Sudeep Holla wrote:
> 
> On 13/10/15 08:19, Jon Medhurst (Tixy) wrote:
[...]
> > But then we wouldn't get the WARN_ON and pr_err triggered when we detect
> > the clock rate isn't set, which surely is half the reason for the check
> > in the first place?
> >
> 
> Not sure if I understand what you mean or may be I was not clear, so
> thought I will put the delta here. Let me know if and how its still a 
> problem.
>
> diff --git i/drivers/cpufreq/arm_big_little.c 
> w/drivers/cpufreq/arm_big_little.c
> index f1e42f8ce0fc..05e850f80f39 100644
> --- i/drivers/cpufreq/arm_big_little.c
> +++ w/drivers/cpufreq/arm_big_little.c
> @@ -164,6 +164,16 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 
> new_cluster, u32 rate)
> 
>          mutex_unlock(&cluster_lock[new_cluster]);
> 
> +       /*
> +        * FIXME: clk_set_rate has to handle the case where clk_change_rate
> +        * can fail due to hardware or firmware issues. Until the clk core
> +        * layer is fixed, we can check here. In most of the cases we will
> +        * be reading only the cached value anyway. This needs to  be 
> removed
> +        * once clk core is fixed.
> +        */
> +       if (bL_cpufreq_get_rate(cpu) != new_rate)
> +               return -EIO;
> +
>          /* Recalc freq for old cluster when switching clusters */
>          if (old_cluster != new_cluster) {
>                  pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",

That's what I though you meant, and I can't see why you would want to do
that and bypass the error reporting for clk_get_rate failing. After all,
the code we're moving around is explicitly there to workaround the fact
that clk_set_rate doesn't actually pass through all errors, so it's
doing additional error checking. (At least, that's what the comment
says). So this looks more logical to me.

ret = clk_set_rate()
if(!ret)                         /* if no error from clk_set_rate   */
    if(clk_get_rate()!=correct)  /* but some additional checks fail */
        ret = -EIO;              /* then indicate an error anyway   */

if (WARN_ON(ret))                /* Warn if error setting rate and */
    pr_err("clk_set_rate failed")/* print and error too */


But if people want the if(clk_get_rate()!=correct) after the WARN_ON
then lets do that, the important thing is to get the code fixed.

-- 
Tixy

