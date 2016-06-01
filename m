From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Don't use cpufreq_frequency_get_table() if
 'policy' is available
Date: Wed, 1 Jun 2016 11:30:42 +0530
Message-ID: <20160601060042.GH3725@vireshk-i7>
References: <1983189261737014b1f83e5b455d9d76e3288748.1464745869.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36334 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189AbcFAGAq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 02:00:46 -0400
Received: by mail-pf0-f172.google.com with SMTP id f144so8245180pfa.3
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 23:00:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1983189261737014b1f83e5b455d9d76e3288748.1464745869.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 01-06-16, 07:23, Viresh Kumar wrote:
> Most of the callers of cpufreq_frequency_get_table() already have the
> pointer to a valid 'policy' structure and they don't really need to go
> through the per-cpu variable first and then a check to validate the
> frequency, in order to find the freq-table for the policy.
> 
> Directly use the policy->freq_table field instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Instead of adding a new routine, use policy->freq_table directly as
> there already are a lot of users who are doing it directly anyway.

Discard this one as well. More cleanup is possible, will send it
again.

-- 
viresh
