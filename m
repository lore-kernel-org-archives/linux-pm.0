From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/2] cpufreq: Sorted policy->freq_table
Date: Thu, 7 Jul 2016 08:36:38 -0700
Message-ID: <20160707153638.GC3932@ubuntu>
References: <cover.1467001203.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36152 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbcGGPgk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 11:36:40 -0400
Received: by mail-pf0-f178.google.com with SMTP id t190so7110060pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2016 08:36:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1467001203.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org

On 27-06-16, 09:59, Viresh Kumar wrote:
> Hi Rafael,
> 
> This series is aimed to make traversing of cpufreq table more efficient
> for platforms that already sort the frequency tables. The cpufreq core
> now checks if the freq table is sorted and applies a different set of
> helpers on such tables while traversing them.
> 
> All the patches are pushed here for testing in case anyone wants to try:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table
> 
> V4->V4:
> - s/cpufreq_table_find_index_unsorted/cpufreq_table_index_unsorted
> - return error for duplicate frequencies
> - freq-table-sorted is an enum now
> - Remove freq_is_invalid() and clamp the frequencies at the top of few
>   helpers.
> - Remove few checks which were impossible to hit (best == -1)

Thanks Rafael for applying this series.

@Steve: I think you are unblocked now (sorry for the long delay) to get your
work going.

-- 
viresh
