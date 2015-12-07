From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add configurable generic policies
Date: Mon, 7 Dec 2015 15:03:20 +0530
Message-ID: <20151207093320.GE3294@ubuntu>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1449274118-15575-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33872 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbbLGJdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 04:33:24 -0500
Received: by pacwq6 with SMTP id wq6so45057461pac.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 01:33:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449274118-15575-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org

On 04-12-15, 16:08, Srinivas Pandruvada wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 177c768..8259c3c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -76,6 +76,7 @@ struct cpufreq_policy {
>  	unsigned int		restore_freq; /* = policy->cur before transition */
>  	unsigned int		suspend_freq; /* freq to set during suspend */
>  
> +	u8			available_policies;

Why don't we let the set-policy drivers fill in this field? No
callback required then.

-- 
viresh
