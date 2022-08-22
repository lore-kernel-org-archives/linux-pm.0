Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57146C3F6B0
	for <linux-pm@archiver.kernel.org>; Mon, 22 Aug 2022 16:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiHVQBB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiHVQA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 12:00:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA8915A38;
        Mon, 22 Aug 2022 09:00:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A33C7ED1;
        Mon, 22 Aug 2022 09:00:59 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.75.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C728C3F70D;
        Mon, 22 Aug 2022 09:00:54 -0700 (PDT)
Date:   Mon, 22 Aug 2022 16:59:46 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org,
        kajetan.puchalski@arm.com
Subject: Re: [PATCH v2] cpufreq: check only freq_table in __resolve_freq()
Message-ID: <YwOn8rkvC1uUlxpn@e126311.manchester.arm.com>
References: <20220816120157.24455-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816120157.24455-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 16, 2022 at 01:01:57PM +0100, Lukasz Luba wrote:
> There is no need to check if the cpufreq driver implements callback
> cpufreq_driver::target_index. The logic in the __resolve_freq uses
> the frequency table available in the policy. It doesn't matter if the
> driver provides 'target_index' or 'target' callback. It just has to
> populate the 'policy->freq_table'.
> 
> Thus, check only frequency table during the frequency resolving call.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Changes:
> v2:
> - collected ACK from Viresh
> - corrected patch description (Viresh)

Just to stress how important this fix is, without this patch while
running tests on a Pixel 6 cpufreq was reporting frequencies that
were completely not aligned with the OPPs on the device and harming
performance in the process.

For instance, after applying the patch the average score in Geekbench 5
increased by over 130 (about 5%).

The average score in Speedometer 2 increased by about 6 (over 6%).

>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7820c4e74289..69b3d61852ac 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>  
>  	target_freq = clamp_val(target_freq, policy->min, policy->max);
>  
> -	if (!cpufreq_driver->target_index)
> +	if (!policy->freq_table)
>  		return target_freq;
>  
>  	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
> -- 
> 2.17.1
> 
