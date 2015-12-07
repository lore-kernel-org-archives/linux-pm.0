From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] cpufreq: Add ondemand as a generic policy
Date: Mon, 7 Dec 2015 15:04:32 +0530
Message-ID: <20151207093432.GF3294@ubuntu>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1449274118-15575-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36279 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbbLGJef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 04:34:35 -0500
Received: by pacdm15 with SMTP id dm15so122382897pac.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 01:34:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449274118-15575-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org

On 04-12-15, 16:08, Srinivas Pandruvada wrote:
> Allow ondemand policy as a supported generic policy. Client drivers can
> enable this policy by using get_available_policies() callback.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++++++
>  include/linux/cpufreq.h   | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
